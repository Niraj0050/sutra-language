# Language Grammar, Syntax, Formatter, and Linter Rules — सूत्र (Sutra)

This document contains the canonical rules for the Sutra programming language lexical grammar, syntax constraints, indentation standards, and code quality lint patterns.

---

## 1. Lexical Grammar & Unicode Devanagari Constraints

Sutra enforces native Devanagari script integration directly in its scanner/lexer phase:

### 1.1 Identifier Start Characters
* **Rule**: All identifiers (variable names, function names, class names, etc.) must begin strictly with a Devanagari letter character.
* **Range**: Unicode codepoints between `0x0904` and `0x097F` (representing Devanagari vowels and consonants).
* **ASCII Prohibition**: English alphabetic characters (`a-z`, `A-Z`) are strictly forbidden as the first character of an identifier. Attempting to start a variable with an English character will trigger an `अक्षर-वाचन-त्रुटिः — अज्ञातः वर्णः` (Lexer error — Unknown character) diagnostic.

### 1.2 Identifier Continuation Characters
* **Rule**: Once started with a valid Devanagari character, an identifier can continue with:
  1. Devanagari letters.
  2. Devanagari combining marks (vowel signs, virama, nasalization marks, etc.).
  3. Devanagari numerals (`०-९`).
  4. ASCII digits (`0-9`).
  5. The underscore symbol (`_`).

### 1.3 Numeric Literals
* **Rule**: Sutra supports floating-point and integer literals declared using standard ASCII numbers (`0-9`) or Devanagari numerals (`०-९`).
* **Example**: `१०` is evaluated as the integer `10`. `३.१४` is evaluated as the float `3.14`.

### 1.4 Comments
* **Single Line**: Commenced by `//` and terminated by a newline.
* **Multi-line Block**: Commenced by `/*` and terminated by `*/`.

---

## 2. Syntax Grammar & Keyword Catalog

Sutra statements are terminated by a semicolon `;`. The syntax grammar incorporates 27 keywords:

| Keyword | Purpose | Equivalent |
|---|---|---|
| `कार्य` | Function declaration | `function` |
| `मुख्य` | Main program entry function name | `main` |
| `लिखतु` | Console print value with trailing newline | `print` |
| `दर्शयतु` | Console print value without trailing newline | `print_no_newline` |
| `पंक्तिं` | Prints a newline character | `print_newline` |
| `पठतु` | Reads string line from standard input | `read_line` |
| `यदि` / `अगर` | Conditional check header | `if` |
| `अन्यथा` | Conditional else fallback block | `else` |
| `यावत्` / `जबतक` | While loop block header | `while` |
| `पुनरावृत्तिः` | For loop block header | `for` |
| `विरामः` | Immediately break out of a loop | `break` |
| `जारीरह` / `अग्रिमः` | Skip current iteration to next loop pass | `continue` |
| `परत्` / `लौटाओ` | Return value from a function | `return` |
| `सत्य` | Boolean literal true value | `true` |
| `असत्य` | Boolean literal false value | `false` |
| `शून्यम्` | Null value literal | `null` |
| `मान` | Untyped local variable declaration keyword | `var` |
| `संख्या` | Type-aliased integer declaration keyword | `int` |
| `दशमलव` | Type-aliased float declaration keyword | `float` |
| `पाठ` | Type-aliased string declaration keyword | `string` |
| `बूल` | Type-aliased boolean declaration keyword | `bool` |
| `सूची` | Type-aliased dynamic array declaration keyword | `list` |
| `शब्दकोश` | Type-aliased dictionary declaration keyword | `dictionary` |
| `वर्ग` | Class structure declaration keyword | `class` |
| `नवीन` | Instantiate class instance | `new` |
| `स्व` | Reference pointer inside methods | `this` |
| `रचना` | Constructor method name inside classes | `constructor` |
| `प्रयत्न` | Try exception catch frame block | `try` |
| `पकड़ो` | Catch exception declaration block | `catch` |
| `प्रक्षेपः` / `फेको` | Throw/Raise exception value | `throw` |
| `आयात` | Import external module source files | `import` |
| `विदेशी` | Declare a foreign (DLL) function | `extern`/`FFI` |

---

## 2a. Foreign Function Interface (`विदेशी`)

Sutra programs can call functions exported by a Windows DLL — the same
mechanism that gives every Sutra binary its `KERNEL32.dll`/`SHELL32.dll`
imports is exposed to user code. This makes Sutra's language surface usable
beyond console/compute programs (GUI, networking, OS services) without
translating any code to another language.

**Declaration** (top level, outside any function):

```sutra
विदेशी "पुस्तकालय" "AsliProtiik" सूत्र_नाम(संख्या, संख्या, ...);
```

* `"पुस्तकालय"` — the DLL to link against, without extension (e.g. `"user32"`
  → `-luser32`; resolved at link time by the existing `gcc`/`ld` step, so any
  import library `ld` can find works). `विदेशी` may be Latin (`GetTickCount`)
  because it is a string literal, not an identifier — Sutra identifiers still
  cannot start with or contain Latin letters, so the foreign symbol's real
  name never has to be typed as a Sutra name.
* `सूत्र_नाम` — the Devanagari name your code calls it by; must follow normal
  identifier rules.
* Argument list — v1 supports only `संख्या` (i64) parameters, and the return
  value is always `संख्या`. Everything is passed/returned in general-purpose
  registers, matching the **Microsoft x64 calling convention**, which is what
  both Sutra backends already emit for every call (x86 backend: `उत्_कॉल` puts
  the first four args in `rcx`/`rdx`/`r8`/`r9` with a 32-byte shadow space
  before every `call`; `--release`: `clang` targets the platform ABI
  directly) — so a `विदेशी` call needed **no emitter changes**, only a
  declaration → symbol-table entry → raw `call`/`declare` of the real name.

**Calling it** — like any other function:

```sutra
विदेशी "kernel32" "GetTickCount" घड़ी_टिक();
विदेशी "kernel32" "Sleep" सोओ(संख्या);
विदेशी "user32" "GetSystemMetrics" स्क्रीन_माप(संख्या);

कार्य मुख्य() {
    लिखतु(घड़ी_टिक());        // ms since boot
    सोओ(500);                  // real Sleep(), pauses 500ms
    लिखतु(स्क्रीन_माप(0));    // SM_CXSCREEN — screen width in px
}
```

**Strings.** A Sutra `पाठ` is already NUL-terminated in memory (every
allocator path appends a trailing `\0` after the UTF-8 bytes — see
`पाठ_आवंटित` in `मूल_रनटाइम.सूत्र`), so passing one to a foreign `char*`
parameter needs no conversion step, only its raw data pointer:

```sutra
विदेशी "user32" "MessageBoxA" संदेश_दिखाओ(संख्या, संख्या, संख्या, संख्या);
कार्य मुख्य() {
    पाठ संदेश = "नमस्ते!";
    संदेश_दिखाओ(0, विदेशी_पता(संदेश), विदेशी_पता("शीर्षक"), 0);
}
```

* `विदेशी_पता(वस्तु)` — raw i64 address of a `पाठ`'s (or `सूची`'s) data
  region; `0` (the empty/null Sutra handle) maps to a real `NULL` pointer.
  The GC is mark-sweep (non-moving), so the address stays valid for as long
  as the caller keeps the source object reachable (e.g. in a local variable)
  across the call.
* `विदेशी_से_पाठ(सूचक)` — the inverse: reads NUL-terminated bytes at a raw
  address (e.g. one a foreign function returned) into a new Sutra `पाठ`.

**Limits (v1):** arguments/return are `संख्या` only — no `दशमलव` (XMM
registers), no passing a `सूची` element-for-element (only its raw pointer,
via `विदेशी_पता`, for treating it as a byte buffer). A `पाठ` with an embedded
NUL byte will read short through `विदेशी_पता` (a C-string limitation, not a
Sutra one). The split IR-serialization path (`अग्र_चालक`/`पश्च_चालक`,
internal dev tooling) round-trips the library list but does not itself run a
link step, so `विदेशी_पुस्तकालय` is consumed only by the normal
`sutrac.exe [--release]` build path.

---

## 3. Formatter Rules (`sutra_formatter.exe`)

The formatter implements a deterministic style to ensure code is clean and readable:

* **Indentation**: Exactly 4 spaces per block indentation depth. Tabs are strictly forbidden.
* **Unary Operator Spacing**: No spaces between unary operators (`-`, `!`, `न`) and their target operands (e.g. `-वयः` or `!सक्रिय`).
* **Binary Operator Spacing**: Exactly one space on both sides of binary operator tokens (`+`, `-`, `*`, `/`, `%`, `=`, `==`, `!=`, `>`, `<`, `>=`, `<=`, `&&`, `||`, `तथा`, `अथवा`).
* **Comma and Semicolon Spacing**: No space before, exactly one space after commas. Semicolons are immediately followed by a newline, unless they occur inside the three-part header of a `पुनरावृत्तिः` loop statement.
* **Curly Braces Block formatting**:
  - Open braces `{` must have a preceding space (e.g. `कार्य योग() {`).
  - Code lines inside blocks are indented by 4 spaces.
  - The closing brace `}` must align with the start of the line that opened the block.
* **Dictionary Braces**: Empty dictionaries (`{}`) or short inline key-value initializers are printed on a single line. Nested or longer dictionary literals are split into newlines.
* **Normalized blank lines**: Reduces contiguous blank lines in the source down to a maximum of one blank line.
* **Idempotency**: Running the formatter multiple times must yield identical output: `F(F(source)) == F(source)`.

---

## 4. Linter Analysis Rules (`sutra_linter.exe`)

The static analyzer checks code rules to catch programming defects early:

| Code | Rule Name | Description |
|---|---|---|
| **L001** | Unused Variable | Flags variables that are declared in local scopes but never read in subsequent statements. |
| **L002** | Unused Function Parameter | Flags variables declared in function parameters that are not used in the function body block. |
| **L003** | Unreachable Code | Flags statement lines occurring after statements that exit the block (`परत्`, `लौटाओ`, `विरामः`, `अग्रिमः`, `जारीरह`, `प्रक्षेपः`, `फेको`). |
| **L004** | Empty Block | Detects empty statements blocks (`{}`). Empty dictionary initializations are excluded from this rule. |
| **L005** | Constant Condition | Flags condition headers using constant booleans (`सत्य` or `असत्य`), indicating dead branch code or infinite loops. |
| **L006** | Duplicate / Redundant Branch | Checks for identical block implementations in `यदि`/`अन्यथा` paths or redundant conditional expressions in if-else chains. (Disabled by default). |
| **L007** | Self Assignment | Catches redundant assignment lines where a variable is assigned to itself (e.g. `वयः = वयः;`). |
| **L008** | Unused Expression Result | Detects statements that compute expressions without producing side-effects (e.g. `वयः + 10;` as a standalone statement). Function calls are excluded. |
