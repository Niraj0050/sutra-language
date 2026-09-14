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
# -IncludeComments also converts digits INSIDE // comments, with protections
# so external/standard references stay untouched:
#   1. Digits inside a "..." or `...` span within the comment (illustrating
#      string/code content — IPs, hex hashes, JSON text, regex \N/$N escape
#      syntax) are left alone, matching how real string literals are always
#      left alone.
#   2. A digit-run is left alone if it's part of a Latin-letter-containing
#      "cluster" (maximal run of [0-9A-Za-z-:./_], where '-' only bridges
#      digit<->digit so a hyphenated internal term like "Milestone-1"
#      doesn't inherit protection from the word in front of it) — catches
#      RFC 4648, FIPS 180-4 §4.2.2, UTF-8, HTTP/1.1, IPv4, SHA-256,
#      0xFFFFFFFF, git hashes like 4cc1ef3, ISO timestamps like
#      2026-09-10T14:30:00Z, and bare §3a-style section tags.
#   3. A digit-run preceded by a space/hyphen then an ALL-CAPS word (UTF,
#      SHA, RFC, FIPS, ISO, IEEE, TLS, ...) is protected the same way —
#      a Title-Case or lowercase word there is never an external citation
#      in this codebase's writing style.
# Everything else (descriptive counts, example Sutra code shown in a
# comment, dates without letter markers) converts, matching how the
# already-converted real source code looks.
#
# -MarkdownSutraFences treats a .md file differently: everything is left
# completely untouched EXCEPT the content of ```sutra fenced code blocks,
# which gets the exact same treatment as a real .सूत्र file (incl. comments)
# — since a सूत्र fence shows real syntax that should match the already-
# converted source. Prose, headings, tables, other-language fences (bash/
# powershell/text/...), and markdown's own ordered-list-marker digits are
# never touched — converting those would misrepresent the language's own
# spec text (English prose contrasting "0-9" vs "०-९") or break rendering
# (CommonMark only recognizes ASCII-digit list markers). Decided with the
# user 2026-09-14: only सूत्र code-fences convert in docs.
#
# Used (2026-09-14) to convert सब पुस्तकालय/ + भाषा_परीक्षण/stdlib/ + स्वसंकलक/
# NUMBER-LITERAL tokens, then (separately) their // comments — see
# project_sutra_language memory for the commit history.
#
# उपयोग: .\convert_devanagari_digits.ps1 -Path "पुस्तकालय\गणित.सूत्र"
#        .\convert_devanagari_digits.ps1 -Path "..." -WhatIf   # सिर्फ़ गिनती, लिखे नहीं
#        .\convert_devanagari_digits.ps1 -Path "..." -IncludeComments
#        .\convert_devanagari_digits.ps1 -Path "README.md" -MarkdownSutraFences

param(
    [Parameter(Mandatory=$true)][string]$Path,
    [switch]$WhatIf,
    [switch]$IncludeComments,
    [switch]$MarkdownSutraFences
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

# $chars = full text char array; $runStart/$runEnd = digit-run bounds (end
# exclusive) within that array. Protects three patterns, all "this is an
# external/fixed notation, not a prose quantity":
#   1. Tight cluster (letters/digits/-:./_  touching, no space) contains a
#      Latin letter — catches HTTP/1.1, 0xFFFFFFFF, git hashes, ISO timestamps.
#   2. Cluster is preceded by exactly one space, then a run of pure Latin
#      letters (a "word") — catches "FIPS 180-4", "RFC 4648".
#   3. Cluster is preceded (possibly through a dot-joined digit chain, so a
#      LATER segment of "§4.2.2" still protects) by '§' — section refs.
function IsClusterProtected($chars, [int]$n, [int]$runStart, [int]$runEnd) {
    $section = [char]0x00A7
    $isAlnum = {
        param($ch)
        ($ch -ge '0' -and $ch -le '9') -or ($ch -ge 'A' -and $ch -le 'Z') -or ($ch -ge 'a' -and $ch -le 'z')
    }
    $isDigit = { param($ch) $ch -ge '0' -and $ch -le '9' }
    $isPlainConnector = { param($ch) $ch -eq ':' -or $ch -eq '.' -or $ch -eq '/' -or $ch -eq '_' }
    $isLatinLetter = { param($ch) ($ch -ge 'A' -and $ch -le 'Z') -or ($ch -ge 'a' -and $ch -le 'z') }

    # Tight-cluster expansion. '-' only bridges digit<->digit (so "180-4"
    # stays one cluster) — NOT letter<->digit, so "Milestone-1"/"Increment-1"
    # (a word joined to a number by a stylistic hyphen, meaning "word space
    # number") don't accidentally inherit the word's letters and get
    # protected just because the author used '-' instead of ' '. A direct
    # letter<->digit touch with no separator at all (align16, v0, r8) still
    # bridges normally via isAlnum — only the '-' case needs this guard.
    $l = $runStart
    while ($l -gt 0) {
        $prev = $chars[$l-1]
        if ((& $isAlnum $prev) -or (& $isPlainConnector $prev)) { $l -= 1; continue }
        if ($prev -eq '-' -and $l -ge 2 -and (& $isDigit $chars[$l-2])) { $l -= 1; continue }
        break
    }
    $r = $runEnd
    while ($r -lt $n) {
        $cur = $chars[$r]
        if ((& $isAlnum $cur) -or (& $isPlainConnector $cur)) { $r += 1; continue }
        if ($cur -eq '-' -and ($r + 1) -lt $n -and (& $isDigit $chars[$r+1])) { $r += 1; continue }
        break
    }
    for ($k = $l; $k -lt $r; $k++) {
        if (& $isLatinLetter $chars[$k]) { return $true }
    }

    if ($l -gt 0 -and ($chars[$l-1] -eq ' ' -or $chars[$l-1] -eq '-')) {
        $w = $l - 1
        while ($w -gt 0 -and (& $isLatinLetter $chars[$w-1])) { $w -= 1 }
        if ($w -lt ($l - 1)) {
            # a bare Latin word before the space/hyphen is NOT enough on its
            # own — common English filler words ("of", "is") get mixed into
            # Hinglish prose too and would over-protect real counts (e.g.
            # "सूची of 8"), and internal terms ("Milestone-1", "Phase 2",
            # "signed-32-bit") are our own numbering/prose, not an external
            # citation. A Title-Case or lowercase word is never one of
            # those in this codebase's writing style — but an ALL-CAPS
            # acronym (UTF, SHA, RFC, FIPS, ISO, IEEE, TLS, HTTP, …) always
            # names something external/fixed, so treat that as the signal
            # instead of an arbitrary fixed list (which missed UTF/SHA and
            # broke "UTF-8"/"SHA-256" on the first pass).
            $word = -join $chars[$w..($l-2)]
            $isAllCapsWord = $true
            foreach ($wc in $chars[$w..($l-2)]) {
                if (-not ($wc -ge 'A' -and $wc -le 'Z')) { $isAllCapsWord = $false; break }
            }
            if ($isAllCapsWord -or (@('IPv','IPv4','IPv6') -contains $word)) { return $true }
        }
    }

    $p = $l
    while ($p -gt 0 -and ((($chars[$p-1] -ge '0' -and $chars[$p-1] -le '9')) -or $chars[$p-1] -eq '.')) { $p -= 1 }
    if ($p -gt 0 -and $chars[$p-1] -eq $section) { return $true }
    return $false
}

# Core lexer-like scanner — converts a block of real सूत्र source text
# (a whole file, or one ```sutra fence's inner content). Returns
# @{ Result = <converted text>; Count = <digits converted> }.
function ConvertSutraText([string]$raw, [bool]$includeComments) {
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
            if (-not $includeComments) {
                # line comment — copy verbatim to end of line (original behaviour)
                while ($i -lt $n -and $chars[$i] -ne "`n") {
                    [void]$out.Append($chars[$i])
                    $i += 1
                }
                $prevIsIdent = $false
                continue
            }

            # includeComments: scan the comment applying the same digit-run
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

    return @{ Result = $out.ToString(); Count = $convertedCount }
}

# Splits a markdown file into ```sutra fence content vs. everything else,
# runs ConvertSutraText only on the fence content, and reassembles. Fence
# detection is line-based (a line whose trimmed start is ``` toggles fence
# state; the opening line's trailing text is the language tag) — matches
# CommonMark fenced-code-block syntax closely enough for this repo's docs.
function ConvertMarkdownSutraFences([string]$raw) {
    $lines = $raw -split "`n", -1
    $outLines = New-Object System.Collections.Generic.List[string]
    $totalCount = 0
    $inFence = $false
    $fenceIsSutra = $false
    $fenceBuf = New-Object System.Collections.Generic.List[string]

    foreach ($line in $lines) {
        $trimmed = $line.TrimEnd("`r")
        $trimStart = $trimmed.TrimStart()

        if (-not $inFence -and $trimStart.StartsWith('```')) {
            $tag = $trimStart.Substring(3).Trim()
            $inFence = $true
            $fenceIsSutra = ($tag -eq 'sutra')
            $fenceBuf.Clear()
            $outLines.Add($line)
            continue
        }

        if ($inFence -and $trimStart.StartsWith('```')) {
            if ($fenceIsSutra) {
                $fenceText = [string]::Join("`n", $fenceBuf)
                $converted = ConvertSutraText $fenceText $true
                $totalCount += $converted.Count
                if ($fenceBuf.Count -gt 0) {
                    $outLines.AddRange([string[]]($converted.Result -split "`n", -1))
                }
            } else {
                $outLines.AddRange($fenceBuf)
            }
            $inFence = $false
            $outLines.Add($line)
            continue
        }

        if ($inFence) {
            $fenceBuf.Add($line)
        } else {
            $outLines.Add($line)
        }
    }

    # unterminated fence (shouldn't happen in valid markdown) — flush verbatim
    if ($inFence) { $outLines.AddRange($fenceBuf) }

    return @{ Result = [string]::Join("`n", $outLines); Count = $totalCount }
}

$rawInput = Get-Content -Raw -Encoding UTF8 -Path $Path

if ($MarkdownSutraFences) {
    $conv = ConvertMarkdownSutraFences $rawInput
} else {
    $conv = ConvertSutraText $rawInput $IncludeComments.IsPresent
}

Write-Output "बदले गए अंक: $($conv.Count)"
if ($WhatIf) {
    Write-Output "--- WhatIf: फ़ाइल नहीं लिखी ---"
} else {
    [System.IO.File]::WriteAllText($Path, $conv.Result, (New-Object System.Text.UTF8Encoding($false)))
    Write-Output "लिखा: $Path"
}
