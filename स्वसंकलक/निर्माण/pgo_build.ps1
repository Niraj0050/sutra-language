# pgo_build.ps1 - build a PGO-optimized Sutra compiler (opt-in, faster)
# ============================================================
# The canonical sutrac.exe is x86-backend-built by bootstrap.ps1 (for the
# byte-identical fixed-point + minimal-toolchain property). This script
# builds a SEPARATE, faster compiler:
#
#   sutrac.exe --release --pgo --pgo-run "<compiler src>" <compiler src>
#
# = instrument the compiler via the --release (LLVM) backend, run it on the
#   compiler source (representative, side-effect-free, deterministic
#   training), merge the profile, rebuild with -fprofile-use. The resulting
#   binary still imports only KERNEL32 + SHELL32 (the profile runtime lives
#   only in the throwaway instrumented exe).
#
# Output: sutrac_pgo.exe (repo root). Does not touch sutrac.exe.
#   To adopt it:  Copy-Item sutrac_pgo.exe sutrac.exe
#
# Needs: a working sutrac.exe (bootstrap.ps1) + MSYS2 ucrt64 (clang,
#        llvm-link, llvm-profdata, as, gcc) + the compiler-rt package.
# ============================================================
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = "Stop"
$env:PATH = "C:\msys64\ucrt64\bin;$env:PATH"

$root = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
Set-Location $root
$src   = [char]0x938 + [char]0x94d + [char]0x935 + [char]0x938 + [char]0x902 + [char]0x915 + [char]0x932 + [char]0x915 + "\" + `
         [char]0x92e + [char]0x942 + [char]0x932 + "_" + [char]0x938 + [char]0x902 + [char]0x915 + [char]0x932 + [char]0x928 + "." + `
         [char]0x938 + [char]0x942 + [char]0x924 + [char]0x94d + [char]0x930     # स्वसंकलक\मूल_संकलन.सूत्र
$fresh = $src + "_native.exe"

if (-not (Test-Path ".\sutrac.exe")) { throw "sutrac.exe not found - run bootstrap.ps1 first" }
if (-not (Test-Path $src))           { throw "compiler source not found: $src" }

Write-Host "== PGO compiler build (training = self-compile of the compiler source) ==" -ForegroundColor Cyan
Remove-Item $fresh -ErrorAction SilentlyContinue
& ".\sutrac.exe" --release --pgo --pgo-run $src $src
if ($LASTEXITCODE -ne 0 -or -not (Test-Path $fresh)) { throw "PGO build failed" }

Copy-Item $fresh "sutrac_pgo.exe" -Force
Write-Host "`n[OK] sutrac_pgo.exe ready." -ForegroundColor Green
Write-Host "     To replace the canonical sutrac.exe:  Copy-Item sutrac_pgo.exe sutrac.exe" -ForegroundColor Green
