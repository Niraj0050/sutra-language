param([string]$Compiler = "")
# verify_ir.ps1 — मध्यम (IR) + निम्नक (lowering) + अनुकूलक (passes) के unit tests
# हर test असली lexer/parser से source बनाता है, फिर IR डंप पर assertions।
# चलाओ:  verify_ir.ps1 [-Compiler <native-asm संकलक exe>]
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
$env:PATH = "C:\msys64\ucrt64\bin;$env:PATH"
Set-Location $PSScriptRoot

if (-not $Compiler) { $Compiler = Join-Path $PSScriptRoot "sutrac.exe" }
if (-not (Test-Path $Compiler)) { throw "compiler not found: $Compiler (bootstrap.ps1 पहले चलाओ)" }

$tests = @("मध्यम_परीक्षण", "मूल_निम्नक_परीक्षण", "अनुकूलक_परीक्षण", "रजि_नियतक_परीक्षण", "बिंदु_विश्लेषण_परीक्षण", "लूप_अनुकूलन_परीक्षण")
$pass = 0; $fail = 0
foreach ($t in $tests) {
    $src = Join-Path $PSScriptRoot "स्वसंकलक\$t.सूत्र"
    Remove-Item "sutra_native_temp.s" -ErrorAction SilentlyContinue
    & $Compiler $src 2>&1 | Out-Null
    $exe = Join-Path $PSScriptRoot "स्वसंकलक\$t.सूत्र_native.exe"
    if (-not (Test-Path $exe)) { Write-Host "  [FAIL] $t (compile)" -ForegroundColor Red; $fail++; continue }
    $out = (& $exe 2>&1 | Out-String)
    Get-ChildItem "स्वसंकलक" -Filter "$t.सूत्र_native*" | Remove-Item -Force -ErrorAction SilentlyContinue
    if ($out -match "सर्वे उत्तीर्णाः") {
        $n = ([regex]::Matches($out, "  ठीक")).Count
        Write-Host "  [PASS] $t  ($n checks)" -ForegroundColor Green; $pass++
    } else {
        Write-Host "  [FAIL] $t" -ForegroundColor Red
        ($out -split "`n" | Where-Object { $_ -match "विफल" }) | ForEach-Object { Write-Host "         $_" }
        $fail++
    }
}
Write-Host "`n  PASS: $pass  FAIL: $fail"
if ($fail -gt 0) { exit 1 }
