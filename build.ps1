[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$env:PATH = "C:\msys64\ucrt64\bin;$env:PATH"
$gpp = "C:\msys64\ucrt64\bin\g++.exe"

# Resolve paths dynamically to avoid non-ASCII encoding issues in script parsing
$sutraDir = Get-ChildItem -Directory | Where-Object { (Test-Path (Join-Path $_.Name "src")) -and (Test-Path (Join-Path $_.Name "include")) } | Select-Object -ExpandProperty Name
$toolsDir = Get-ChildItem -Directory | Where-Object { (Test-Path (Join-Path $_.Name "formatter")) -and (Test-Path (Join-Path $_.Name "sutra_lsp.cpp")) } | Select-Object -ExpandProperty Name
$testsDir = Get-ChildItem -Directory | Where-Object { (Test-Path (Join-Path $_.Name "test_sutra.cpp")) -and (Test-Path (Join-Path $_.Name "test_toolchain.cpp")) } | Select-Object -ExpandProperty Name

$incDir = "$sutraDir/include"

# Ensure nlohmann/json.hpp is available
$externalDir = Join-Path $PSScriptRoot "external/nlohmann"
if (-not (Test-Path $externalDir)) {
    New-Item -ItemType Directory -Path $externalDir | Out-Null
}
$jsonHeader = Join-Path $externalDir "json.hpp"
if (-not (Test-Path $jsonHeader)) {
    Write-Host "[build] Downloading nlohmann/json.hpp..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri "https://github.com/nlohmann/json/releases/download/v3.11.2/json.hpp" -OutFile $jsonHeader
}

# Create object directory
$objDir = "build/obj"
if (-not (Test-Path $objDir)) { New-Item -ItemType Directory -Path $objDir | Out-Null }

function Get-ObjPath($srcFile) {
    # Generate unique flat name by replacing path separators with underscores
    $flatName = $srcFile.Replace($PSScriptRoot, "").Replace("/", "_").Replace("\", "_").TrimStart("_")
    $cleanName = ""
    foreach ($char in $flatName.ToCharArray()) {
        if ([int]$char -lt 128) {
            $cleanName += $char
        } else {
            $cleanName += ([int]$char).ToString("X")
        }
    }
    return Join-Path $objDir ($cleanName.Replace(".cpp", ".o"))
}

# Helper to compile a single cpp file to object file if source is newer or obj doesn't exist
function Compile-Object($srcFile) {
    $srcName = Split-Path $srcFile -Leaf
    $objFile = Get-ObjPath $srcFile
    
    # Check if we need to compile (simple dependency check)
    $needCompile = $true
    if (Test-Path $objFile) {
        $srcTime = (Get-Item $srcFile).LastWriteTime
        $objTime = (Get-Item $objFile).LastWriteTime
        if ($srcTime -lt $objTime) {
            $needCompile = $false
        }
    }
    
    if ($needCompile) {
        Write-Host "  [g++] Object: $srcName" -ForegroundColor Gray
        $cmdArgs = @("-std=c++17", "-finput-charset=UTF-8", "-fexec-charset=UTF-8", "-I$incDir", "-Iexternal", "-c", $srcFile, "-o", $objFile)
        & $gpp $cmdArgs 2>&1
        if ($LASTEXITCODE -ne 0) {
            Write-Host "[ERROR] Failed to compile object $srcName" -ForegroundColor Red
            exit 1
        }
    }
    return $objFile
}

Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "             Building all Sutra binaries..." -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan

# 1. Core compiler sources (excludes main and all M4 tool files)
$sources_core = (Get-ChildItem -Path "./$sutraDir/src" -Recurse -Filter "*.cpp" | Where-Object { 
    $_.Name -ne "main.cpp" -and 
    $_.Name -ne "toolchain.cpp" -and 
    $_.Name -ne "formatter.cpp" -and 
    $_.Name -ne "linter.cpp" -and 
    $_.Name -ne "debugger.cpp" -and 
    $_.Name -ne "package_manager.cpp" -and 
    $_.Name -ne "build_system.cpp" -and
    $_.Name -ne "benchmark.cpp"
}).FullName

# 2. Complete toolchain sources (excludes main.cpp only)
$sources_toolchain = (Get-ChildItem -Path "./$sutraDir/src" -Recurse -Filter "*.cpp" | Where-Object { 
    $_.Name -ne "main.cpp" 
}).FullName

# Compile toolchain sources to object files
Write-Host "[build] Compiling source files to objects..." -ForegroundColor Yellow
$objects_toolchain = @()
foreach ($src in $sources_toolchain) {
    $objects_toolchain += Compile-Object $src
}

# Resolve core objects
$objects_core = @()
foreach ($src in $sources_core) {
    $objects_core += Get-ObjPath $src
}

# Helper compilation function
function Compile-Target($name, $objects, $cliPath, $libs = @()) {
    Write-Host "[build] Compiling $name..." -ForegroundColor Yellow
    $cmdArgs = @("-std=c++17", "-finput-charset=UTF-8", "-fexec-charset=UTF-8", "-I$incDir", "-Iexternal")
    foreach ($o in $objects) { $cmdArgs += $o }
    if ($cliPath) {
        if ($cliPath -is [array]) {
            foreach ($cp in $cliPath) { $cmdArgs += $cp }
        } else {
            $cmdArgs += $cliPath
        }
    }
    foreach ($l in $libs) { $cmdArgs += $l }
    $cmdArgs += @("-o", "$name.exe")

    & $gpp $cmdArgs 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[ERROR] Compilation failed for target: $name" -ForegroundColor Red
        exit 1
    }
    Write-Host "  - Target $name.exe compiled successfully." -ForegroundColor Green
}

# Build core compiler
$sources_main = (Get-ChildItem -Path "./$sutraDir/src" -Recurse -Filter "*.cpp" | Where-Object { 
    $_.Name -ne "toolchain.cpp" -and 
    $_.Name -ne "formatter.cpp" -and 
    $_.Name -ne "linter.cpp" -and 
    $_.Name -ne "debugger.cpp" -and 
    $_.Name -ne "package_manager.cpp" -and 
    $_.Name -ne "build_system.cpp" -and
    $_.Name -ne "benchmark.cpp"
}).FullName

$objects_main = @()
foreach ($src in $sources_main) {
    if ($src -like "*main.cpp") { continue }
    $objects_main += Get-ObjPath $src
}

Compile-Target "sutra" $objects_main "$sutraDir/src/main.cpp"

# Build tools
Compile-Target "sutra_formatter" $objects_toolchain "$toolsDir/formatter/formatter.cpp" -libs @("-lshell32")
Compile-Target "sutra_linter" $objects_toolchain "$toolsDir/linter/linter.cpp" -libs @("-lshell32")
Compile-Target "sutra_debugger" $objects_toolchain "$toolsDir/debugger/debugger.cpp" -libs @("-lshell32")
Compile-Target "sutra_pkgmgr" $objects_toolchain "$toolsDir/package_manager/package_manager.cpp" -libs @("-lshell32")
Compile-Target "sutra_build" $objects_toolchain "$toolsDir/build_system/build_system.cpp" -libs @("-lshell32")
Compile-Target "sutra_benchmark" $objects_toolchain "$toolsDir/benchmark/benchmark.cpp" -libs @("-lshell32")
# Compile Language Server (LSP)
Compile-Target "sutra_lsp" $objects_toolchain @("$toolsDir/sutra_lsp.cpp", "$toolsDir/src/lsp_handlers.cpp", "$toolsDir/src/lsp_adapter.cpp") -libs @("-I$toolsDir/src", "-lshell32")

Compile-Target "test_sutra" $objects_core "$testsDir/test_sutra.cpp"
Compile-Target "test_toolchain" $objects_toolchain "$testsDir/test_toolchain.cpp" -libs @("-lshell32")
Compile-Target "test_lsp_integration" $objects_toolchain "tests/lsp/test_lsp_integration.cpp" -libs @("-lshell32")

# Make directory and copy sutra.exe to build directory (preserving legacy build.ps1 contract)
if (-not (Test-Path build)) { New-Item -ItemType Directory -Path build | Out-Null }
Copy-Item sutra.exe build/sutra.exe -Force

Write-Host "`n[SUCCESS] All Sutra binaries compiled successfully!" -ForegroundColor Green
