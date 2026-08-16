$path = 'd:\my project\सूत्र\संकलक\src\compiler\sutra_runtime.c'
$content = Get-Content -Raw -Encoding UTF8 -Path $path
$content = $content -replace '(?m)^\s*fprintf\(stderr, "(.*?)\\n"\);\s*exit\(1\);', '    sutra_throw_str("$1");'
$content = $content -replace '(?m)^\s*fprintf\(stderr, "(.*?): %lld \(सीमा: 0-%lld\)\\n",\s*\(long long\)idx, \(long long\)(.*?)\);\s*exit\(1\);', '    sutra_throw_str("$1: out of bounds");'
Set-Content -Path $path -Value $content -Encoding UTF8
