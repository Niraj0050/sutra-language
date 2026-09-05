#!/usr/bin/env bash
# verify_ir_llvm.sh — LLVM backend correctness net
#   हर tests/compiler/*.सूत्र : sutra.exe run (interpreter, ground truth) बनाम
#   अग्र_चालक → एलएलवीएम_चालक → llc → gcc(-nostdlib) → चला → stdout तुलना
# verify_ir_selfhost.sh का tests/compiler-loop पैटर्न (वही .o सेट, वही report)
set -u
export PATH="/c/msys64/ucrt64/bin:$PATH"
cd "$(dirname "$0")"
RT="sutra_alloc.o sutra_srt.o sutra_floor.o"
FRONT="स्वसंकलक/अग्र_चालक.सूत्र_native.exe"
LLBACK="स्वसंकलक/एलएलवीएम_चालक.सूत्र_native.exe"
TRIPLE="x86_64-w64-windows-gnu"
W=/tmp/irllvm; mkdir -p "$W"

[ -x "$FRONT" ]  || ./sutrac.exe स्वसंकलक/अग्र_चालक.सूत्र >/dev/null 2>&1
[ -x "$LLBACK" ] || ./sutrac.exe स्वसंकलक/एलएलवीएम_चालक.सूत्र >/dev/null 2>&1
[ -x "$FRONT" ]  || { echo "अग्र_चालक बना नहीं"; exit 1; }
[ -x "$LLBACK" ] || { echo "एलएलवीएम_चालक बना नहीं"; exit 1; }

# frozen runtime .o (मूल_संकलन.सूत्र जैसा — ASCII-नाम कॉपी क्योंकि as Devanagari path नहीं खोलता)
if [ ! -f sutra_alloc.o ] || [ ! -f sutra_srt.o ] || [ ! -f sutra_floor.o ]; then
  cp "स्वसंकलक/निर्माण/तल.s" "$W/_floor.s"
  cp "स्वसंकलक/निर्माण/मूल_रनटाइम.s" "$W/_srt.s"
  cp "स्वसंकलक/निर्माण/मूल_आवंटक.s" "$W/_alloc.s"
  as -o sutra_floor.o "$W/_floor.s" || { echo "as तल.s विफल"; exit 1; }
  as -o sutra_srt.o   "$W/_srt.s"   || { echo "as मूल_रनटाइम.s विफल"; exit 1; }
  as -o sutra_alloc.o "$W/_alloc.s" || { echo "as मूल_आवंटक.s विफल"; exit 1; }
fi

echo "== tests/compiler through LLVM backend =="
pass=0; fail=0
i=0
for f in $(ls tests/compiler/*.सूत्र | sort); do
  n="$(basename "$f")"
  i=$((i+1)); a="$W/t$i"       # ASCII-only working prefix (as/gcc Devanagari path नहीं खोलते)
  exp="$(./sutra.exe run "$f" 2>/dev/null | sed 's/\x0d//g')"
  "./$FRONT" "$f" > "$a.ir" 2>"$W/e" || { fail=$((fail+1)); echo "  [FAIL front] $n"; continue; }
  "./$LLBACK" "$a.ir" 2>"$W/e" | sed 's/\r$//' > "$a.ll" || { fail=$((fail+1)); echo "  [FAIL llemit] $n"; continue; }
  llc -mtriple="$TRIPLE" -filetype=obj "$a.ll" -o "$a.o" 2>"$a.llcerr" || { fail=$((fail+1)); echo "  [FAIL llc] $n"; head -2 "$a.llcerr" | sed 's/^/         /'; continue; }
  gcc -m64 -nostdlib -Wl,--no-undefined "$a.o" $RT -lkernel32 -lshell32 -o "$a.exe" 2>"$a.lderr" || { fail=$((fail+1)); echo "  [FAIL link] $n"; head -2 "$a.lderr" | sed 's/^/         /'; continue; }
  got="$("$a.exe" 2>&1 | sed 's/\x0d//g')"
  if [ "$got" = "$exp" ]; then pass=$((pass+1)); else fail=$((fail+1)); echo "  [FAIL out] $n  (got: $(echo "$got" | head -1 | cut -c1-40))"; fi
  rm -f "$a.exe"
done
echo
echo "   tests/compiler (LLVM): PASS $pass  FAIL $fail"
