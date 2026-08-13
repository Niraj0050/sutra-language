# सूत्र (Sutra) — Sanskrit Programming Language

**सूत्र (Sutra)** is a modern, independent, general-purpose Sanskrit-first programming language with its own compiler, interpreter, AST parser, semantic analyzer, CLI launcher, test suite, and standard library foundation.

---

## 🌟 Quick Start (शीघ्र-प्रारम्भः)

### 1. Build using CMake & MinGW / MSVC

```bash
mkdir build
cd build
cmake .. -G "MinGW Makefiles"
cmake --build .
```

### 2. Run Sutra Program (निष्पादनम्)

```bash
# Using CLI wrapper command:
सूत्र चलाओ नमस्ते.सूत्र

# Direct executable invocation:
./sutra चलाओ नमस्ते.सूत्र
```

Expected Output:
```text
नमस्ते जगत्!
```

---

## 📜 Code Example (`.सूत्र`)

```text
कार्य मुख्य() {
    लिखतु("नमस्ते जगत्!");
}
```

Arithmetic & Variables:

```text
कार्य मुख्य() {
    संख्या अ = 10;
    संख्या ब = 20;
    लिखतु("परिणामः अस्ति:");
    लिखतु(अ + ब);
}
```

Functions & Conditionals:

```text
कार्य जोड़ना(संख्या अ, संख्या ब) {
    परत् अ + ब;
}

कार्य मुख्य() {
    संख्या उत्तरम् = जोड़ना(15, 25);
    यदि (उत्तरम् >= 30) {
        लिखतु("बृहत् योगः");
    } अन्यथा {
        लिखतु("लघु योगः");
    }
}
```

---

## 📁 Project Structure (परियोजना-संरचना)

```text
सूत्र/
├── संकलक/                # Compiler & Runtime Core in C++
│   ├── include/sutra/    # C++ Headers (unicode, lexer, parser, ast, etc.)
│   └── src/              # Source Files
├── उपकरणानि/              # Sanskrit CLI Launcher scripts (सूत्र.cmd, सूत्र.ps1)
├── उदाहरणानि/             # Example programs (.सूत्र)
├── परीक्षणानि/            # Automated Test Suite (test_sutra.cpp)
├── दस्तावेजाः/            # Language Specifications & Docs in Sanskrit
├── CMakeLists.txt        # Build System Configuration
└── README.md
```

---

## 🧪 Run Automated Tests (परीक्षणानि)

```bash
cd build
./test_sutra
```

---

## 📄 License
MIT License
