# सूत्र (Sutra) — Architectural Decision Records & Changes

**Date**: 2026-09-01  
**Audit Baseline**: Commit `34e5557` + working tree audit

---

## Architectural Decision Records (ADRs)

### ADR-001: Adoption of Intermediate Representation (IR) in Self-Hosted Compiler
- **Status**: Implemented (2026-08-30)
- **Context**: The initial self-hosted compiler translated AST nodes directly into x86-64 stack machine assembly (`मूल_सर्जक.सूत्र`). This caused unbounded assembly size, prevented local optimizations, and prohibited register allocation.
- **Decision**: Introduce a 3-address quadruple IR system (`मध्यम.सूत्र`) with explicit basic blocks, virtual registers (`%v0`, `%v1`, ...), and a lowering pass (`मूल_निम्नक.सूत्र`).
- **Consequences**: Enables optimization passes (`अनुकूलक.सूत्र`), linear-scan register allocation (`रजि_नियतक.सूत्र`), and cleaner code generation (`मूल_उत्सर्जक.सूत्र`). Verified through fixed-point convergence (`Gen2.s == Gen3.s`).

---

### ADR-002: Modular Runtime in Sutra (Decoupling C Runtime)
- **Status**: In Progress (2026-09-01)
- **Context**: Sutra previously depended heavily on `sutra_runtime.c` (72 KB of C code) for string operations, list manipulation, dictionary lookups, memory allocation, and console I/O.
- **Decision**: Migrate runtime components progressively into pure Sutra assembly modules:
  1. `तल.s`: Bare-metal OS floor for Windows/Linux syscalls (`WriteFile`, memory mapping).
  2. `मूल_आवंटक.सूत्र` / `.s`: Self-hosted bump/free-list heap allocator in Sutra.
  3. `मूल_रनटाइम.सूत्र` / `.s`: Core string operations, list slicing, and open-addressing dictionary hash table in Sutra.
- **Consequences**: Minimizes C runtime footprint (`sutra_runtime.c` reduced to 54 KB), preparing Sutra for 100% C-independent native executables.

---

### ADR-003: Single Unified Language Server Architecture
- **Status**: Implemented (2026-08-25)
- **Context**: Tooling required IDE support for VS Code and other editors.
- **Decision**: Implement `sutra_lsp.exe` as a dedicated binary implementing LSP (Language Server Protocol 3.17) over JSON-RPC 2.0 using `nlohmann_json`, linking directly with `sutra_toolchain` library.
- **Consequences**: Standardized diagnostics, formatting, and auto-completion across all editors.
