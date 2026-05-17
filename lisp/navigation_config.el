(provide 'navigation_config)

(use-package fzf
  :ensure t
  :bind (("C-c z" . fzf)
         ("C-c g" . fzf-git)
         ("C-c d" . fzf-directory)
         ("C-c p" . fzf-projectile)))

(use-package dumb-jump
  :ensure t
  :config
  (setq dumb-jump-prefer-searcher 'rg)
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))
