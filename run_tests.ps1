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
$compilerErrors = 0
$runtimeErrors = 0

# Collect test files
$testFiles = @()

if (Test-Path "tests") {
    foreach ($f in (Get-ChildItem -Path "tests" -Recurse -File)) {
        if ($f.Extension -ne ".exe" -and $f.Extension -ne ".s" -and $f.Extension -ne ".txt" -and $f.Extension -ne ".md") {
            # Skip helper files intended only for importing by other tests
            if ($f.Name -notlike "*circular_*" -and $f.Name -notlike "*सहायक*") {
                $testFiles += $f.FullName
            }
        }
    }
}
if (Test-Path "परीक्षण.सूत्र") {
    $testFiles += (Resolve-Path "परीक्षण.सूत्र").Path
}
if (Test-Path "परीक्षण_इनपुट.सूत्र") {
    $testFiles += (Resolve-Path "परीक्षण_इनपुट.सूत्र").Path
}

$testFiles = $testFiles | Select-Object -Unique

Write-Host "`n[2/3] Executing test suite ($($testFiles.Count) test files)..." -ForegroundColor Yellow

# Input data map for interactive tests
$inputMap = @{
    "13_input" = "निरज`n"
    "परीक्षण_इनपुट" = "निरज`n22`n99.5`n3`n"
}

foreach ($filePath in $testFiles) {
    $totalTests++
    $fileName = [System.IO.Path]::GetFileNameWithoutExtension($filePath)
    $isNegativeTest = $filePath -like "*\negative\*" -or $filePath -like "*/negative/*"
    $inputData = ""

    foreach ($key in $inputMap.Keys) {
        if ($fileName -like "*$key*") {
            $inputData = $inputMap[$key]
            break
        }
    }

    if ($inputData) {
        $output = $inputData | & $sutraExe "$filePath" 2>&1
    } else {
        $output = & $sutraExe "$filePath" 2>&1
    }
    $exitCode = $LASTEXITCODE
    $outStr = ($output | Out-String).Trim()

    if ($isNegativeTest) {
        # Negative Test: Must produce error and exit with non-zero code
        if ($exitCode -ne 0 -and $outStr.Length -gt 0) {
            Write-Host "  [PASS-NEG] $fileName" -ForegroundColor Green
            $passedTests++
            if ($outStr -match "वाक्य-विच्छेद" -or $outStr -match "अक्षर-वाचन" -or $outStr -match "अपेक्षितम्") {
                $compilerErrors++
            } else {
                $runtimeErrors++
            }
        } else {
            Write-Host "  [FAIL-NEG] $fileName (Expected error, but exit code was $exitCode)" -ForegroundColor Red
            Write-Host "             Output: $outStr" -ForegroundColor Yellow
            $failedTests++
        }
    } else {
        # Positive Test: Must execute cleanly with exit code 0
        if ($exitCode -eq 0) {
            Write-Host "  [PASS] $fileName" -ForegroundColor Green
            $passedTests++
        } else {
            Write-Host "  [FAIL] $fileName (Exit code: $exitCode)" -ForegroundColor Red
            if ($outStr -match "वाक्य-विच्छेद" -or $outStr -match "अक्षर-वाचन" -or $outStr -match "अपेक्षितम्") {
                Write-Host "         Category: COMPILER ERROR" -ForegroundColor Yellow
                $compilerErrors++
            } else {
                Write-Host "         Category: RUNTIME ERROR" -ForegroundColor Yellow
                $runtimeErrors++
            }
            Write-Host "         Error: $outStr" -ForegroundColor Red
            $failedTests++
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
Write-Host "  COMPILER ERRORS : $compilerErrors" -ForegroundColor Yellow
Write-Host "  RUNTIME ERRORS  : $runtimeErrors" -ForegroundColor Yellow

if ($failedTests -eq 0) {
    Write-Host "`n[SUCCESS] SUTRA 1.0 STABILITY VERIFIED - All $totalTests tests passed cleanly." -ForegroundColor Green
    exit 0
} else {
    Write-Host "`n[FAILURE] SUTRA 1.0 STABILITY FAILED - $failedTests test(s) failed." -ForegroundColor Red
    exit 1
}
