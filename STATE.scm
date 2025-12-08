;;; STATE.scm — nano-ruber project checkpoint
;;; Format: Guile Scheme S-expressions
;;; Purpose: Persist project state, route to MVP, blockers, questions, and roadmap

(define state
  '((metadata
     (format-version . "2.0")
     (schema-date . "2025-01-01")
     (created . "2025-12-08T00:00:00Z")
     (last-modified . "2025-12-08T00:00:00Z")
     (generator . "claude-opus-4"))

    (project-context
     (name . "nano-ruber")
     (description . "A narratable, audit-grade Ruby TUI editor for /etc/nanorc and ~/.nanorc")
     (repository . "https://github.com/hyperpolymath/nano-ruber")
     (license . "AGPL-3.0 OR Palimpsest")
     (ruby-versions . (3.1 3.2 3.3)))

    ;; ═══════════════════════════════════════════════════════════════════════════
    ;; CURRENT POSITION
    ;; ═══════════════════════════════════════════════════════════════════════════
    (current-position
     (phase . "initial-scaffold")
     (completion-percent . 10)
     (status . "in-progress")

     (what-exists
      ((component . "project-infrastructure")
       (status . "complete")
       (items . ("dual-licensing" "ci-cd-github-actions" "codeql-security"
                 "carectl-linting" "contributor-governance" "editorconfig")))

      ((component . "tui-skeleton")
       (status . "minimal")
       (items . ("curses-init" "basic-screen-setup" "single-keypress-handler")))

      ((component . "testing")
       (status . "minimal")
       (items . ("smoke-test-only"))))

     (what-works
      "The app initializes Curses, displays 'nano-ruber TUI loaded', waits for
       a keypress, then exits cleanly. CI passes across Ruby 3.1/3.2/3.3.")

     (what-is-missing
      ("tab-system-for-file-switching"
       "actual-text-editing-ui"
       "nanorc-file-parsing"
       "nanorc-file-writing"
       "save-reload-quit-guards"
       "backup-on-save"
       "jsonl-audit-trail"
       "diff-preview-with-diff-lcs"
       "unit-tests"
       "integration-tests"
       "gemfile-dependency-management")))

    ;; ═══════════════════════════════════════════════════════════════════════════
    ;; ROUTE TO MVP v1
    ;; ═══════════════════════════════════════════════════════════════════════════
    (mvp-v1-route
     (target-features
      ("Read and display /etc/nanorc and ~/.nanorc"
       "Tab switching between system and user configs"
       "Basic text editing with cursor navigation"
       "Save with automatic backup"
       "Quit guard preventing unsaved changes loss"
       "JSONL audit log of all operations"))

     (implementation-phases
      ((phase . 1)
       (name . "file-io-foundation")
       (completion . 0)
       (tasks
        ("Create NanoRuber::Config module for nanorc parsing"
         "Implement file reader with error handling"
         "Add backup file creation on save"
         "Write unit tests for file operations")))

      ((phase . 2)
       (name . "tui-core")
       (completion . 5)
       (tasks
        ("Implement scrollable text buffer"
         "Add cursor movement (hjkl or arrows)"
         "Create status bar with file info"
         "Implement tab bar for file switching"
         "Handle window resize events")))

      ((phase . 3)
       (name . "editing-operations")
       (completion . 0)
       (tasks
        ("Text insertion at cursor"
         "Line deletion and manipulation"
         "Undo/redo stack"
         "Search within file")))

      ((phase . 4)
       (name . "guards-and-audit")
       (completion . 0)
       (tasks
        ("Dirty-file detection"
         "Quit confirmation dialog"
         "Reload confirmation if file changed"
         "JSONL audit event emission")))

      ((phase . 5)
       (name . "polish-and-release")
       (completion . 0)
       (tasks
        ("diff-lcs integration for change preview"
         "Help screen / keybinding reference"
         "Gemfile with pinned dependencies"
         "Comprehensive test suite"
         "Release v1.0.0"))))

     (estimated-effort . "medium-complexity-ruby-tui"))

    ;; ═══════════════════════════════════════════════════════════════════════════
    ;; ISSUES / BLOCKERS
    ;; ═══════════════════════════════════════════════════════════════════════════
    (issues
     ((id . "ISSUE-001")
      (severity . "medium")
      (category . "architecture")
      (title . "No Gemfile for dependency management")
      (description . "Project relies on stdlib Curses but mentions diff-lcs as
                      optional dependency. No Gemfile exists to manage versions.")
      (impact . "Makes reproducible builds harder; diff-lcs integration unclear")
      (proposed-resolution . "Create Gemfile with curses and diff-lcs gems"))

     ((id . "ISSUE-002")
      (severity . "low")
      (category . "documentation")
      (title . "Architecture doc is single-line stub")
      (description . "docs/architecture.md exists but contains minimal content")
      (impact . "New contributors lack architectural guidance")
      (proposed-resolution . "Expand with component diagrams and data flow"))

     ((id . "ISSUE-003")
      (severity . "medium")
      (category . "testing")
      (title . "Only smoke test exists")
      (description . "No unit or integration tests beyond basic load check")
      (impact . "Regressions will go undetected as features are added")
      (proposed-resolution . "Add minitest or rspec suite alongside development"))

     ((id . "ISSUE-004")
      (severity . "info")
      (category . "migration")
      (title . "Legacy GitLab CI file present")
      (description . ".gitlab-ci.yml remains from migration, may cause confusion")
      (impact . "Minimal; file is dormant on GitHub")
      (proposed-resolution . "Remove or archive .gitlab-ci.yml")))

    ;; ═══════════════════════════════════════════════════════════════════════════
    ;; QUESTIONS FOR MAINTAINER
    ;; ═══════════════════════════════════════════════════════════════════════════
    (questions
     ((id . "Q-001")
      (category . "design")
      (question . "Should the TUI support mouse input or keyboard-only?")
      (context . "Curses supports mouse events but adds complexity")
      (options . ("keyboard-only" "optional-mouse" "full-mouse-support")))

     ((id . "Q-002")
      (category . "architecture")
      (question . "Preferred testing framework: minitest or rspec?")
      (context . "Smoke test uses plain Ruby; need decision for test suite")
      (options . ("minitest" "rspec")))

     ((id . "Q-003")
      (category . "features")
      (question . "Should syntax highlighting be an MVP feature or post-v1?")
      (context . "nanorc files have specific syntax; highlighting aids editing")
      (options . ("mvp-v1" "post-v1" "never")))

     ((id . "Q-004")
      (category . "deployment")
      (question . "Target distribution method: gem, standalone binary, or both?")
      (context . "Affects packaging and dependency handling")
      (options . ("rubygems" "standalone" "both")))

     ((id . "Q-005")
      (category . "scope")
      (question . "Support for include directives in nanorc?")
      (context . "nanorc can include other files; adds parsing complexity")
      (options . ("ignore-includes" "display-only" "full-include-support")))

     ((id . "Q-006")
      (category . "ux")
      (question . "Preferred keybinding style: nano-like, vim-like, or emacs-like?")
      (context . "Ironic to make a nano config editor with vim bindings, but user choice matters")
      (options . ("nano-style" "vim-style" "emacs-style" "configurable"))))

    ;; ═══════════════════════════════════════════════════════════════════════════
    ;; LONG-TERM ROADMAP
    ;; ═══════════════════════════════════════════════════════════════════════════
    (long-term-roadmap
     ((milestone . "v1.0.0")
      (codename . "Foundation")
      (status . "in-progress")
      (goals
       ("Core TUI with tab switching"
        "Read/write nanorc files with backup"
        "JSONL audit trail"
        "Basic editing operations"
        "Quit/reload guards")))

     ((milestone . "v1.1.0")
      (codename . "Polish")
      (status . "planned")
      (goals
       ("Syntax highlighting for nanorc"
        "diff-lcs change preview"
        "Improved error messages"
        "Help screen and documentation")))

     ((milestone . "v1.2.0")
      (codename . "Power User")
      (status . "planned")
      (goals
       ("Include directive support"
        "Search and replace"
        "Macro recording/playback"
        "Custom keybinding configuration")))

     ((milestone . "v2.0.0")
      (codename . "Ecosystem")
      (status . "future")
      (goals
       ("Plugin architecture"
        "Remote file editing (SSH)"
        "Integration with package managers"
        "Syntax file auto-download")))

     ((milestone . "v3.0.0")
      (codename . "Enterprise")
      (status . "future")
      (goals
       ("Multi-user collaboration features"
        "Audit log aggregation"
        "Configuration drift detection"
        "Compliance reporting"))))

    ;; ═══════════════════════════════════════════════════════════════════════════
    ;; CRITICAL NEXT ACTIONS
    ;; ═══════════════════════════════════════════════════════════════════════════
    (critical-next
     ((priority . 1)
      (action . "Create Gemfile with curses and diff-lcs dependencies")
      (rationale . "Foundation for reproducible development environment"))

     ((priority . 2)
      (action . "Implement NanoRuber::Buffer class for text storage")
      (rationale . "Core data structure needed before any editing features"))

     ((priority . 3)
      (action . "Add file reading capability for nanorc files")
      (rationale . "Cannot edit what we cannot load"))

     ((priority . 4)
      (action . "Implement scrollable viewport in TUI")
      (rationale . "nanorc files can be long; scrolling is essential"))

     ((priority . 5)
      (action . "Set up minitest/rspec and write first real tests")
      (rationale . "Test infrastructure before feature explosion")))

    ;; ═══════════════════════════════════════════════════════════════════════════
    ;; SESSION ARTIFACTS
    ;; ═══════════════════════════════════════════════════════════════════════════
    (session-artifacts
     (files-created . ("STATE.scm"))
     (files-modified . ())
     (decisions-made . ()))

    ;; ═══════════════════════════════════════════════════════════════════════════
    ;; HISTORY (for velocity tracking)
    ;; ═══════════════════════════════════════════════════════════════════════════
    (history
     ((snapshot-date . "2025-12-08")
      (overall-completion . 10)
      (phase-completions
       (("infrastructure" . 95)
        ("tui-core" . 5)
        ("file-io" . 0)
        ("editing" . 0)
        ("guards-audit" . 0)
        ("testing" . 5)))
      (notes . "Initial STATE.scm creation. Project at scaffold stage.")))))

;;; ═══════════════════════════════════════════════════════════════════════════════
;;; USAGE NOTES
;;; ═══════════════════════════════════════════════════════════════════════════════
;;;
;;; This file captures the complete state of nano-ruber development.
;;;
;;; To resume work:
;;;   1. Read this file at session start
;;;   2. Check critical-next for immediate priorities
;;;   3. Review questions if design decisions are needed
;;;   4. Update completion percentages as work progresses
;;;   5. Add new issues as discovered
;;;   6. Update last-modified timestamp
;;;
;;; End of session:
;;;   1. Update all completion percentages
;;;   2. Add any new blockers to issues
;;;   3. Update history with new snapshot
;;;   4. Commit STATE.scm with meaningful message
;;;
;;; ═══════════════════════════════════════════════════════════════════════════════
