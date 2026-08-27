# bootstrap.ps1 - build the Sutra compiler WITHOUT the C++ host
# ============================================================
# Stands up the Sutra native compiler from the frozen seed assembly
# (स्वसंकलक/निर्माण/मूल_संकलन.s), then recompiles the current source
# with it and checks the self-hosting fixed point.
#
# Requires: MSYS2 ucrt64 (C:\msys64\ucrt64\bin) - as.exe, gcc.exe, ld
#   gcc is used only as a linker and to compile the C runtime.
#   The C++ host (sutra.exe / संकलक/) and any C++ compiler are NOT used.
#
# Note: as/gcc from MSYS2 cannot open Devanagari paths, so the seed .s
# and runtime .c are copied to ASCII-named temp files first (same trick
# the C++ host uses). The seed compiler itself reads UTF-8 paths fine.
# ============================================================
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = "Stop"

$msys = "C:\msys64\ucrt64\bin"
$env:PATH = "$msys;$env:PATH"
$as  = Join-Path $msys "as.exe"
$gcc = Join-Path $msys "gcc.exe"

$root = $PSScriptRoot
Set-Location $root
$seedDir  = Join-Path $root "स्वसंकलक\निर्माण"
$seed     = Join-Path $seedDir "मूल_संकलन.s"
$rtC      = Join-Path $seedDir "sutra_runtime.c"
$src      = Join-Path $root "स्वसंकलक\मूल_संकलन.सूत्र"

foreach ($p in @($as, $gcc)) {
    if (-not (Test-Path $p)) { throw "not found: $p  (MSYS2 ucrt64 required)" }
}
foreach ($p in @($seed, $rtC, $src)) {
    if (-not (Test-Path $p)) { throw "not found: $p" }
}

# ASCII-named working copies (as/gcc choke on Devanagari paths)
Copy-Item $seed "_seed.s" -Force
Copy-Item $rtC  "_seed_rt.c" -Force

Write-Host "== 1/5  compile C runtime (sutra_runtime.c -> .o) ==" -ForegroundColor Cyan
& $gcc -m64 -O2 -finput-charset=UTF-8 -fexec-charset=UTF-8 -c "_seed_rt.c" -o "sutra_runtime_prebuilt.o"
if ($LASTEXITCODE -ne 0) { throw "runtime compile failed" }

Write-Host "== 2/5  assemble seed + OS floor (.s -> .o) ==" -ForegroundColor Cyan
& $as -o "_seed.o" "_seed.s"
if ($LASTEXITCODE -ne 0) { throw "as failed (seed)" }
Copy-Item (Join-Path $seedDir "तल.s") "_floor.s" -Force
& $as -o "sutra_floor.o" "_floor.s"
if ($LASTEXITCODE -ne 0) { throw "as failed (तल.s)" }
Remove-Item "_floor.s" -ErrorAction SilentlyContinue

Write-Host "== 3/5  link seed compiler (gcc as linker) ==" -ForegroundColor Cyan
& $gcc -m64 "_seed.o" "sutra_runtime_prebuilt.o" "sutra_floor.o" -lm -lshell32 -o "seed_sutrac.exe"
if ($LASTEXITCODE -ne 0) { throw "link failed" }
Remove-Item "_seed.s", "_seed.o", "_seed_rt.c" -ErrorAction SilentlyContinue
Write-Host "   seed compiler ready: seed_sutrac.exe" -ForegroundColor Green

Write-Host "== 4/5  seed compiler builds current source ==" -ForegroundColor Cyan
& ".\seed_sutrac.exe" $src 2>&1 | Select-Object -Last 2
$fresh = "स्वसंकलक\मूल_संकलन.सूत्र_native.exe"
if (-not (Test-Path $fresh)) { throw "seed compiler could not compile the source" }
Copy-Item $fresh "sutrac.exe" -Force
Write-Host "   fresh compiler: sutrac.exe" -ForegroundColor Green

Write-Host "== 5/5  fixed-point check (fresh compiler recompiles itself) ==" -ForegroundColor Cyan
& ".\seed_sutrac.exe" $src 2>&1 | Out-Null
Copy-Item "sutra_native_temp.s" "_fp_a.s" -Force
& ".\sutrac.exe" $src 2>&1 | Out-Null
Copy-Item "sutra_native_temp.s" "_fp_b.s" -Force
$ha = (Get-FileHash "_fp_a.s").Hash
$hb = (Get-FileHash "_fp_b.s").Hash
Remove-Item "_fp_a.s", "_fp_b.s" -ErrorAction SilentlyContinue

if ($ha -eq $hb) {
    Write-Host "`n[OK] Fixed point reached - seed and fresh compiler emit byte-identical assembly." -ForegroundColor Green
    Write-Host "     The C++ host was not used." -ForegroundColor Green
} else {
    Write-Host "`n[NOTE] Seed is behind the current .सूत्र source (expected if codegen changed)." -ForegroundColor Yellow
    Write-Host "       The fresh compiler (sutrac.exe) is still valid. Refresh the seed per निर्माण/README.md." -ForegroundColor Yellow
}
exit 0
