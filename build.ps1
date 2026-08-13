[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$env:PATH = "C:\msys64\ucrt64\bin;$env:PATH"
$gpp = "C:\msys64\ucrt64\bin\g++.exe"

Write-Host "Building Sutra Compiler..." -ForegroundColor Cyan
$sources = (Get-ChildItem -Path "./*/src" -Recurse -Filter "*.cpp").FullName
$incDir = (Get-ChildItem -Path "./*/include").FullName

& $gpp -std=c++17 -finput-charset=UTF-8 -fexec-charset=UTF-8 -I"$incDir" $sources -o sutra.exe
if ($LASTEXITCODE -eq 0) {
    if (-not (Test-Path build)) { New-Item -ItemType Directory -Path build | Out-Null }
    Copy-Item sutra.exe build/sutra.exe -Force
    Write-Host "[SUTRA] sutra.exe built successfully!" -ForegroundColor Green
} else {
    Write-Host "[SUTRA] Build failed!" -ForegroundColor Red
}
