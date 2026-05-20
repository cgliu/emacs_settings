# Emacs Config Reorganisation — 2026-05-20

## Structure
- Added comprehensive `.gitignore` (excludes elpa/, eln-cache/, undo/, auto-save-list/, org-persist/, databases, session state)
- Removed vendored `lisp/org-plus-contrib-20210929/` from git (use elpa instead)
- Extracted inline org-roam config from init.el → `lisp/org_roam_config.el`
- Cleaned init.el to be a minimal module loader (49 lines)
- Stopped tracking `custom.el` and `lisp/private_config.el` (machine-specific)
- Repo reduced from 400+ tracked files to 21

---

# Emacs Config Fixes — 2026-05-16

## Security
- **Removed hardcoded GitLab token** from init.el → now reads from `~/.authinfo` via auth-source
- Changed MELPA archive URL from HTTP to HTTPS (init.el, lsp_config.el)

## Errors Fixed
- `default-major-mode` (removed in Emacs 26) → `(setq-default major-mode 'text-mode)` (emacs_config.el)
- `write-file-hooks` (deprecated) → `before-save-hook` (emacs_config.el)
- `x-select-enable-clipboard/primary` (deprecated) → `select-enable-clipboard/primary` (emacs_config.el)
- `gptel_config.el` rewritten — old `gptel-make-backend` API no longer exists, now uses `gptel-make-gemini`
- `(menu-bar-mode nil)` → `(menu-bar-mode -1)` (emacs_config.el)
- `(transient-mark-mode nil)` → `(transient-mark-mode -1)` (emacs_config.el)
- `(setq global-hl-line-mode nil)` → `(global-hl-line-mode -1)` (init.el)

## Conflicts Resolved
- Removed duplicate `lsp-clients-clangd-args` in init.el (kept the detailed one with background-index=false)
- Removed conflicting `(add-hook 'c-mode-hook 'lsp)` from lsp_config.el (init.el uses lsp-deferred)
- Removed smex `M-x` binding in experimental.el (helm-M-x is the intended binding)
- `C-p` → `C-c C-f` for f3 (was overriding `previous-line`) (global_kbinding.el)
- `<f12>` open-english → `C-c e` (was conflicting with my/send-to-buffer-and-run) (global_kbinding.el)
- `C-c p` magit-find-file → `C-c M-p` (was conflicting with fzf-projectile) (global_kbinding.el)
- Removed dead `C-c l` binding to count-lines-in-region (overridden later by my/copy-file-region) (init.el)
- Removed duplicate `org-confirm-babel-evaluate nil` at end of init.el (filter function in org_config.el preserved)

## Duplicates Removed
- `global-auto-revert-mode` (was in both emacs_config.el and init.el)
- `package-initialize` (was in lsp_config.el, gptel_config.el, gemini_config.el — only needed in init.el)
- `python-shell-interpreter` (was set twice in init.el, kept expand-file-name version)
- `ox-reveal` require (was in init.el and org_config.el, kept use-package form in org_config.el)
- `select-enable-primary/clipboard` (was in both emacs_config.el and init.el)
- `org-reveal-mathjax` (was set twice in org_config.el)
