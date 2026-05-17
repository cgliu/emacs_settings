(provide 'cpp_config)

;; Flycheck for C/C++
(add-hook 'c-mode-hook 'flycheck-mode)
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'python-mode-hook 'flycheck-mode)

;; File associations
(add-to-list 'auto-mode-alist '("\\.hh\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cc\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.ipp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.c.template\\'" . c-mode))

;; Indentation
(setq-default indent-tabs-mode nil)
(c-set-offset 'comment-intro 0)
(setq c-default-style '((c++-mode . "stroustrup")
                        (other . "gnu")))
(setq c-basic-offset 4)

(set-default 'semantic-case-fold t)

;; Bazel
(load "~/.emacs.d/elpa/bazel.el")

;; Force compilation buffer to bottom
(add-to-list 'display-buffer-alist
             '("\\*compilation\\*"
               (display-buffer-at-bottom)
               (window-height . 15)))
