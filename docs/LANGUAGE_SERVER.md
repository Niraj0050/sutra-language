# सूत्र भाषा सर्वर (Sutra Language Server) Specification

This document details the architecture, build procedure, JSON-RPC transport framing, and supported capabilities of the Sutra Language Server (`sutra_lsp.exe`). In accordance with the Pure Sutra Git policy, the C++ sources for this LSP adapter reside locally in the developer workspace and are excluded from Git tracking.

---

## 1. Overview

The Sutra Language Server provides IDE integration capabilities for the Sutra programming language. It leverages the compiler's lexer, parser, semantic analyzer, and static linter to deliver real-time features like document validation (diagnostics), hover information, go-to-definition mapping, and auto-completions to supported editors (such as VS Code, Neovim, Emacs, or Sublime Text).

---

## 2. Compilation and Build

The LSP server is compiled as part of the unified CMake build target configuration.

### Prerequisites:
* MSYS2 / MinGW-w64 (GCC 9+ environment)
* CMake 3.16+
* `nlohmann/json.hpp` (automatically downloaded to `external/nlohmann` during build)

### Build Command:
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\build.ps1
```
This script generates the executable [`sutra_lsp.exe`](file:///d:/my%20project/सूत्र/sutra_lsp.exe) in the root workspace folder.

---

## 3. JSON-RPC 2.0 Transport Framing

Sutra LSP communicates with IDE clients via standard input (`stdin`) and standard output (`stdout`). All messages use the HTTP header style framing:
```text
Content-Length: <bytes>\r\n
\r\n
<JSON-RPC 2.0 Payload Body>
```

### Constraints:
* Headers are separated from the JSON-RPC payload by a blank line containing a carriage return and line feed (`\r\n\r\n`).
* No stray output (e.g. unformatted `std::cout` print logs) is allowed on `stdout`, as it will corrupt the JSON-RPC transport stream.
* Errors (such as malformed JSON parsing or invalid method names) are returned as standard JSON-RPC 2.0 error responses.

---

## 4. Supported LSP Methods

Sutra LSP implements the following protocol methods:

### 4.1 Lifecycle Methods
* **`initialize`**: Resolves capabilities, returning formatting, hover, definition, and autocomplete triggers. It sets `textDocumentSync` to `1` (Full document synchronization).
* **`initialized`**: Notification sent by the client indicating that the initialization exchange is complete.
* **`shutdown`**: Signals that the server is preparing to exit. Returns a `null` result.
* **`exit`**: Closes the stdin/stdout connection and terminates the server process.

### 4.2 Document Synchronization
* **`textDocument/didOpen`**: Registers the document uri and initializes text tokens and AST mappings.
* **`textDocument/didChange`**: Triggers full file content synchronization. Re-runs lexing, parsing, and semantic analysis to update caches.
* **`textDocument/didClose`**: Removes the document from the server's cache.

### 4.3 Language Features

#### Diagnostics (`textDocument/publishDiagnostics`)
* **Trigger**: Triggered automatically upon `didOpen` and `didChange`.
* **Details**: Reports compile errors, syntax errors, and semantic scoping issues (using severity `1` / Error) and linter rule warnings L001–L008 (using severity `2` / Warning) to the editor.

#### Hover (`textDocument/hover`)
* **Description**: Returns hover markdown text for variables, function signatures, types, keywords, and standard library built-ins under the cursor position.
* **Examples**:
  - Hovering on a declared variable `आयु` returns scope type details: `Symbol: आयु\nKind: variable\nType: संख्या\nDefined at line 3`.
  - Hovering on `लिखतु` returns details: `Built-in: लिखतु\nDescription: prints values to standard output...`.

#### Go to Definition (`textDocument/definition`)
* **Description**: Computes the inner-most scope declaration location of the identifier under the cursor, returning the target URI and start/end range.

#### Completions (`textDocument/completion`)
* **Description**: Suggests available variables/functions visible inside the current active block scope, built-in functions, and standard keywords.
* **Trigger characters**: `.` and `::`.

---

## 5. Editor Integration Configurations

### 5.1 Neovim Configuration (using `nvim-lspconfig`)
Add the following Lua snippet to your `init.lua` to register the Sutra language server:
```lua
local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')

if not configs.sutra_lsp then
  configs.sutra_lsp = {
    default_config = {
      cmd = { "sutra_lsp.exe" },
      filetypes = { 'sutra' },
      root_dir = lspconfig.util.root_pattern('package.सूत्र', 'README.md', '.git'),
      settings = {},
    },
  }
end

lspconfig.sutra_lsp.setup{}
```

### 5.2 Visual Studio Code Configuration (using LSP Client extension)
Define a custom LSP client configuration inside your extension's `extension.ts`:
```typescript
let serverOptions = {
    run: { command: 'sutra_lsp.exe' },
    debug: { command: 'sutra_lsp.exe' }
};

let clientOptions = {
    documentSelector: [{ scheme: 'file', language: 'sutra' }],
    synchronize: {
        fileEvents: workspace.createFileSystemWatcher('**/*.सूत्र')
    }
};

let client = new LanguageClient('sutraLSP', 'Sutra Language Server', serverOptions, clientOptions);
client.start();
```

---

## 6. Current Limitations
* Cross-file Go-To-Definition for variables imported via `आयात` requires standard path loading (currently resolved within local document scope).
* Incremental document synchronizations (`textDocumentSync = 2`) is not supported; all updates use full text synchronization.
