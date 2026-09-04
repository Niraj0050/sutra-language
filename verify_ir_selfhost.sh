#!/usr/bin/env bash
# verify_ir_selfhost.sh — IR-backend compiler bootstrap + fixed point
#   Gen1 = split (अग्र_चालक → पश्च_चालक) compiles मूल_संकलन.सूत्र
#   Gen1 compiles मूल_संकलन.सूत्र → Gen2   (+ .s snapshot)
#   Gen2 compiles मूल_संकलन.सूत्र → Gen3   (+ .s snapshot)
#   Gen2.s == Gen3.s  → fixed point
set -u
export PATH="/c/msys64/ucrt64/bin:$PATH"
cd "$(dirname "$0")"
RT="sutra_alloc.o sutra_srt.o sutra_floor.o"
SRC="स्वसंकलक/मूल_संकलन.सूत्र"
FRONT="स्वसंकलक/अग्र_चालक.सूत्र_native.exe"
BACK="स्वसंकलक/पश्च_चालक.सूत्र_native.exe"
W=/tmp/irsh; mkdir -p "$W"

link() { cp "$1" "$W/x.s"; as -o "$W/x.o" "$W/x.s" || return 1
         gcc -m64 -nostdlib -Wl,--no-undefined "$W/x.o" $RT -lkernel32 -lshell32 -o "$2" || return 1; }

echo "== Gen1: split-compile $SRC =="
[ -x "$FRONT" ] || ./sutrac.exe स्वसंकलक/अग्र_चालक.सूत्र >/dev/null 2>&1
[ -x "$BACK" ]  || ./sutrac.exe स्वसंकलक/पश्च_चालक.सूत्र >/dev/null 2>&1
"./$FRONT" "$SRC" > "$W/g1.ir" 2>"$W/e" || { echo "अग्र विफल"; cat "$W/e"; exit 1; }
"./$BACK" "$W/g1.ir" 2>"$W/e" | sed 's/\r$//' > "$W/g1.s" || { echo "पश्च विफल"; cat "$W/e"; exit 1; }
link "$W/g1.s" "$W/gen1.exe" || { echo "Gen1 link विफल"; exit 1; }
echo "   Gen1 ready ($(wc -l < "$W/g1.s") lines)"

echo "== Gen2: Gen1 compiles $SRC =="
"$W/gen1.exe" "$SRC" >"$W/g2.log" 2>&1 || { echo "Gen2 compile विफल"; tail -5 "$W/g2.log"; exit 1; }
cp sutra_native_temp.s "$W/gen2.s"
link "$W/gen2.s" "$W/gen2.exe" || { echo "Gen2 link विफल"; exit 1; }
echo "   Gen2 ready ($(wc -l < "$W/gen2.s") lines)"

echo "== Gen3: Gen2 compiles $SRC =="
"$W/gen2.exe" "$SRC" >"$W/g3.log" 2>&1 || { echo "Gen3 compile विफल"; tail -5 "$W/g3.log"; exit 1; }
cp sutra_native_temp.s "$W/gen3.s"
echo "   Gen3 ready ($(wc -l < "$W/gen3.s") lines)"

echo
if diff -q "$W/gen2.s" "$W/gen3.s" >/dev/null; then
  echo "✓ FIXED POINT — Gen2.s == Gen3.s ($(wc -l < "$W/gen2.s") lines)"
else
  echo "✗ NOT fixed — Gen2.s != Gen3.s"
  diff "$W/gen2.s" "$W/gen3.s" | head -20
  exit 1
fi
if diff -q <(sed -e 's/[[:space:]]*$//' -e '/^$/d' "$W/g1.s") <(sed -e 's/[[:space:]]*$//' -e '/^$/d' "$W/gen2.s") >/dev/null; then
  echo "✓ Gen1 (split) == Gen2 (unified) — no serialization/backend drift"
else
  echo "⚠ Gen1 != Gen2 ($(diff <(sed -e 's/[[:space:]]*$//' -e '/^$/d' "$W/g1.s") <(sed -e 's/[[:space:]]*$//' -e '/^$/d' "$W/gen2.s") | grep -c '^[<>]') diff lines)"
  diff <(sed -e 's/[[:space:]]*$//' -e '/^$/d' "$W/g1.s") <(sed -e 's/[[:space:]]*$//' -e '/^$/d' "$W/gen2.s") | head -16
fi

echo
echo "== tests/compiler through Gen2 =="
pass=0; fail=0
for f in $(ls tests/compiler/*.सूत्र | sort); do
  n="$(basename "$f")"
  exp="$(./sutra.exe run "$f" 2>/dev/null | sed 's/\x0d//g')"
  "$W/gen2.exe" "$f" >/dev/null 2>&1 || { fail=$((fail+1)); echo "  [FAIL c] $n"; continue; }
  ex="${f}_native.exe"
  [ -x "$ex" ] || { fail=$((fail+1)); echo "  [FAIL x] $n"; continue; }
  got="$("$ex" 2>&1 | sed 's/\x0d//g')"
  if [ "$got" = "$exp" ]; then pass=$((pass+1)); else fail=$((fail+1)); echo "  [FAIL o] $n"; fi
  rm -f "$ex"
done
echo "   tests/compiler: PASS $pass  FAIL $fail"
