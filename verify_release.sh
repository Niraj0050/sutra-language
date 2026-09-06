#!/usr/bin/env bash
# verify_release.sh — `sutrac.exe --release` (LLVM backend, runtime-as-bitcode
# via llvm-link + whole-module clang -O2) end-to-end vs the interpreter, over
# the full tests/compiler corpus.
set -u
export PATH="/c/msys64/ucrt64/bin:$PATH"
cd "$(dirname "$0")"
[ -x ./sutrac.exe ] || { echo "sutrac.exe नहीं मिला (bootstrap.ps1 चलाओ)"; exit 1; }

echo "== tests/compiler through sutrac.exe --release =="
pass=0; fail=0
for f in $(ls tests/compiler/*.सूत्र | sort); do
  n="$(basename "$f")"
  exp="$(./sutra.exe run "$f" 2>/dev/null | sed 's/\x0d//g')"
  rm -f "${f}_native.exe"
  ./sutrac.exe --release "$f" >/tmp/vr.log 2>&1 || { fail=$((fail+1)); echo "  [FAIL compile] $n"; tail -2 /tmp/vr.log | sed 's/^/         /'; continue; }
  ex="${f}_native.exe"
  [ -x "$ex" ] || { fail=$((fail+1)); echo "  [FAIL noexe] $n"; continue; }
  got="$("$ex" 2>&1 | sed 's/\x0d//g')"
  rm -f "$ex"
  if [ "$got" = "$exp" ]; then pass=$((pass+1)); else fail=$((fail+1)); echo "  [FAIL out] $n  (got: $(echo "$got" | head -1 | cut -c1-40))"; fi
done
echo
echo "   tests/compiler (--release): PASS $pass  FAIL $fail"
