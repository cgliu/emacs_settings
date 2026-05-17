(provide 'experimental)

(use-package diff-hl
  :ensure t
  )

(use-package magit
  :ensure t
  :config
  (use-package magit-find-file
    :ensure t))

;; Forge: GitLab code review integration
(use-package forge
  :ensure t
  :after magit)

(use-package openwith
  :ensure t
  :config
  (setq openwith-associations
        (if (eq system-type 'darwin)
            '(("\\.pdf\\'" "open" (file))
              ("\\.\\(?:mpe?g\\|avi\\|mp4\\|wmv\\|ogv\\|3gp\\|mov\\|wmv\\|webm\\)\\'" "open" (file)))
          '(("\\.pdf\\'" "evince" (file))
            ("\\.\\(?:mpe?g\\|avi\\|mp4\\|wmv\\|ogv\\|3gp\\|mov\\|wmv\\|webm\\)\\'" "vlc" (file)))))
  (openwith-mode t))

(use-package smex
  :ensure t
  :config (smex-initialize))

(use-package undo-tree
  :ensure t
  :config
  ;;turn on everywhere
  (global-undo-tree-mode 1)
  ;; make ctrl-z undo
  (global-set-key (kbd "C-z") 'undo)
  ;; make ctrl-Z redo
  (defalias 'redo 'undo-tree-redo)
  ;; the SHIFT key may not work in terminal
  (global-set-key (kbd "C-S-z") 'redo)
  ;; try 'C-x u', which is bound to undo-tree-visualize by default, cool!
  )

;; powerline
(use-package powerline
  :ensure t
  :config
  (setq powerline-arrow-shape 'arrow)   ;; the default
  (powerline-default-theme)
  )
