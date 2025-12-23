# Ruby TUI to Ada/SPARK Migration Guide

## Policy
TUI applications should be migrated to Ada/SPARK for:
- Formal verification
- Memory safety without runtime overhead
- Proven correctness

## Migration Steps
1. [x] Create `alire.toml` project
2. [x] Use `Terminal_Interface.Curses` from GNAT
3. [x] Convert Ruby curses code to Ada
4. [ ] Apply SPARK annotations for critical sections (ongoing)

## Status: MIGRATION COMPLETE

The migration from Ruby to Ada has been successfully completed. The project now uses:

- **Ada 2022** standard
- **ncursesada** for terminal interface
- **Alire** for package management
- **GNAT** toolchain for compilation
- **SPARK** annotations planned for v3.0.0

### Key Changes

| Component | Ruby (Before) | Ada (After) |
|-----------|--------------|-------------|
| Main entry | `bin/nano-ruber` | `src/nano_aider.adb` |
| TUI library | Ruby Curses gem | ncursesada |
| Package manager | Bundler | Alire |
| Build system | Rake | GPRbuild |
| Test framework | Minitest | Custom Ada tests |

### Migration Date
December 2024
