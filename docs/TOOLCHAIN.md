# सूत्र साधनसमूहम् (Sutra Toolchain) Documentation

This document describes the utilities and developer tools included in the Sutra programming language toolchain. In accordance with the Pure Sutra Git policy, the C++ sources for these tools reside locally in the developer environment to assist in bootstrapping and verification, and are excluded from Git tracking.

---

## 1. सूत्र-स्वरूपक (Sutra Code Formatter)

The Sutra code formatter (`sutra_formatter.exe`) formats Sutra source code (`.सूत्र` files) into a deterministic, canonical, and readable style.

### Formatting Rules
* **Indentation**: 4 spaces per nesting level. No tabs are allowed.
* **Operators**: Spacing around binary operators (`+`, `-`, `*`, `/`, `%`, `=`, `==`, `!=`, `>`, `<`, `>=`, `<=`, `&&`, `||`, `तथा`, `अथवा`). Unary operators (`-`, `!`, `न`) do not have space between them and their operands.
* **Keywords**: Spacing after keywords (like `यदि`, `कार्य`, `लौटाओ`, `परत्`, `मान`, `संख्या`, `दशमलव`, `पाठ`, `बूल`, `सूची`, `शब्दकोश`, `वर्ग`, `प्रयत्न`, `पकड़ो`, `प्रक्षेपः`, `फेको`, `आयात`).
* **Punctuation**:
  - Comma `,`: No space before, one space after.
  - Semicolon `;`: No space before, newline after (except inside `पुनरावृत्तिः` loop parenthesized headers).
  - Colon `:`:
    - In dictionary literals: no space before, one space after.
    - In explicit type declarations (like `मान:संख्या`): no spaces around the colon.
* **Braces and Blocks**:
  - Spaces before opening braces `{` (e.g. `यदि (क > ख) {`).
  - Block braces: increment indentation after `{` and insert newline; decrement indentation before `}` and insert newline.
  - Dictionary literal braces `{}`: formatted inline without newlines or indentation changes if they fit on a single line or are empty.
* **Comments**: Standalone comments are preserved on their own lines, indented correctly. Inline comments are printed on the same line as the preceding code.
* **Blank Lines**: Logical blank lines are preserved and normalized to at most one consecutive blank line.
* **Devanagari / UTF-8**: All Devanagari identifiers, keywords, digits, and string literal contents are preserved without any byte corruption.
* **Idempotency**: The formatter is strictly idempotent: `F(F(source)) == F(source)`.

### Command Line Interface (CLI)
```text
sutra_formatter <source_file> [options]
```

#### Options:
* `--input <file>`: Input file path.
* `--output <file>`: Output file path (defaults to stdout).
* `--check`: Checks if formatting changes are needed. If the file is not in canonical format, returns exit code `2` (`ExitCode::DIAGNOSTIC_ERROR`). Otherwise, returns `0`.
* `--write`: Formats the file in-place, overwriting the input file directly.
* `--verbose, -v`: Prints detailed processing information.
* `--help, -h`: Displays help information.

#### Examples:
```bash
# Preview formatting changes to console
./sutra_formatter.exe नमस्ते.सूत्र

# Check if file is formatted
./sutra_formatter.exe --check नमस्ते.सूत्र

# Format file in-place
./sutra_formatter.exe --write नमस्ते.सूत्र
```

---

## 2. सूत्र-निरीक्षक (Sutra Code Linter)

The Sutra code linter (`sutra_linter.exe`) performs static analysis on Sutra source code to detect code quality issues, unused declarations, and common bugs.

### Lint Rules

| Rule ID | Rule Name | Description |
|---|---|---|
| **L001** | Unused Variable | Detects local variables declared but never read subsequently. |
| **L002** | Unused Function Parameter | Detects function parameters declared but never used in the function body. |
| **L003** | Unreachable Code | Detects statements that appear after unconditional termination statements (`परत्` / return, `विरामः` / break, `अग्रिमः` / continue, `फेको` / throw) in the same block. |
| **L004** | Empty Block | Identifies empty block statements (`{}`) that contain no statements. Intentionally empty dictionaries are ignored. |
| **L005** | Constant Condition | Detects conditional or loop headers that contain boolean literal conditions (`सत्य` / `असत्य`), representing constant conditions. |
| **L006** | Duplicate / Redundant Branch | Checks for identical block implementations in `यदि`/`अन्यथा` paths or redundant duplicate conditional expressions in if-else chains. (Disabled by default, enable via options). |
| **L007** | Self Assignment | Identifies redundant statements where a variable is assigned to itself (e.g. `अ = अ;`). |
| **L008** | Unused Expression Result | Detects statements that compute expression values without producing any side effects (e.g. `अ + 5;` as a standalone statement). Function calls are not flagged. |

### Command Line Interface (CLI)
```text
sutra_linter <source_file> [options]
```

#### Options:
* `--input <file>`: Input file path.
* `--rule-L006`: Enables rule L006 (Duplicate Branch) check.
* `--verbose, -v`: Prints detailed processing log messages.
* `--help, -h`: Displays help documentation.

#### Exit Codes:
* `0`: Success. No warnings or errors found.
* `1`: Invalid arguments or failed to load files.
* `2`: Lint warnings or errors were detected.
* `3`: Internal system failures.

#### Examples:
```bash
# Lint a source file
./sutra_linter.exe नमस्ते.सूत्र

# Lint with rule L006 enabled and verbose logs
./sutra_linter.exe --input नमस्ते.सूत्र --rule-L006 --verbose
```

---

## 3. सूत्र-त्रुटिशोधकम् (Sutra Code Debugger)

The Sutra code debugger (`sutra_debugger.exe`) provides an interactive CLI debugging session for stepping through Sutra programs, inspecting variable environments, and handling breakpoints.

### Interactive Debugger Commands

| English Commands | Sanskrit Commands | Description |
|---|---|---|
| `step`, `s` | `पग`, `डग`, `ड` | Step to the next statement (step-into functions). |
| `continue`, `c` | `चलाओ`, `च` | Resume program execution until the next breakpoint. |
| `break <line>`, `b <line>` | `अवरोधः <line>`, `ब <line>` | Set a breakpoint at the specified line number. |
| `delete [line]`, `d [line]` | `निवारय [line]`, `न [line]` | Remove a breakpoint at a line, or clear all if line is omitted. |
| `print <var>`, `p <var>` | `लिखो <var>`, `ल <var>` | Print the value of a variable in the active lexical scope. |
| `info`, `i` | `विवरण` | Show all variables active in the current scope hierarchy. |
| `list`, `l` | `सूची` | List lines of source code context around the active line. |
| `help`, `h` | `सहायता` | Print the list of available interactive commands. |
| `exit`, `q`, `quit` | `निकास` | Exits the debugging session. |

### Command Line Interface (CLI)
```text
sutra_debugger <source_file> [options]
```

#### Options:
* `--input <file>`: Input file path.
* `--verbose, -v`: Prints detailed processing log messages.
* `--help, -h`: Displays help documentation.

#### Examples:
```bash
# Start an interactive debugging session
./sutra_debugger.exe नमस्ते.सूत्र
```

---

## 4. सूत्र-पैकेज-प्रबन्धकम् (Sutra Package Manager)

The Sutra package manager (`sutra_pkgmgr.exe`) initialized, installs, lists, and uninstalls local packages and modules for Sutra projects.

### Package Manifest Format (`पैकेज.सूत्र`)
The manifest uses standard Sutra dictionary notation, allowing it to be parsed directly using the compiler AST parser without secondary configuration parsers.
```sutra
मान पैकेज = {
    "नाम": "नूतन_संकुलम्",
    "वर्जन": "1.0.0",
    "लेखक": "अन्तरिक्षः",
    "विवरण": "नूतनम् सूत्र संकुलम्",
    "निर्भरताएँ": {
        "सहायक": "^1.0.0"
    }
};
```

### CLI Commands
```text
sutra_pkgmgr <निर्देशः (command)> [options]
```

#### Commands:
* `init [नाम]`: Initializes a new package manifest (`पैकेज.सूत्र`) in the current directory.
* `install [मार्गः]`: If a local directory or `.सूत्र` module path is specified, copies/installs it into the local project folder `संकुलानि/` and updates project dependencies. If no path is specified, verifies that all dependencies listed in the manifest are present in the `संकुलानि/` folder.
* `remove <नाम>`: Uninstalls the package from `संकुलानि/` and deletes it from dependencies.
* `list`: Lists all installed local packages and modules in `संकुलानि/`.

#### Options:
* `--verbose, -v`: Prints detailed processing log messages.
* `--help, -h`: Displays help documentation.

#### Examples:
```bash
# Initialize a new manifest
./sutra_pkgmgr.exe init क्रीडा_संकुलम्

# Install a local package
./sutra_pkgmgr.exe install ../गणित_सहायक

# List installed packages
./sutra_pkgmgr.exe list
```

---

## 5. सूत्र-निर्माण-तन्त्रम् (Sutra Build System)

The Sutra build system (`sutra_build.exe`) provides a unified tool to compile, validate, and clean projects based on settings declared in the package manifest (`पैकेज.सूत्र`).

### Manifest Build Configurations
Under the `पैकेज` dictionary literal declaration, you can configure build settings using the `"निर्माण"` key:
```sutra
मान पैकेज = {
    "नाम": "क्रीडा",
    "वर्जन": "1.0.0",
    "निर्माण": {
        "प्रवेश_बिंदु": "मुख्य.सूत्र",
        "निर्गम": "लक्ष्य/क्रीडा.exe",
        "स्वरूपण": "असत्य",
        "निरीक्षण": "सत्य"
    }
};
```
* **`प्रवेश_बिंदु` / `entry_point`**: The main entry point file. Defaults to `मुख्य.सूत्र` or `main.सूत्र`.
* **`निर्गम` / `output`**: The target binary output path. Defaults to `निर्माण/मुख्य.exe`.
* **`स्वरूपण` / `format`**: Enables formatting before compilation. Defaults to `असत्य` (false).
* **`निरीक्षण` / `lint`**: Enables linter verification before compilation. Defaults to `असत्य` (false).

### Command Line Interface (CLI)
```text
sutra_build <निर्देशः (command)> [options]
```

#### Commands:
* `build`: Compiles the project according to settings (default command).
* `clean`: Deletes all generated artifacts (recursively removes `निर्माण/` folder).

#### Options:
* `--no-format`: Prevents pre-compilation source formatting.
* `--no-lint`: Prevents pre-compilation linter validation.
* `--debug`: Compiles with debugging metadata symbols.
* `--release`: Compiles optimized binary (default).
* `--verbose, -v`: Prints detailed compiler IR translation messages.
* `--help, -h`: Displays help documentation.

#### Exit Codes:
* `0`: Build/clean completed successfully.
* `1`: Invalid arguments or failed to parse package configurations.
* `2`: Compilation diagnostics/errors encountered during validation or build.
* `3`: OS file linking or compiler execution failures.

#### Examples:
```bash
# Build the project
./sutra_build.exe build

# Clean generated executable binaries
./sutra_build.exe clean
```

---

## 6. सूत्र-भाषा-सर्वर (Sutra Language Server)

The Sutra language server (`sutra_lsp.exe`) implements the Language Server Protocol (LSP) over standard I/O streams. It provides real-time document diagnostics, autocomplete suggestions, hover scope lookups, and go-to-definition mappings to integrated developer environments (IDEs).

Refer to the complete [Sutra Language Server (LSP) Specification](file:///d:/my%20project/सूत्र/docs/LANGUAGE_SERVER.md) for transportation framing formats and detailed editor configurations.

