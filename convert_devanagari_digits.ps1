# Converts Arabic-digit NUMBER LITERALS in a .सूत्र source file to Devanagari
# digits, WITHOUT touching: string literals, // comments, or digits that are
# part of an identifier (e.g. "ग1" stays "ग1" — a digit immediately after a
# Devanagari letter/digit/underscore is an identifier-continuation char per
# स्वसंकलक/लेखक.सूत्र's नाम_अनुवृत्ति_है, not a fresh number token).
#
# Character-by-character state machine (NOT a naive regex substitution) —
# tracks string/comment state exactly like a real lexer would, to avoid
# corrupting anything outside genuine numeric-literal tokens.
#
# Used (2026-09-14) to convert सब पुस्तकालय/ + tests/stdlib/ — deliberately
# NOT yet run on स्वसंकलक/ (the compiler's own ~189K-line self-hosting
# source): that needs its own staged, carefully-verified pass (small
# batches, full verify + seed refresh after each), not a one-shot sweep —
# see project_sutra_language memory for the reasoning. The script itself
# is Sutra-syntax-generic and needs no changes to run on स्वसंकलक/ files.
#
# उपयोग: .\convert_devanagari_digits.ps1 -Path "पुस्तकालय\गणित.सूत्र"
#        .\convert_devanagari_digits.ps1 -Path "..." -WhatIf   # सिर्फ़ गिनती, लिखे नहीं

param(
    [Parameter(Mandatory=$true)][string]$Path,
    [switch]$WhatIf
)

$devMap = @{
    [char]'0'=[char]0x0966; [char]'1'=[char]0x0967; [char]'2'=[char]0x0968
    [char]'3'=[char]0x0969; [char]'4'=[char]0x096A; [char]'5'=[char]0x096B
    [char]'6'=[char]0x096C; [char]'7'=[char]0x096D; [char]'8'=[char]0x096E
    [char]'9'=[char]0x096F
}

function IsIdentChar([int]$cp) {
    # देवनागरी_वर्ण_है
    if (($cp -ge 2308 -and $cp -le 2361) -or ($cp -ge 2392 -and $cp -le 2401) -or ($cp -ge 2418 -and $cp -le 2431)) { return $true }
    # देवनागरी_संयोग_है
    if (($cp -ge 2304 -and $cp -le 2307) -or ($cp -eq 2364) -or ($cp -ge 2366 -and $cp -le 2383) -or ($cp -ge 2385 -and $cp -le 2391) -or ($cp -ge 2402 -and $cp -le 2403)) { return $true }
    # digits (ASCII or Devanagari) — both valid ident-continuation chars
    if (($cp -ge 48 -and $cp -le 57) -or ($cp -ge 2406 -and $cp -le 2415)) { return $true }
    if ($cp -eq 95) { return $true }  # '_'
    return $false
}

$raw = Get-Content -Raw -Encoding UTF8 -Path $Path
$chars = $raw.ToCharArray()
$n = $chars.Length
$out = New-Object System.Text.StringBuilder($n)

$i = 0
$inString = $false
$prevIsIdent = $false
$convertedCount = 0

while ($i -lt $n) {
    $c = $chars[$i]

    if ($inString) {
        [void]$out.Append($c)
        if ($c -eq '\' -and ($i + 1) -lt $n) {
            [void]$out.Append($chars[$i + 1])
            $i += 2
            continue
        }
        if ($c -eq '"') { $inString = $false }
        $prevIsIdent = $false
        $i += 1
        continue
    }

    if ($c -eq '"') {
        $inString = $true
        [void]$out.Append($c)
        $prevIsIdent = $false
        $i += 1
        continue
    }

    if ($c -eq '/' -and ($i + 1) -lt $n -and $chars[$i + 1] -eq '/') {
        # line comment — copy verbatim to end of line
        while ($i -lt $n -and $chars[$i] -ne "`n") {
            [void]$out.Append($chars[$i])
            $i += 1
        }
        $prevIsIdent = $false
        continue
    }

    if ($c -ge '0' -and $c -le '9' -and -not $prevIsIdent) {
        # start of a fresh ASCII digit-run (not preceded by an ident char) —
        # convert the whole run (incl. a single embedded '.' for decimals)
        $j = $i
        while ($j -lt $n -and $chars[$j] -ge '0' -and $chars[$j] -le '9') { $j += 1 }
        if ($j -lt $n -and $chars[$j] -eq '.' -and ($j + 1) -lt $n -and $chars[$j+1] -ge '0' -and $chars[$j+1] -le '9') {
            $j += 1
            while ($j -lt $n -and $chars[$j] -ge '0' -and $chars[$j] -le '9') { $j += 1 }
        }
        for ($k = $i; $k -lt $j; $k++) {
            if ($devMap.ContainsKey($chars[$k])) {
                [void]$out.Append($devMap[$chars[$k]])
                $convertedCount += 1
            } else {
                [void]$out.Append($chars[$k])
            }
        }
        $i = $j
        $prevIsIdent = $true   # a number token's end also blocks the NEXT char from starting fresh only if it's a digit run directly glued on (rare/invalid anyway); harmless either way
        continue
    }

    [void]$out.Append($c)
    $prevIsIdent = IsIdentChar([int][char]$c)
    $i += 1
}

$result = $out.ToString()
Write-Output "बदले गए अंक: $convertedCount"
if ($WhatIf) {
    Write-Output "--- WhatIf: फ़ाइल नहीं लिखी ---"
} else {
    [System.IO.File]::WriteAllText($Path, $result, (New-Object System.Text.UTF8Encoding($false)))
    Write-Output "लिखा: $Path"
}
