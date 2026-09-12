# कर्नेल/निर्माण.ps1 — Sutra freestanding kernel: बूट-इमेज बनाओ + (वैकल्पिक) QEMU में चलाओ
#
# प्रयोग:
#   .\कर्नेल\निर्माण.ps1 -KernelBin "examples\कर्नेल_नमस्ते.सूत्र_freestanding.bin"
#   .\कर्नेल\निर्माण.ps1 -KernelBin "..." -Run          # QEMU में headless boot + serial दिखाओ
#   .\कर्नेल\निर्माण.ps1 -KernelBin "..." -Run -Seconds 5
#
# पहले `sutrac.exe --freestanding <file.सूत्र>` से .bin बनाओ, फिर यह उसे
# कर्नेल/boot.asm के पीछे disk sector 2 से जोड़कर एक bootable image देता है।
#
# नोट: nasm/qemu जैसे native टूल्स को Devanagari पथ argument के रूप में
# देने पर वो OS की ANSI codepage argv-decoding में '?' बन जाता है — इसलिए
# यह स्क्रिप्ट कर्नेल/ डायरेक्टरी में cd करके सिर्फ़ बेयर ASCII फ़ाइल-नाम
# (boot.asm, boot.bin, disk.img) उन्हें देती है। KernelBin पथ खुद कोई
# समस्या नहीं — वह .NET File API से सीधे पढ़ा जाता, किसी native टूल के
# argv में नहीं जाता।

param(
    [Parameter(Mandatory=$true)][string]$KernelBin,
    [switch]$Run,
    [int]$Seconds = 3
)

$ErrorActionPreference = "Stop"
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$kernelBinFull = Resolve-Path $KernelBin -ErrorAction Stop

$nasm = "C:\Users\niraj\AppData\Local\Microsoft\WinGet\Packages\BrechtSanders.WinLibs.POSIX.UCRT_Microsoft.Winget.Source_8wekyb3d8bbwe\mingw64\bin\nasm.exe"
if (-not (Test-Path $nasm)) { $nasm = (Get-Command nasm -ErrorAction SilentlyContinue).Source }
if (-not $nasm) { throw "nasm नहीं मिला — PATH में जोड़ो या इस स्क्रिप्ट में पथ ठीक करो।" }

Push-Location $scriptDir
try {
    Write-Output "1. बूट-स्टब असेम्बल हो रहा..."
    & $nasm -f bin "boot.asm" -o "boot.bin"
    if ($LASTEXITCODE -ne 0) { throw "nasm विफल" }
    $bootBytes = [System.IO.File]::ReadAllBytes((Join-Path $scriptDir "boot.bin"))
    if ($bootBytes.Length -ne 512) { throw "बूट सेक्टर 512 बाइट्स का नहीं है (मिला: $($bootBytes.Length)) — boot.asm जाँचो" }

    $kernelBytes = [System.IO.File]::ReadAllBytes($kernelBinFull)
    $kernelSectors = 32   # boot.asm का KERNEL_SECTORS — यहाँ भी बदलना अगर वहाँ बदला
    $maxBytes = $kernelSectors * 512
    if ($kernelBytes.Length -gt $maxBytes) {
        throw "कर्नेल $($kernelBytes.Length) बाइट्स का है, boot.asm सिर्फ़ $maxBytes तक लोड करता — boot.asm में KERNEL_SECTORS बढ़ाओ।"
    }
    # image हमेशा पूरे kernelSectors तक पैड होती — boot.asm BIOS से ठीक
    # KERNEL_SECTORS सेक्टर पढ़ता है, image उतनी छोटी हुई तो वो read
    # end-of-file के पार जाकर विफल हो जाता (चुपचाप हैंग, कोई सीरियल आउटपुट
    # नहीं) — असली कर्नेल छोटा हो तब भी पूरी budget तक zero-pad करो
    $paddedSize = $maxBytes

    Write-Output "2. डिस्क-इमेज बना रहा ($($kernelBytes.Length) बाइट्स कर्नेल, $kernelSectors सेक्टर तक पैड)..."
    $img = New-Object byte[] (512 + $paddedSize)
    [Array]::Copy($bootBytes, 0, $img, 0, 512)
    [Array]::Copy($kernelBytes, 0, $img, 512, $kernelBytes.Length)
    $imgPath = Join-Path $scriptDir "disk.img"
    [System.IO.File]::WriteAllBytes($imgPath, $img)
    Write-Output "   बना: $imgPath ($($img.Length) बाइट्स)"

    if ($Run) {
        $qemu = "C:\msys64\mingw64\bin\qemu-system-x86_64.exe"
        if (-not (Test-Path $qemu)) { $qemu = (Get-Command qemu-system-x86_64 -ErrorAction SilentlyContinue).Source }
        if (-not $qemu) { throw "qemu-system-x86_64 नहीं मिला — 'pacman -S mingw-w64-x86_64-qemu' से install करो।" }

        Remove-Item "serial_out.txt" -ErrorAction SilentlyContinue
        Write-Output "3. QEMU में boot (headless, $Seconds सेकंड)..."
        $psi = New-Object System.Diagnostics.ProcessStartInfo
        $psi.FileName = $qemu
        $psi.Arguments = "-drive format=raw,file=disk.img -serial file:serial_out.txt -display none -no-reboot -monitor none"
        $psi.WorkingDirectory = $scriptDir
        $psi.UseShellExecute = $false
        $p = [System.Diagnostics.Process]::Start($psi)
        Start-Sleep -Seconds $Seconds
        if (-not $p.HasExited) { $p.Kill() }
        Start-Sleep -Milliseconds 300
        Write-Output "--- सीरियल आउटपुट ---"
        $serialPath = Join-Path $scriptDir "serial_out.txt"
        if (Test-Path $serialPath) { Get-Content $serialPath -Raw } else { Write-Output "(कुछ नहीं मिला)" }
    }
}
finally {
    Pop-Location
}
