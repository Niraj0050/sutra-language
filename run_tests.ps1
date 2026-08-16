[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "       Sutra 1.0 Automated Test Runner & Verification" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan

# Step 1: Ensure Sutra is built
Write-Host "[1/3] Building Sutra compiler..." -ForegroundColor Yellow
& .\build.ps1
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Sutra build failed!" -ForegroundColor Red
    exit 1
}

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
        if ($f.Extension -ne ".exe" -and $f.Extension -ne ".s" -and $f.Extension -ne ".txt" -and $f.Extension -ne ".md" -and $f.Extension -ne ".o" -and $f.Extension -ne ".obj") {
            # Skip helper files intended only for importing by other tests
            if ($f.Name -notlike "*circular_*" -and $f.Name -notlike "*सहायक*") {
                $testFiles += $f.FullName.Substring($PWD.Path.Length + 1)
            }
        }
    }
}
if (Test-Path "परीक्षण.सूत्र") {
    $testFiles += "परीक्षण.सूत्र"
}
if (Test-Path "परीक्षण_इनपुट.सूत्र") {
    $testFiles += "परीक्षण_इनपुट.सूत्र"
}

$testFiles = $testFiles | Select-Object -Unique

Write-Host "`n[2/3] Executing test suite ($($testFiles.Count) test files)..." -ForegroundColor Yellow

# Input data map for interactive tests
$inputMap = @{
    "13_input" = "निरज`n"
    "परीक्षण_इनपुट" = "निरज`n22`n99.5`n3`n"
}

foreach ($filePath in $testFiles) {
    $fileName = [System.IO.Path]::GetFileNameWithoutExtension($filePath)
    
    # Skip module files
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
        if ([string]::IsNullOrEmpty($dir)) {
            $nativeExePath = $name + "_native.exe"
        } else {
            $nativeExePath = [System.IO.Path]::Combine($dir, $name + "_native.exe")
        }
        
        if (Test-Path $nativeExePath) {
            if ($inputData) {
                $nativeOutput = $inputData | & $nativeExePath 2>&1
            } else {
                $nativeOutput = & $nativeExePath 2>&1
            }
            $nativeExitCode = $LASTEXITCODE
            $nativeOutStr = ($nativeOutput | Out-String).Trim()
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
            if ($interpOutStr -match "वाक्य-विच्छेद" -or $interpOutStr -match "अक्षर-वाचन" -or $interpOutStr -match "अपेक्षितम्") {
                $compilerErrors++
            } else {
                $runtimeErrors++
            }
        }
    } else {
        if ($interpExitCode -eq 0) {
            $testPassed = $true
        } else {
            if ($interpOutStr -match "वाक्य-विच्छेद" -or $interpOutStr -match "अक्षर-वाचन" -or $interpOutStr -match "अपेक्षितम्") {
                $compilerErrors++
            } else {
                $runtimeErrors++
            }
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

Write-Host "`n========================================================" -ForegroundColor Cyan
Write-Host "         SUTRA 1.0 TEST SUITE SUMMARY" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "  TOTAL           : $totalTests"
Write-Host "  PASSED          : $passedTests" -ForegroundColor Green
$failColor = "Green"
if ($failedTests -gt 0) { $failColor = "Red" }
Write-Host "  FAILED          : $failedTests" -ForegroundColor $failColor
Write-Host "  PARITY MISMATCH : $parityMismatches" -ForegroundColor Magenta
Write-Host "  COMPILER ERRORS : $compilerErrors" -ForegroundColor Yellow
Write-Host "  RUNTIME ERRORS  : $runtimeErrors" -ForegroundColor Yellow

if ($failedTests -eq 0 -and $parityMismatches -eq 0) {
    Write-Host "`n[SUCCESS] SUTRA 1.0 STABILITY VERIFIED - All $totalTests tests passed cleanly." -ForegroundColor Green
    exit 0
} else {
    Write-Host "`n[FAILURE] SUTRA 1.0 STABILITY FAILED - $failedTests test(s) failed." -ForegroundColor Red
    exit 1
}
