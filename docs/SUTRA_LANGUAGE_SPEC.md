# सूत्र (Sutra) 1.0.0 — Language Specification

**Version:** 1.0.0  
**Language Name:** सूत्र (Sutra)  
**Status:** Feature Complete & Stabilized  

---

## 1. Introduction
सूत्र (Sutra) is an elegant, dynamically-typed Hindi/Sanskrit programming language built in modern C++. It provides a fully native Devanagari environment for learning and executing algorithms, complete with Hindi keywords, UTF-8 strings, Object-Oriented Programming (OOP), exception handling, module importing, standard math/string libraries, and an interactive REPL.

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
मान अ = 10;
संख्या आयु = 25;
दशमलव पाई = 3.14;
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
अगर (अंक >= 90) {
    लिखतु("श्रेणी: A");
} अन्यथा {
    अगर (अंक >= 70) {
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
मान count = 1;
जबतक (count <= 3) {
    लिखतु(count);
    count = count + 1;
}

पुनरावृत्तिः (मान i = 0; i < 5; i = i + 1) {
    लिखतु(i);
}
```

---

## 9. Break & Continue
- `विरामः` — Terminates loop execution (Break).
- `जारीरह` / `अग्रिमः` — Skips current iteration to next iteration (Continue).

```sutra
पुनरावृत्तिः (मान i = 1; i <= 5; i = i + 1) {
    यदि (i == 3) {
        जारीरह;
    }
    यदि (i == 5) {
        विरामः;
    }
    लिखतु(i);
}
```

---

## 10. Functions
Functions are declared using `कार्य`, support typed/untyped parameters, and return values via `परत्`.

```sutra
कार्य योग(संख्या क, संख्या ख) {
    परत् क + ख;
}

मान परिणाम = योग(10, 20);
```

---

## 11. Input / Output
- `लिखतु(मान)` — Prints value with newline.
- `दर्शयतु(मान)` — Prints value without newline.
- `पंक्तिं()` — Prints newline.
- `पठतु()` — Reads UTF-8 input string from standard input.

---

## 12. Arrays
Dynamic array literal `[...]`, indexing `arr[i]`, and element assignment `arr[i] = val`.

```sutra
सूची फल = ["आम", "केला"];
फल[1] = "सेब";
लिखतु(फल[1]);
```

---

## 13. Error Handling
Sutra provides structured exception handling via `प्रयत्न` (try), `पकड़ो` (catch), and `प्रक्षेपः` (throw).

```sutra
प्रयत्न {
    यदि (आयु < 18) {
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

मान परिणाम = योग(5, 10);
```

---

## 15. Standard Library
Built-in functions exposed in global runtime scope:
- **Math:** `वर्गमूल(x)`, `घात(x, y)`, `निरपेक्ष(x)`, `न्यूनतम(a, b)`, `अधिकतम(a, b)`, `गोल(x)`
- **String & List:** `लंबाई(val)`, `उच्च(str)`, `निम्न(str)`, `प्रकार(val)`, `जोड़ें(list, val)`

---

## 16. Classes and Objects (OOP)
- `वर्ग` — Defines a class.
- `नवीन` — Instantiates a class object.
- `स्व` — Refers to current instance (`this`).
- `रचना` — Constructor method name.

```sutra
वर्ग छात्र {
    पाठ नाम = "";

    कार्य रचना(पाठ n) {
        स्व.नाम = n;
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
