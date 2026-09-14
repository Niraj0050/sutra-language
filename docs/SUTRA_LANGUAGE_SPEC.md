# सूत्र (Sutra) 1.0.0 — Language Specification

**Version:** 1.0.0  
**Language Name:** सूत्र (Sutra)  
**Status:** Feature Complete & Stabilized  

---

## 1. Introduction
Sutra (Sutra) is a Sanskrit/Hindi-first, Devanagari-native general-purpose programming language. The canonical compiler is written in Sutra itself, supported by a native C++ bootstrap and runtime execution environment maintained locally. It provides a native Devanagari syntax for executing algorithms, complete with keywords, UTF-8 strings, Object-Oriented Programming (OOP), exception handling, module importing, standard math/string libraries, and an interactive REPL.

---

## 2. Installation & Compilation
Sutra can be built from source using CMake or MinGW C++ compiler on Windows, Linux, or macOS.

### Building on Windows (PowerShell):
```powershell
powershell -ExecutionPolicy Bypass -File .\build.ps1
```
This produces `sutra.exe` in the project root directory.

---

## 3. Hello World
```sutra
लिखतु("नमस्ते संसार!");
```

---

## 4. Variables
Variables can be declared using untyped declaration `मान` or type-aliased keywords (`संख्या`, `दशमलव`, `पाठ`, `बूल`, `सूची`).

```sutra
मान अ = १०;
संख्या आयु = २५;
दशमलव पाई = ३.१४;
पाठ नाम = "राधा";
बूल सक्रिय = सत्य;
```

---

## 5. Data Types
Sutra supports 6 core value types:
1. `संख्या` (Integer - 64-bit integer, supports Devanagari numerals `०-९`)
2. `दशमलव` (Float - double precision float)
3. `पाठ` (String - UTF-8 Devanagari & ASCII string)
4. `बूल` (Boolean - `सत्य` / `असत्य`)
5. `सूची` (Array / List - dynamic homogeneous or heterogenous list)
6. `शून्यम्` (Null value)

---

## 6. Operators
- **Arithmetic:** `+`, `-`, `*`, `/`, `%`
- **Unary:** `-`
- **Comparison:** `==`, `!=`, `>`, `<`, `>=`, `<=`
- **Logical:** `&&` / `तथा`, `||` / `अथवा`, `!` / `न`
- **Assignment:** `=`

---

## 7. Conditions
Conditional branching supports `अगर` / `यदि` and `अन्यथा`.

```sutra
अगर (अंक >= ९०) {
    लिखतु("श्रेणी: A");
} अन्यथा {
    अगर (अंक >= ७०) {
        लिखतु("श्रेणी: B");
    } अन्यथा {
        लिखतु("श्रेणी: C");
    }
}
```

---

## 8. Loops
Sutra supports `यावत्` / `जबतक` (while loops) and `पुनरावृत्तिः` (for loops).

```sutra
मान गणना = १;
जबतक (गणना <= ३) {
    लिखतु(गणना);
    गणना = गणना + १;
}

पुनरावृत्तिः (मान इ = १; इ <= ५; इ = इ + १) {
    लिखतु(इ);
}
```

---

## 9. Break & Continue
- `विरामः` — Terminates loop execution (Break).
- `जारीरह` / `अग्रिमः` — Skips current iteration to next iteration (Continue).

```sutra
पुनरावृत्तिः (मान इ = १; इ <= ५; इ = इ + १) {
    यदि (इ == ३) {
        जारीरह;
    }
    यदि (इ == ५) {
        विरामः;
    }
    लिखतु(इ);
}
```

---

## 10. Functions
Functions are declared using `कार्य`, support typed/untyped parameters, and return values via `परत्`.

```sutra
कार्य योग(संख्या क, संख्या ख) {
    परत् क + ख;
}

मान परिणाम = योग(१०, २०);
```

---

## 11. Input / Output
- `लिखतु(मान)` — Prints value with newline.
- `दर्शयतु(मान)` — Prints value without newline.
- `पंक्तिं()` — Prints newline.
- `पठतु()` — Reads UTF-8 input string from standard input.

---

## 12. Arrays
Dynamic array literal `[...]`, indexing `सूची[इ]`, and element assignment `सूची[इ] = मान`.

```sutra
सूची फल = ["आम", "केला"];
फल[१] = "सेब";
लिखतु(फल[१]);
```

---

## 13. Error Handling
Sutra provides structured exception handling via `प्रयत्न` (try), `पकड़ो` (catch), and `प्रक्षेपः` (throw).

```sutra
प्रयत्न {
    यदि (आयु < १८) {
        प्रक्षेपः "अमान्य आयु!";
    }
} पकड़ो (त्रुटि) {
    लिखतु("गृहीता त्रुटि: " + त्रुटि);
}
```

---

## 14. Modules & Import System
Modules are imported using `आयात "मार्ग.सूत्र";`. Imported modules are loaded once with circular import protection.

```sutra
आयात "गणित_सहायक.सूत्र";

मान परिणाम = योग(५, १०);
```

---

## 15. Standard Library
Built-in functions exposed in global runtime scope:
- **Math:** `वर्गमूल(संख्या)`, `घात(आधार, घातांक)`, `निरपेक्ष(मान)`, `न्यूनतम(संख्या१, संख्या२)`, `अधिकतम(संख्या१, संख्या२)`, `गोल(मान)`
- **String & List:** `लंबाई(मान)`, `उच्च(पाठ्य)`, `निम्न(पाठ्य)`, `प्रकार(मान)`, `जोड़ें(सूची, मान)`

---

## 16. Classes and Objects (OOP)
- `वर्ग` — Defines a class.
- `नवीन` — Instantiates a class object.
- `स्व` — Refers to current instance (`this`).
- `रचना` — Constructor method name.

```sutra
वर्ग छात्र {
    पाठ नाम = "";

    कार्य रचना(पाठ न) {
        स्व.नाम = न;
    }

    कार्य वदतु() {
        लिखतु("नाम: " + स्व.नाम);
    }
}

मान स = नवीन छात्र("अमित");
स.वदतु();
```

---

## 17. REPL
Launch REPL by running `sutra.exe` with no arguments.
- Multi-line block detection using `{ ... }`.
- Special REPL commands: `सहायता` (help), `संस्करण` (version), `साफ` (clear screen), `बाहर` / `निकास` / `निर्गमः` (exit).

---

## 18. Comments
- Line comments start with `//`.
- Block comments use `/* ... */`.

---

## 19. Unicode & Devanagari Support
Full UTF-8 support across identifiers, strings, keywords, REPL input, and Devanagari numerals (`०-९`).

---

## 20. Command Line Interface (CLI)
- `sutra <file.सूत्र>` — Executes a Sutra source file.
- `sutra चलाओ <file.सूत्र>` — Executes a Sutra source file.
- `sutra --version` / `-v` / `sutra संस्करण` — Displays `सूत्र भाषा 1.0.0`.
- `sutra --help` / `-h` / `sutra सहायता` — Displays CLI usage guide.

---

## 21. Error Messages
Error messages follow a standardized Hindi/Sanskrit format including line and column numbers:
`त्रुटिः [पङ्क्तिः X, स्तम्भः Y]: वाक्य-विच्छेद-त्रुटिः — '...'`

---

## 22. Complete Examples
Refer to the [`examples/`](file:///d:/my%20project/%E0%A4%B8%E0%A5%82%E0%A4%A4%E0%A5%8D%E0%A4%B0/examples/) directory containing 11 runnable applications.

---

## 23. Current Limitations
- Single inheritance or interface contracts are not in 1.0 scope.
- Bitwise binary bit manipulation operators are reserved for future releases.
