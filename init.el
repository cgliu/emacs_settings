;;; init.el --- Emacs configuration entry point -*- lexical-binding: t -*-

;; Package archives
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Load path
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/Dropbox/emacs")

;; Load modules
(require 'emacs_config)
(require 'local_helm_config)
(require 'lsp_config)
(require 'cpp_config)
(require 'python_config)
(require 'org_config)
(require 'org_roam_config)
(require 'experimental)
(require 'myfun)
(require 'gemini_config)
(require 'navigation_config)
(require 'winpulse_config)
(require 'writing_config)
(require 'vterm_config)
(require 'gitlab_config)
(require 'private_config)
(require 'global_kbinding)

;; Custom file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

;; Diary
(setq diary-file "~/Dropbox/emacs/diary")

;; Global settings
(setq auto-revert-use-notify t)
(global-visual-line-mode 1)

;;; init.el ends here
