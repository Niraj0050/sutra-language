#!/usr/bin/env bash
# verify_emit_full.sh — split IR pipeline बनाम interpreter, पूरे tests/compiler सुइट पर
#   अग्र_चालक (.सूत्र → IR-पाठ)  →  पश्च_चालक (IR-पाठ → .s)  →  as → gcc → run
# हर टेस्ट का अपेक्षित परिणाम = ./sutra.exe run <file>
set -u
export PATH="/c/msys64/ucrt64/bin:$PATH"
cd "$(dirname "$0")"
COMPILER="${1:-./sutrac.exe}"
FRONT="स्वसंकलक/अग्र_चालक.सूत्र"; BACK="स्वसंकलक/पश्च_चालक.सूत्र"
FRONT_EXE="${FRONT}_native.exe"; BACK_EXE="${BACK}_native.exe"
RT="sutra_runtime_prebuilt.o sutra_alloc.o sutra_srt.o sutra_floor.o"
W=/tmp/vef; mkdir -p "$W"

if [ "${SKIP_BUILD:-0}" != "1" ]; then
  rm -f "$FRONT_EXE" "$BACK_EXE"
  echo "अग्र_चालक संकलन..."; "$COMPILER" "$FRONT" >/dev/null 2>&1
  [ -x "$FRONT_EXE" ] || { echo "अग्र_चालक compile विफल"; exit 1; }
  echo "पश्च_चालक संकलन..."; "$COMPILER" "$BACK" >/dev/null 2>&1
  [ -x "$BACK_EXE" ] || { echo "पश्च_चालक compile विफल"; exit 1; }
fi

pass=0; fail=0; skip=0
declare -a FAILED
for f in $(ls tests/compiler/*.सूत्र | sort); do
  name="$(basename "$f")"
  ./sutra.exe run "$f" > "$W/iout" 2>"$W/ierr"; irc=$?
  exp="$(sed 's/\x0d//g' "$W/iout")"
  if [ "$irc" -ne 0 ] || [ -s "$W/ierr" ]; then
    echo "  [SKIP] $name  (interpreter असमर्थ)"; skip=$((skip+1)); continue
  fi
  if ! "./$FRONT_EXE" "$f" > "$W/ir" 2>"$W/e"; then
    echo "  [FAIL] $name — अग्र: $(head -1 "$W/e")"; fail=$((fail+1)); FAILED+=("$name"); continue
  fi
  if ! "./$BACK_EXE" "$W/ir" > "$W/s" 2>"$W/e"; then
    echo "  [FAIL] $name — पश्च: $(head -1 "$W/e")"; fail=$((fail+1)); FAILED+=("$name"); continue
  fi
  if ! as -o "$W/o" "$W/s" 2>"$W/e"; then
    echo "  [FAIL] $name — as: $(head -1 "$W/e")"; fail=$((fail+1)); FAILED+=("$name"); continue
  fi
  if ! gcc -m64 "$W/o" $RT -lshell32 -o "$W/exe" 2>"$W/e"; then
    echo "  [FAIL] $name — link: $(head -1 "$W/e")"; fail=$((fail+1)); FAILED+=("$name"); continue
  fi
  got="$("$W/exe" 2>&1 | sed 's/\x0d//g')"
  if [ "$got" = "$exp" ]; then
    echo "  [PASS] $name"; pass=$((pass+1))
  else
    echo "  [FAIL] $name — output"
    diff <(printf '%s' "$exp") <(printf '%s' "$got") | head -6 | sed 's/^/         /'
    fail=$((fail+1)); FAILED+=("$name")
  fi
done
echo
echo "  PASS: $pass   FAIL: $fail   SKIP: $skip   (कुल $((pass+fail+skip)))"
[ "$fail" -gt 0 ] && { echo "  विफल: ${FAILED[*]}"; }
exit 0
