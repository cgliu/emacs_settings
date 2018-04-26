(provide 'cpp_config)

;; --------------------------------------------------
(use-package helm-gtags :ensure t)

(require 'helm-gtags)
(setq
 helm-gtags-ignore-case t
 helm-gtags-auto-update t
 helm-gtags-use-input-at-cursor t
 helm-gtags-pulse-at-cursor t
 helm-gtags-prefix-key "\C-cg"
 helm-gtags-suggested-key-mapping nil
 )

;;; flycheck hook
(add-hook 'c-mode-hook 'flycheck-mode)
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'python-mode-hook 'flycheck-mode)

;;; Enable helm-gtags-mode
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)
(add-hook 'python-mode-hook 'helm-gtags-mode)


(define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
(define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
(define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
(define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
(define-key helm-gtags-mode-map (kbd "M-*") 'helm-gtags-resume)
(define-key helm-gtags-mode-map (kbd "C-c <left>") 'helm-gtags-previous-history)
(define-key helm-gtags-mode-map (kbd "C-c <right>") 'helm-gtags-next-history)


;;
;; (setq path-to-ctags "/usr/local/bin/ctags") ;; <- your ctags path here
;; (defun create-tags (dir-name)
;;   "Create tags file."
;;   (interactive "DDirectory: ")
;;   (shell-command
;;    (format "%s -f TAGS -e -R %s" path-to-ctags (directory-file-name dir-name)))
;;   )

;; ;; git grep
;; (require 'helm-git-grep) ;; Not necessary if installed by package.el
;; (global-set-key (kbd "C-c g") 'helm-git-grep)
;; ;; Invoke `helm-git-grep' from isearch.
;; (define-key isearch-mode-map (kbd "C-c g") 'helm-git-grep-from-isearch)
;; ;; Invoke `helm-git-grep' from other helm.
;; (eval-after-load 'helm
;;   '(define-key helm-map (kbd "C-c g") 'helm-git-grep-from-helm))


;; cscope settings
;; (require 'xcscope)

(add-to-list 'auto-mode-alist '("\\.hidl\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hh\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cc\\'" . c++-mode))

;; function-args
;; (require 'function-args)
;; (fa-config-default)
(set-default 'semantic-case-fold t)

;; If your includes aren't located in default dirs e.g. /usr/include/ etc, then you have to do something like this:
;; (semantic-add-system-include "~/Software/deal.II/include/" 'c++-mode)

;; (add-hook 'after-save-hook 'helm-gtags-update-tags)

;; (add-hook 'after-init-hook 'global-color-identifiers-mode)

;; (setq column-enforce-column 121)
;; (global-column-enforce-mode)

;; ;; ;; irony mode
;; (add-hook 'c++-mode-hook 'irony-mode)
;; (add-hook 'c-mode-hook 'irony-mode)
;; (add-hook 'objc-mode-hook 'irony-mode)
;; (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)


;; (add-hook 'c++-mode-hook 'irony-mode)
;; (add-hook 'c-mode-hook 'irony-mode)

;; (defun my-irony-mode-hook ()
;;   (define-key irony-mode-map
;;       [remap completion-at-point] 'counsel-irony)
;;   (define-key irony-mode-map
;;       [remap complete-symbol] 'counsel-irony))
;; (add-hook 'irony-mode-hook 'my-irony-mode-hook)
;; (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; ;; (eval-after-load 'company
;; ;;   '(add-to-list 'company-backends 'company-irony))

;; (setq irony--compile-options
;;       '("-std=c++0x"
;;         "-stdlib=libc++"
;;         "-I/System/Library/Frameworks/Python.framework/Headers"
;;         ))


(setq-default indent-tabs-mode nil)
(c-set-offset 'comment-intro 0)


;; ycmd it works very well, but sometimes not as powerful as gtags ;;
;; cd $HOME
;; git clone https://github.com/Valloric/ycmd
;; cd ycmd
;; ./build.py --clang-completer

;; (require 'ycmd)
;; (require 'company)
;; (require 'company-ycmd)
;; (require 'flycheck-ycmd)
;; ;; ycmd in all supported modes.
;; (add-hook 'after-init-hook #'global-ycmd-mode)
;; (set-variable 'ycmd-server-command `("python",  (file-truename  "~/ycmd/ycmd")))
;; ;; auto-load .ycmd_extra_conf.py files for whitelisted projects
;; (set-variable 'ycmd-extra-conf-whitelist '("~/av/*"))
;; (company-ycmd-setup)
;; (flycheck-ycmd-setup)
;; (setq flycheck-indication-mode nil)
;; (setq company-idle-delay 0.2)
;; (eval-after-load 'cc-mode '(define-key c-mode-base-map (kbd "M-.") (function ycmd-goto)))
;; ;; Company and flycheck can interfere in emacs -nw.
;; (when (not (display-graphic-p))
;;   (setq flycheck-indication-mode nil))
;; (global-ycmd-mode)
