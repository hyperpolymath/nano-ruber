# LOCK_SCOPE.md - Immutable Constraints

<!-- SPDX-License-Identifier: MIT OR AGPL-3.0-or-later -->
<!-- SPDX-FileCopyrightText: 2025 hyperpolymath -->

> **Lock Scope**: Defines what nano-aider will **NEVER** do. These constraints
> are immutable and supersede all other project decisions.

## Core Guarantees

### 1. User Safety

nano-aider will **NEVER**:

| Constraint | Rationale |
|------------|-----------|
| Execute arbitrary shell commands from config files | Config is data, not code |
| Modify editor binaries or system files | Read-only discovery tool |
| Transmit configuration data over network | Offline-first, no telemetry |
| Store credentials or secrets | No authentication required |
| Require root/admin privileges | User-space operation only |
| Access files outside `~/.config`, `~/.nano*`, `~/.local` | Scoped filesystem access |

### 2. Language Lock

nano-aider will **NEVER** contain:

| Banned | Reason | Enforced By |
|--------|--------|-------------|
| TypeScript | Use ReScript | `rsr-antipattern.yml` |
| Node.js/npm/bun | Use Deno | `npm-bun-blocker.yml` |
| Go | Use Rust | `rsr-antipattern.yml` |
| Python (non-SaltStack) | Use Ada/Rust | CI checks |
| Kotlin/Swift | Use Tauri/Dioxus | Policy |

**Allowed**: Ada, Bash/POSIX, Rust (future extensions)

### 3. Architectural Invariants

nano-aider will **NEVER**:

| Constraint | Rationale |
|------------|-----------|
| Require heap allocation for core operations | Stack-safe, deterministic |
| Depend on external services or APIs | Fully offline capable |
| Break SPARK verification contracts | Safety-critical paths remain proven |
| Remove ncurses-only TUI mode | Terminal-first interface |
| Add mandatory GUI dependencies | TUI remains standalone |

### 4. Security Boundaries

nano-aider will **NEVER**:

| Constraint | Enforcement |
|------------|-------------|
| Use MD5/SHA1 for integrity | SHA256+ required |
| Accept HTTP URLs | HTTPS only |
| Embed hardcoded secrets | CI secret scanner |
| Load unsigned plugins | Future plugin system |
| Disable ASLR/stack protection | Compiler flags locked |

### 5. Compatibility Lock

nano-aider will **NEVER**:

| Constraint | Scope |
|------------|-------|
| Drop support for nano 5.x+ | Minimum supported version |
| Remove micro editor support | Secondary editor |
| Break existing `.nanorc` compatibility | Import always works |
| Change XDG directory conventions | `~/.config/nano-aider/` |
| Alter profile file format without migration | Versioned profiles |

## Enforcement

These constraints are enforced by:

1. **CI Workflows** - Automated rejection of violating commits
2. **SPARK Proofs** - Formal verification of safety properties
3. **CarecTL Profiles** - Audit-grade compliance checks
4. **Code Review** - Human verification of architectural changes

## Exceptions

There are **no exceptions** to this lock scope. Any change requiring an
exception must:

1. Update this document with explicit rationale
2. Obtain maintainer approval via RFC process
3. Increment major version (breaking change)
4. Notify all downstream consumers

---

*Lock Scope Version: 1.0.0*
*Last Updated: 2025-12-27*
