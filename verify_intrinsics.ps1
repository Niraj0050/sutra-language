param([string]$Compiler = "")
# verify_intrinsics.ps1 - compile & run the low-level intrinsic tests
# ============================================================
# tests/intrinsics/*.सूत्र use raw-memory intrinsics (अंतर्_पढ़8 etc.)
# that only the native-asm self-hosted compiler understands, so they
# are NOT part of the interpreter-parity suite. Each test self-checks
# and prints "सर्वे उत्तीर्णाः" on success.
# Usage: verify_intrinsics.ps1 [-Compiler <path to a native-asm compiler exe>]
# ============================================================
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
$env:PATH = "C:\msys64\ucrt64\bin;$env:PATH"
Set-Location $PSScriptRoot

if (-not $Compiler) {
    $Compiler = Join-Path $PSScriptRoot "स्वसंकलक\मूल_संकलन_native.exe"
}
if (-not (Test-Path $Compiler)) { throw "compiler not found: $Compiler  (build it first, e.g. bootstrap.ps1)" }

$dir = Join-Path $PSScriptRoot "tests\intrinsics"
$pass = 0; $fail = 0
Get-ChildItem $dir -Recurse -Include "*_native.exe", "*.s", "*.o" | Remove-Item -Force -ErrorAction SilentlyContinue

foreach ($t in (Get-ChildItem $dir -File | Where-Object { $_.Extension -notin ".exe", ".s", ".o", ".md" })) {
    $src = Join-Path $dir $t.Name
    & $Compiler $src 2>&1 | Out-Null
    $exe = Get-ChildItem $dir -Filter "$($t.BaseName)*native*.exe" | Select-Object -First 1
    if (-not $exe) { Write-Host "  [FAIL] $($t.BaseName) (compile)" -ForegroundColor Red; $fail++; continue }
    $out = (& $exe.FullName 2>&1 | Out-String)
    if ($out -match "उत्तीर्णाः") {
        Write-Host "  [PASS] $($t.BaseName)" -ForegroundColor Green; $pass++
    }
    else {
        Write-Host "  [FAIL] $($t.BaseName)" -ForegroundColor Red
        ($out.Trim() -split "`n") | ForEach-Object { Write-Host "         $_" }
        $fail++
    }
}
Get-ChildItem $dir -Recurse -Include "*_native.exe", "*.s", "*.o" | Remove-Item -Force -ErrorAction SilentlyContinue
Write-Host "`n  PASS: $pass  FAIL: $fail"
if ($fail -gt 0) { exit 1 } else { exit 0 }
