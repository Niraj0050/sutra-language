# Converts Arabic-digit NUMBER LITERALS in a .सूत्र source file to Devanagari
# digits, WITHOUT touching: string literals, or digits that are part of an
# identifier (e.g. "ग1" stays "ग1" — a digit immediately after a Devanagari
# letter/digit/underscore is an identifier-continuation char per
# स्वसंकलक/लेखक.सूत्र's नाम_अनुवृत्ति_है, not a fresh number token).
#
# Character-by-character state machine (NOT a naive regex substitution) —
# tracks string/comment state exactly like a real lexer would, to avoid
# corrupting anything outside genuine numeric-literal tokens.
#
# -IncludeComments also converts digits INSIDE // comments, with two
# protections so external/standard references stay untouched:
#   1. Digits inside a "..." span within the comment (illustrating string
#      content — IPs, hex hashes, JSON text) are left alone, matching how
#      real string literals are always left alone.
#   2. A digit-run is left alone if it's part of a Latin-letter-containing
#      "cluster" (maximal run of [0-9A-Za-z-:./§_]) — this catches
#      RFC 4648, FIPS 180-4 §4.2.2, UTF-8, HTTP/1.1, IPv4, SHA-256,
#      0xFFFFFFFF, git hashes like 4cc1ef3, ISO timestamps like
#      2026-09-10T14:30:00Z, and bare §3a-style section tags — all of
#      which are external/fixed notations, not prose quantities.
# Everything else (descriptive counts, example Sutra code shown in a
# comment, dates without letter markers) converts, matching how the
# already-converted real source code looks.
#
# Used (2026-09-14) to convert सब पुस्तकालय/ + tests/stdlib/ + स्वसंकलक/
# NUMBER-LITERAL tokens (no -IncludeComments). Comments + markdown docs
# are a separate, later pass — see project_sutra_language memory.
#
# उपयोग: .\convert_devanagari_digits.ps1 -Path "पुस्तकालय\गणित.सूत्र"
#        .\convert_devanagari_digits.ps1 -Path "..." -WhatIf   # सिर्फ़ गिनती, लिखे नहीं
#        .\convert_devanagari_digits.ps1 -Path "..." -IncludeComments

param(
    [Parameter(Mandatory=$true)][string]$Path,
    [switch]$WhatIf,
    [switch]$IncludeComments
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

# $chars = full file char array; $runStart/$runEnd = digit-run bounds (end exclusive)
# within that array. Protects three patterns, all "this is an external/fixed
# notation, not a prose quantity":
#   1. Tight cluster (letters/digits/-:./_  touching, no space) contains a
#      Latin letter — catches HTTP/1.1, 0xFFFFFFFF, git hashes, ISO timestamps.
#   2. Cluster is preceded by exactly one space, then a run of pure Latin
#      letters (a "word") — catches "FIPS 180-4", "RFC 4648".
#   3. Cluster is preceded (possibly through a dot-joined digit chain, so a
#      LATER segment of "§4.2.2" still protects) by '§' — section refs.
function IsClusterProtected($chars, [int]$n, [int]$runStart, [int]$runEnd) {
    $section = [char]0x00A7
    $isTightClusterChar = {
        param($ch)
        ($ch -ge '0' -and $ch -le '9') -or ($ch -ge 'A' -and $ch -le 'Z') -or ($ch -ge 'a' -and $ch -le 'z') -or
        $ch -eq '-' -or $ch -eq ':' -or $ch -eq '.' -or $ch -eq '/' -or $ch -eq '_'
    }
    $isLatinLetter = { param($ch) ($ch -ge 'A' -and $ch -le 'Z') -or ($ch -ge 'a' -and $ch -le 'z') }

    $l = $runStart
    while ($l -gt 0 -and (& $isTightClusterChar $chars[$l-1])) { $l -= 1 }
    $r = $runEnd
    while ($r -lt $n -and (& $isTightClusterChar $chars[$r])) { $r += 1 }
    for ($k = $l; $k -lt $r; $k++) {
        if (& $isLatinLetter $chars[$k]) { return $true }
    }

    if ($l -gt 0 -and $chars[$l-1] -eq ' ') {
        $w = $l - 1
        while ($w -gt 0 -and (& $isLatinLetter $chars[$w-1])) { $w -= 1 }
        if ($w -lt ($l - 1)) {
            # a bare Latin word before the space is NOT enough on its own —
            # common English filler words ("of", "is") get mixed into
            # Hinglish prose too and would over-protect real counts (e.g.
            # "सूची of 8"). Only known standard-name acronyms count.
            $word = -join $chars[$w..($l-2)]
            if (@('RFC','FIPS','ISO','IEEE','TLS','SSL','W3C','USB') -contains $word) { return $true }
        }
    }

    $p = $l
    while ($p -gt 0 -and ((($chars[$p-1] -ge '0' -and $chars[$p-1] -le '9')) -or $chars[$p-1] -eq '.')) { $p -= 1 }
    if ($p -gt 0 -and $chars[$p-1] -eq $section) { return $true }
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
        if (-not $IncludeComments) {
            # line comment — copy verbatim to end of line (original behaviour)
            while ($i -lt $n -and $chars[$i] -ne "`n") {
                [void]$out.Append($chars[$i])
                $i += 1
            }
            $prevIsIdent = $false
            continue
        }

        # -IncludeComments: scan the comment applying the same digit-run
        # conversion as code, protected by: (1) quote-tracking — digits
        # inside "..." (illustrating string content) stay untouched, same
        # as real string literals; (1b) backtick-tracking — digits inside
        # `...` (markdown-style code-span used in prose, e.g. `\1`-`\9` for
        # regex backreference syntax) stay untouched, since the backtick is
        # marking "literal syntax", same intent as a real string literal —
        # matters most for \N/\d escape-sequence docs, where the digit IS
        # the exact ASCII char the regex engine parses at runtime; (2)
        # identifier-continuation — a digit glued right after a Devanagari
        # letter (सं2, विन32.सूत्र, ज_पढ़4) is naming a REAL identifier/
        # filename that was never renamed, so it must stay exactly as-is,
        # same रूल as real code; (3) cluster check — a Latin-letter-
        # containing run (RFC 4648, HTTP/1.1, 0xFFFFFFFF, git hashes, ISO
        # timestamps) is an external/fixed notation, stays untouched.
        [void]$out.Append($chars[$i]); [void]$out.Append($chars[$i+1])
        $i += 2
        $cInString = $false
        $cInBacktick = $false
        $cPrevIsIdent = $false
        while ($i -lt $n -and $chars[$i] -ne "`n") {
            $cc = $chars[$i]

            if ($cInString) {
                [void]$out.Append($cc)
                if ($cc -eq '\' -and ($i + 1) -lt $n -and $chars[$i+1] -ne "`n") {
                    [void]$out.Append($chars[$i + 1])
                    $i += 2
                    continue
                }
                if ($cc -eq '"') { $cInString = $false }
                $cPrevIsIdent = $false
                $i += 1
                continue
            }

            if ($cInBacktick) {
                [void]$out.Append($cc)
                if ($cc -eq '`') { $cInBacktick = $false }
                $cPrevIsIdent = $false
                $i += 1
                continue
            }

            if ($cc -eq '"') {
                $cInString = $true
                [void]$out.Append($cc)
                $cPrevIsIdent = $false
                $i += 1
                continue
            }

            if ($cc -eq '`') {
                $cInBacktick = $true
                [void]$out.Append($cc)
                $cPrevIsIdent = $false
                $i += 1
                continue
            }

            if ($cc -ge '0' -and $cc -le '9') {
                $j = $i
                while ($j -lt $n -and $chars[$j] -ge '0' -and $chars[$j] -le '9') { $j += 1 }
                if ($j -lt $n -and $chars[$j] -eq '.' -and ($j + 1) -lt $n -and $chars[$j+1] -ge '0' -and $chars[$j+1] -le '9') {
                    $j += 1
                    while ($j -lt $n -and $chars[$j] -ge '0' -and $chars[$j] -le '9') { $j += 1 }
                }
                if ($cPrevIsIdent -or (IsClusterProtected $chars $n $i $j)) {
                    for ($k = $i; $k -lt $j; $k++) { [void]$out.Append($chars[$k]) }
                } else {
                    for ($k = $i; $k -lt $j; $k++) {
                        if ($devMap.ContainsKey($chars[$k])) {
                            [void]$out.Append($devMap[$chars[$k]])
                            $convertedCount += 1
                        } else {
                            [void]$out.Append($chars[$k])
                        }
                    }
                }
                $i = $j
                $cPrevIsIdent = $true
                continue
            }

            [void]$out.Append($cc)
            $cPrevIsIdent = IsIdentChar([int][char]$cc)
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
