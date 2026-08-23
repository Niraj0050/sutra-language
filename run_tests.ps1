[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "       Sutra 1.0 Automated Test Runner & Verification" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan

# Step 1: Build all targets
Write-Host "`n[1/4] Rebuilding all project binaries..." -ForegroundColor Yellow
& .\build.ps1
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Rebuilding binaries failed!" -ForegroundColor Red
    exit 1
}

# Step 2: Execute C++ Unit Tests
Write-Host "`n[2/4] Executing C++ Unit Tests..." -ForegroundColor Yellow

Write-Host "[test] Running core C++ tests (test_sutra.exe)..." -ForegroundColor Yellow
& .\test_sutra.exe
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Core C++ tests failed!" -ForegroundColor Red
    exit 1
}
Write-Host "[test] Core C++ tests passed successfully!" -ForegroundColor Green

Write-Host "[test] Running toolchain C++ tests (test_toolchain.exe)..." -ForegroundColor Yellow
& .\test_toolchain.exe
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Toolchain C++ tests failed!" -ForegroundColor Red
    exit 1
}
Write-Host "[test] Toolchain C++ tests passed successfully!" -ForegroundColor Green

Write-Host "[test] Running LSP C++ integration tests (test_lsp_integration.exe)..." -ForegroundColor Yellow
& .\test_lsp_integration.exe
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] LSP integration C++ tests failed!" -ForegroundColor Red
    exit 1
}
Write-Host "[test] LSP integration C++ tests passed successfully!" -ForegroundColor Green


# Step 3: Executing Stability & Parity Suite
$sutraExe = Resolve-Path ".\sutra.exe"
$totalTests = 0
$passedTests = 0
$failedTests = 0
$parityMismatches = 0
$compilerErrors = 0
$runtimeErrors = 0

# Collect test files
$testFiles = @()
if (Test-Path "tests") {
    foreach ($f in (Get-ChildItem -Path "tests" -Recurse -File)) {
        if ($f.Extension -ne ".exe" -and $f.Extension -ne ".s" -and $f.Extension -ne ".txt" -and $f.Extension -ne ".md" -and $f.Extension -ne ".o" -and $f.Extension -ne ".obj" -and $f.Extension -ne ".cpp" -and $f.Extension -ne ".h") {
            if ($f.Name -notlike "*circular_*" -and $f.Name -notlike "*सहायक*") {
                $testFiles += $f.FullName.Substring($PWD.Path.Length + 1)
            }
        }
    }
}
if (Test-Path "परीक्षण.सूत्र") { $testFiles += "परीक्षण.सूत्र" }
if (Test-Path "परीक्षण_इनपुट.सूत्र") { $testFiles += "परीक्षण_इनपुट.सूत्र" }

$testFiles = $testFiles | Select-Object -Unique

Write-Host "`n[3/4] Executing Stability & Parity Suite ($($testFiles.Count) test files)..." -ForegroundColor Yellow
$inputMap = @{
    "13_input" = "निरज`n"
    "परीक्षण_इनपुट" = "निरज`n22`n99.5`n3`n"
}

foreach ($filePath in $testFiles) {
    $fileName = [System.IO.Path]::GetFileNameWithoutExtension($filePath)
    if ($fileName -eq "गणित_सहायक" -or $fileName -match "^circular_[ab]$" -or $fileName -eq "module_a" -or $fileName -eq "module_b") {
        continue
    }

    $totalTests++
    $isNegativeTest = $filePath -like "*\negative\*" -or $filePath -like "*/negative/*"
    $inputData = ""
    foreach ($key in $inputMap.Keys) {
        if ($fileName -like "*$key*") {
            $inputData = $inputMap[$key]
            break
        }
    }

    # RUN INTERPRETER
    if ($inputData) {
        $interpOutput = $inputData | & $sutraExe "$filePath" 2>&1
    } else {
        $interpOutput = & $sutraExe "$filePath" 2>&1
    }
    $interpExitCode = $LASTEXITCODE
    $interpOutStr = ($interpOutput | Out-String).Trim()

    # RUN NATIVE COMPILER
    $buildOutput = & $sutraExe build "$filePath" 2>&1
    $buildExitCode = $LASTEXITCODE
    
    if ($buildExitCode -ne 0) {
        $nativeOutStr = "COMPILER_ERROR: " + ($buildOutput | Out-String).Trim()
        $nativeExitCode = $buildExitCode
    } else {
        $dir = [System.IO.Path]::GetDirectoryName($filePath)
        $name = [System.IO.Path]::GetFileNameWithoutExtension($filePath)
        $nativeExePath = if ([string]::IsNullOrEmpty($dir)) { ".\" + $name + "_native.exe" } else { [System.IO.Path]::Combine($dir, $name + "_native.exe") }
        
        if (Test-Path $nativeExePath) {
            if ($inputData) { $nativeOutput = $inputData | & $nativeExePath 2>&1 } else { $nativeOutput = & $nativeExePath 2>&1 }
            $nativeExitCode = $LASTEXITCODE
            $nativeOutStr = ($nativeOutput | Out-String).Trim()
            Remove-Item $nativeExePath -Force -ErrorAction SilentlyContinue
        } else {
            $nativeOutStr = "COMPILER_ERROR: EXE NOT PRODUCED"
            $nativeExitCode = -1
        }
    }

    # PARITY CHECK
    $parityMatch = ($interpExitCode -eq $nativeExitCode)
    $testPassed = $false
    if ($isNegativeTest) {
        if ($interpExitCode -ne 0 -and $interpOutStr.Length -gt 0) {
            $testPassed = $true
            if ($interpOutStr -match "वाक्य-विच्छेद" -or $interpOutStr -match "अक्षर-वाचन" -or $interpOutStr -match "अपेक्षितम्") { $compilerErrors++ } else { $runtimeErrors++ }
        }
    } else {
        if ($interpExitCode -eq 0) {
            $testPassed = $true
        } else {
            if ($interpOutStr -match "वाक्य-विच्छेद" -or $interpOutStr -match "अक्षर-वाचन" -or $interpOutStr -match "अपेक्षितम्") { $compilerErrors++ } else { $runtimeErrors++ }
        }
    }

    if ($testPassed -and $parityMatch) {
        $passedTests++
        Write-Host "  [PASS] $fileName (Parity Match)" -ForegroundColor Green
    } else {
        $failedTests++
        if (-not $testPassed) {
            Write-Host "  [FAIL] $fileName (Exit code: $interpExitCode)" -ForegroundColor Red
            Write-Host "         Error: $interpOutStr" -ForegroundColor Red
        }
        if (-not $parityMatch) {
            $parityMismatches++
            Write-Host "  [PARITY MISMATCH] $fileName" -ForegroundColor Magenta
            Write-Host "         Interpreter Exit: $interpExitCode, Native Exit: $nativeExitCode" -ForegroundColor Yellow
            Write-Host "         Interpreter Out:  $interpOutStr" -ForegroundColor Yellow
            Write-Host "         Native Out:       $nativeOutStr" -ForegroundColor Yellow
        }
    }
}


# Step 4: Execute M4 Tools CLI Integration Tests
Write-Host "`n[4/4] Executing M4 Tools CLI Integration Tests..." -ForegroundColor Yellow

$formatterExe = Resolve-Path ".\sutra_formatter.exe"
$linterExe = Resolve-Path ".\sutra_linter.exe"
$debuggerExe = Resolve-Path ".\sutra_debugger.exe"
$pkgmgrExe = Resolve-Path ".\sutra_pkgmgr.exe"
$buildExe = Resolve-Path ".\sutra_build.exe"

# 1. Formatter CLI Integration Test
Write-Host "[integration] Testing sutra_formatter..." -ForegroundColor Yellow
$tempFmtFile = "temp_fmt_test.सूत्र"
"कार्य मुख्य() {`nमान क=1+2;`n}" | Out-File -Encoding utf8 $tempFmtFile

# Check unformatted exits non-zero (diagnostic warning exit code: 2)
$checkOut1 = & $formatterExe --check $tempFmtFile 2>&1
if ($LASTEXITCODE -ne 2) {
    Write-Host "[ERROR] Formatter check failed on unformatted file. Exit code was $LASTEXITCODE (expected 2)." -ForegroundColor Red
    Remove-Item $tempFmtFile -Force
    exit 1
}

# Write formats file
$writeOut = & $formatterExe --write $tempFmtFile 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Formatter write failed. Exit code was $LASTEXITCODE (expected 0)." -ForegroundColor Red
    Remove-Item $tempFmtFile -Force
    exit 1
}

# Check formatted exits zero
$checkOut2 = & $formatterExe --check $tempFmtFile 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Formatter check failed on formatted file. Exit code was $LASTEXITCODE (expected 0)." -ForegroundColor Red
    Remove-Item $tempFmtFile -Force
    exit 1
}
Remove-Item $tempFmtFile -Force
Write-Host "  - Formatter CLI test passed." -ForegroundColor Green

# 2. Linter CLI Integration Test
Write-Host "[integration] Testing sutra_linter..." -ForegroundColor Yellow
$tempLintFile = "temp_lint_test.सूत्र"
"कार्य मुख्य() {`nमान अ = 10;`n}" | Out-File -Encoding utf8 $tempLintFile

# Exits non-zero (diagnostic error/warning exit code: 2)
$lintOut = & $linterExe $tempLintFile 2>&1
if ($LASTEXITCODE -ne 2) {
    Write-Host "[ERROR] Linter failed on unused variable code. Exit code was $LASTEXITCODE (expected 2)." -ForegroundColor Red
    Remove-Item $tempLintFile -Force
    exit 1
}
Remove-Item $tempLintFile -Force
Write-Host "  - Linter CLI test passed." -ForegroundColor Green

# 3. Package Manager CLI Integration Test
Write-Host "[integration] Testing sutra_pkgmgr..." -ForegroundColor Yellow
$tempPkgDir = "temp_pkg_integration"
New-Item -ItemType Directory -Path $tempPkgDir | Out-Null
Push-Location $tempPkgDir

# Init manifest
$initOut = & $pkgmgrExe init "एकीकरण_संकुल" 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Package Manager init failed." -ForegroundColor Red
    Pop-Location; Remove-Item -Recurse -Force $tempPkgDir; exit 1
}

# List packages
$listOut = (& $pkgmgrExe list 2>&1 | Out-String).Trim()
if ($LASTEXITCODE -ne 0 -or $listOut -notmatch "No packages installed") {
    Write-Host "[ERROR] Package Manager list failed." -ForegroundColor Red
    Pop-Location; Remove-Item -Recurse -Force $tempPkgDir; exit 1
}

# Verify dependencies
$installOut = & $pkgmgrExe install 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Package Manager install validation failed." -ForegroundColor Red
    Pop-Location; Remove-Item -Recurse -Force $tempPkgDir; exit 1
}

Pop-Location
Remove-Item -Recurse -Force $tempPkgDir
Write-Host "  - Package Manager CLI test passed." -ForegroundColor Green

# 4. Build System CLI Integration Test
Write-Host "[integration] Testing sutra_build..." -ForegroundColor Yellow
$tempBuildDir = "temp_build_integration"
New-Item -ItemType Directory -Path $tempBuildDir | Out-Null
Push-Location $tempBuildDir

# Init manifest and entry point
& $pkgmgrExe init "परीक्षण_संकुल" 2>&1 | Out-Null
'कार्य मुख्य() { लिखतु("BUILD_SUCCESS"); }' | Out-File -Encoding utf8 मुख्य.सूत्र

# Run Build
$buildRes = & $buildExe build 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Build System compile failed." -ForegroundColor Red
    Pop-Location; Remove-Item -Recurse -Force $tempBuildDir; exit 1
}

# Execute compiled output
if (Test-Path "निर्माण/मुख्य.exe") {
    $execOut = & "निर्माण/मुख्य.exe" 2>&1
    if ($execOut -notmatch "BUILD_SUCCESS") {
        Write-Host "[ERROR] Built executable produced wrong output: $execOut" -ForegroundColor Red
        Pop-Location; Remove-Item -Recurse -Force $tempBuildDir; exit 1
    }
} else {
    Write-Host "[ERROR] Built executable 'निर्माण/मुख्य.exe' was not produced." -ForegroundColor Red
    Pop-Location; Remove-Item -Recurse -Force $tempBuildDir; exit 1
}

# Clean build folder
& $buildExe clean 2>&1 | Out-Null
if (Test-Path "निर्माण") {
    Write-Host "[ERROR] Build clean failed to remove build folder." -ForegroundColor Red
    Pop-Location; Remove-Item -Recurse -Force $tempBuildDir; exit 1
}

Pop-Location
Remove-Item -Recurse -Force $tempBuildDir
Write-Host "  - Build System CLI test passed." -ForegroundColor Green


# SUMMARY PRINT
Write-Host "`n========================================================" -ForegroundColor Cyan
Write-Host "         SUTRA 1.0 TEST SUITE SUMMARY" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "  TOTAL STABILITY TESTS : $totalTests"
Write-Host "  PASSED                : $passedTests" -ForegroundColor Green
$failColor = if ($failedTests -gt 0) { "Red" } else { "Green" }
Write-Host "  FAILED                : $failedTests" -ForegroundColor $failColor
Write-Host "  PARITY MISMATCH       : $parityMismatches" -ForegroundColor Magenta
Write-Host "  COMPILER ERRORS       : $compilerErrors" -ForegroundColor Yellow
Write-Host "  RUNTIME ERRORS        : $runtimeErrors" -ForegroundColor Yellow

if ($failedTests -eq 0 -and $parityMismatches -eq 0) {
    Write-Host "`n[SUCCESS] SUTRA 1.0 STABILITY VERIFIED - All verification suites passed cleanly!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "`n[FAILURE] SUTRA 1.0 STABILITY FAILED - Some verification tests failed." -ForegroundColor Red
    exit 1
}
