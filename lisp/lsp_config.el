(provide 'lsp_config)

(use-package lsp-mode
  :ensure t
  :hook ((c-mode . lsp-deferred)
         (c++-mode . lsp-deferred))
  :commands (lsp lsp-deferred)
  :config
  (setq lsp-idle-delay 0.1)
  (setq lsp-enable-symbol-highlighting nil)
  (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-modeline-code-actions-enable nil)
  (setq lsp-lens-enable nil)
  (setq lsp-clients-clangd-args
        '("--background-index=false"
          "--clang-tidy=false"
          "--completion-style=detailed"
          "--header-insertion=never"
          "-j=2"))
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

(use-package lsp-pyright :ensure t)

(use-package lsp-treemacs :ensure t)
(use-package helm-lsp :ensure t)
(use-package helm-xref :ensure t)
(use-package which-key :ensure t :config (which-key-mode))
(use-package yasnippet :ensure t)
(use-package projectile :ensure t)
(use-package hydra :ensure t)
(use-package flycheck :ensure t)
(use-package company :ensure t)
(use-package avy :ensure t)
(use-package dap-mode :ensure t)

;; Helm integration
(helm-mode)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)

;; Performance
(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1)
