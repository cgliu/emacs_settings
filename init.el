;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/Dropbox/emacs")

(require 'emacs_config)
(require 'cpp_config)
(require 'python_config)
(require 'local_helm_config)
(require 'org_config)
(require 'global_kbinding)
(require 'experimental)
(require 'myfun)
;; (require 'personal_config)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (company-mode use-package undo-tree smex py-autopep8 powerline org-plus-contrib openwith material-theme magit-find-file helm-swoop helm-projectile helm-gtags helm-google helm-git-grep helm-ag elpy ein diff-hl better-defaults auto-complete-clang))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
