[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "       Sutra Native Compiler Verification Tool" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan

$sutraExe = Resolve-Path ".\sutra.exe"        # interpreter (reference output)
$nativeCompiler = Resolve-Path ".\sutrac.exe" # self-hosted native compiler (`sutra.exe build`
                                               # is retired — its C++ codegen predates the
                                               # freestanding तल.s runtime and now conflicts with it)
$compilerDir = "tests\compiler"
$total = 0
$passed = 0
$failed = 0

# 1. Clean up old binaries
Get-ChildItem -Path $compilerDir -Recurse -Include "*_native.exe", "*.s", "*.o" | Remove-Item -Force

# 2. Find positive tests
$positiveTests = @()
foreach ($f in (Get-ChildItem -Path $compilerDir -File)) {
    if ($f.Extension -ne ".exe" -and $f.Extension -ne ".s" -and $f.Extension -ne ".o" -and $f.Extension -ne ".txt" -and $f.Extension -ne ".md") {
        $positiveTests += $f
    }
}

Write-Host "`nRunning positive compiler tests..." -ForegroundColor Yellow

foreach ($test in $positiveTests) {
    $total++
    $name = $test.BaseName
    $relPath = "$compilerDir\$($test.Name)"
    
    # Run in interpreter mode
    $interpreterOut = & $sutraExe $relPath 2>&1 | Out-String
    $interpreterExit = $LASTEXITCODE
    
    # Compile natively
    $compileOut = & $nativeCompiler $relPath 2>&1 | Out-String
    $compileExit = $LASTEXITCODE
    
    if ($compileExit -ne 0) {
        Write-Host "  [FAIL] $name (Compilation failed)" -ForegroundColor Red
        Write-Host "         Output: $compileOut" -ForegroundColor Yellow
        $failed++
        continue
    }
    
    $nativeExe = Join-Path $compilerDir "$($test.Name)_native.exe"
    if (-not (Test-Path $nativeExe)) {
        Write-Host "  [FAIL] $name (Native executable not found)" -ForegroundColor Red
        $failed++
        continue
    }
    
    # Run native executable
    $process = Start-Process -FilePath $nativeExe -NoNewWindow -Wait -PassThru -RedirectStandardOutput "out.txt" -RedirectStandardError "err.txt"
    $nativeExit = $process.ExitCode
    $nativeOut = (Get-Content "out.txt" -Encoding UTF8 -ErrorAction SilentlyContinue | Out-String) + (Get-Content "err.txt" -Encoding UTF8 -ErrorAction SilentlyContinue | Out-String)
    Remove-Item "out.txt", "err.txt" -ErrorAction SilentlyContinue
    
    if ($nativeExit -ne 0) {
        Write-Host "  [FAIL] $name (Native execution crashed with exit code $nativeExit)" -ForegroundColor Red
        Write-Host "         Native Output: $nativeOut" -ForegroundColor Yellow
        $failed++
        continue
    }
    
    # Compare outputs
    $intTrimmed = $interpreterOut.Trim() -replace "`r`n", "`n"
    $natTrimmed = $nativeOut.Trim() -replace "`r`n", "`n"
    
    if ($intTrimmed -eq $natTrimmed) {
        Write-Host "  [PASS] $name" -ForegroundColor Green
        $passed++
    } else {
        Write-Host "  [FAIL] $name (Output mismatch)" -ForegroundColor Red
        Write-Host "         Interpreter Output:`n$intTrimmed" -ForegroundColor Yellow
        Write-Host "         Native Output:`n$natTrimmed" -ForegroundColor Yellow
        $failed++
    }
}

# 3. Find negative tests
$negativeTests = @()
if (Test-Path "$compilerDir\negative") {
    foreach ($f in (Get-ChildItem -Path "$compilerDir\negative" -File)) {
        if ($f.Extension -ne ".exe" -and $f.Extension -ne ".s" -and $f.Extension -ne ".o" -and $f.Extension -ne ".txt" -and $f.Extension -ne ".md") {
            $negativeTests += $f
        }
    }
}

if ($negativeTests.Count -gt 0) {
    Write-Host "`nRunning negative compiler tests..." -ForegroundColor Yellow
    foreach ($test in $negativeTests) {
        $total++
        $name = "negative/$($test.BaseName)"
        $relPath = "$compilerDir\negative\$($test.Name)"
        
        # Compile natively
        $compileOut = & $nativeCompiler $relPath 2>&1 | Out-String
        $compileExit = $LASTEXITCODE
        
        if ($compileExit -ne 0) {
            Write-Host "  [FAIL] $name (Compilation failed)" -ForegroundColor Red
            $failed++
            continue
        }
        
        $nativeExe = Join-Path "$compilerDir\negative" "$($test.Name)_native.exe"
        if (-not (Test-Path $nativeExe)) {
            Write-Host "  [FAIL] $name (Native executable not found)" -ForegroundColor Red
            $failed++
            continue
        }
        
        # Run native executable — must exit with non-zero code (due to runtime panic)
        $process = Start-Process -FilePath $nativeExe -NoNewWindow -Wait -PassThru -RedirectStandardOutput "out.txt" -RedirectStandardError "err.txt"
        $nativeExit = $process.ExitCode
        $nativeOut = (Get-Content "out.txt" -Encoding UTF8 -ErrorAction SilentlyContinue | Out-String) + (Get-Content "err.txt" -Encoding UTF8 -ErrorAction SilentlyContinue | Out-String)
        Remove-Item "out.txt", "err.txt" -ErrorAction SilentlyContinue
        
        if ($nativeExit -ne 0 -and $nativeOut.Trim().Length -gt 0) {
            Write-Host "  [PASS] $name (Runtime check caught error: $($nativeOut.Trim()))" -ForegroundColor Green
            $passed++
        } else {
            Write-Host "  [FAIL] $name (Expected non-zero exit code and error message, got exit code $nativeExit)" -ForegroundColor Red
            Write-Host "         Output: $nativeOut" -ForegroundColor Yellow
            $failed++
        }
    }
}

# 4. Clean up after tests
Get-ChildItem -Path $compilerDir -Recurse -Include "*_native.exe", "*.s", "*.o" | Remove-Item -Force

Write-Host "`n========================================================" -ForegroundColor Cyan
Write-Host "         NATIVE COMPILER VERIFICATION SUMMARY" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "  TOTAL  : $total"
Write-Host "  PASSED : $passed" -ForegroundColor Green
$failColor = if ($failed -gt 0) { "Red" } else { "Green" }
Write-Host "  FAILED : $failed" -ForegroundColor $failColor

if ($failed -eq 0) {
    Write-Host "`n[SUCCESS] SUTRA NATIVE COMPILER VERIFIED - All tests passed." -ForegroundColor Green
    exit 0
} else {
    Write-Host "`n[FAILURE] SUTRA NATIVE COMPILER VERIFICATION FAILED." -ForegroundColor Red
    exit 1
}
