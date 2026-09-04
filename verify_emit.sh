#!/usr/bin/env bash
# verify_emit.sh — IR उत्सर्जक (Phase 1e) end-to-end test
# split pipeline:  अग्र_चालक (.सूत्र → IR-पाठ)  →  पश्च_चालक (IR-पाठ → .s)
set -u
export PATH="/c/msys64/ucrt64/bin:$PATH"
cd "$(dirname "$0")"
COMPILER="${1:-./sutrac.exe}"
FRONT="स्वसंकलक/अग्र_चालक.सूत्र"
BACK="स्वसंकलक/पश्च_चालक.सूत्र"
FRONT_EXE="${FRONT}_native.exe"
BACK_EXE="${BACK}_native.exe"
RT="sutra_alloc.o sutra_srt.o sutra_floor.o"

rm -f sutra_native_temp.s "$FRONT_EXE" "$BACK_EXE"
echo "अग्र_चालक संकलन..."
"$COMPILER" "$FRONT" >/dev/null 2>&1
[ -x "$FRONT_EXE" ] || { echo "अग्र_चालक compile विफल"; exit 1; }
echo "पश्च_चालक संकलन..."
"$COMPILER" "$BACK" >/dev/null 2>&1
[ -x "$BACK_EXE" ] || { echo "पश्च_चालक compile विफल"; exit 1; }

pass=0; fail=0
check() {
  local name="$1" src="$2" exp="$3"
  printf '%s' "$src" > /tmp/ve.sutra
  if ! "./$FRONT_EXE" /tmp/ve.sutra > /tmp/ve.ir 2>/tmp/ve.fronterr; then
    echo "  [FAIL] $name — अग्र"; head -3 /tmp/ve.fronterr | sed 's/^/         /'; fail=$((fail+1)); return
  fi
  if ! "./$BACK_EXE" /tmp/ve.ir > /tmp/ve.s 2>/tmp/ve.backerr; then
    echo "  [FAIL] $name — पश्च"; head -3 /tmp/ve.backerr | sed 's/^/         /'; fail=$((fail+1)); return
  fi
  if ! as -o /tmp/ve.o /tmp/ve.s 2>/tmp/ve.aserr; then
    echo "  [FAIL] $name — as"; head -3 /tmp/ve.aserr | sed 's/^/         /'; fail=$((fail+1)); return
  fi
  if ! gcc -m64 -nostdlib -Wl,--no-undefined /tmp/ve.o $RT -lkernel32 -lshell32 -o /tmp/ve.exe 2>/tmp/ve.lderr; then
    echo "  [FAIL] $name — link"; head -3 /tmp/ve.lderr | sed 's/^/         /'; fail=$((fail+1)); return
  fi
  local got
  got="$(/tmp/ve.exe 2>&1 | sed 's/\x0d//g')"
  if [ "$got" = "$exp" ]; then echo "  [PASS] $name"; pass=$((pass+1))
  else echo "  [FAIL] $name  अपेक्षित={$exp}  मिला={$got}"; fail=$((fail+1)); fi
}
check "अंकगणित"      'कार्य मुख्य() { लिखतु(2 + 3 * 4); }' '14'
check "कार्य-कॉल"     'कार्य जोड़(संख्या अ, संख्या ब) { परत् अ + ब; } कार्य मुख्य() { लिखतु(जोड़(20, 22)); }' '42'
check "यावत्-लूप"     'कार्य मुख्य() { संख्या इ = 1; संख्या स = 0; यावत् (इ <= 100) { स = स + इ; इ = इ + 1; } लिखतु(स); }' '5050'
check "पुनरावर्तन"    'कार्य फ(संख्या क) { यदि (क <= 1) { परत् 1; } परत् क * फ(क - 1); } कार्य मुख्य() { लिखतु(फ(6)); }' '720'
check "यदि-अन्यथा"    'कार्य मुख्य() { संख्या क = 7; यदि (क > 5) { लिखतु(100); } अन्यथा { लिखतु(200); } }' '100'
check "तुलना-बूल"     'कार्य मुख्य() { लिखतु(3 < 5); लिखतु(9 > 20); }' $'सत्य\nअसत्य'
check "पाठ"            'कार्य मुख्य() { लिखतु("नमस्ते सूत्र"); }' 'नमस्ते सूत्र'
check "लघुपथ"          'कार्य मुख्य() { यदि (2 > 1 && 3 > 2) { लिखतु(1); } यदि (1 > 5 || 4 > 3) { लिखतु(2); } }' $'1\n2'
check "भाग-शेष"       'कार्य मुख्य() { लिखतु(17 / 5); लिखतु(17 % 5); }' $'3\n2'
check "वैश्विक-चर"     'संख्या ग = 10; कार्य बढ़ा() { ग = ग + 5; } कार्य मुख्य() { बढ़ा(); बढ़ा(); लिखतु(ग); }' '20'
check "पाठ-जोड़"       'कार्य मुख्य() { पाठ अ = "सू"; पाठ ब = "त्र"; लिखतु(अ + ब); }' 'सूत्र'
check "पाठ-तुलना"      'कार्य मुख्य() { पाठ अ = "क"; लिखतु(अ == "क"); लिखतु(अ == "ख"); }' $'सत्य\nअसत्य'
check "सूची"            'कार्य मुख्य() { सूची स = [10, 20, 30]; लिखतु(स[1]); लिखतु(लंबाई(स)); }' $'20\n3'
check "सूची-जोड़ें"     'कार्य मुख्य() { सूची स = [1]; स = जोड़ें(स, 2); स = जोड़ें(स, 3); लिखतु(लंबाई(स)); लिखतु(स[2]); }' $'3\n3'
check "शब्दकोश"         'कार्य मुख्य() { शब्दकोश द = {}; द["क"] = 5; द["ख"] = 9; लिखतु(द["क"] + द["ख"]); }' '14'
check "पाठ-सूचकांक"     'कार्य मुख्य() { पाठ स = "नमस्ते"; लिखतु(स[0]); लिखतु(लंबाई(स)); }' $'न\n6'
rm -f "$FRONT_EXE" "$BACK_EXE" sutra_native_temp.s
echo; echo "  PASS: $pass  FAIL: $fail"
[ "$fail" -eq 0 ]
