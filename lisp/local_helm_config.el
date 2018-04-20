(provide 'local_helm_config)

(use-package helm
  :ensure t
  :config
  ;; helm-ag at point
  (helm-mode 1)
  (setq helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match    t)
  ;; hem-man-woman
  (add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)
  (setq helm-locate-fuzzy-match t)
  ;; key bindings
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
  (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
  (global-set-key (kbd "C-f") 'helm-ag-project-root)
  (global-set-key (kbd "C-x i") `helm-complete-file-name-at-point)
  (global-set-key (kbd "C-x C-b") `helm-mini)
  (global-set-key (kbd "C-x C-f") `helm-find-files)
  (global-set-key (kbd "C-x C-r") `helm-recentf)
  (global-set-key (kbd "M-x") `helm-M-x)
  (global-set-key (kbd "M-y") `helm-show-kill-ring)
  (global-set-key (kbd "C-c i") 'helm-semantic-or-imenu)
  (global-set-key (kbd "C-x c o") 'helm-occur)
  (global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)
  (global-set-key (kbd "C-b") 'helm-bookmarks)
  )

;; (require 'helm-config)

(use-package helm-google
  :ensure t
  :config
  (global-set-key (kbd "C-c C-g") 'helm-google-suggest)
  )

;; ;; ;; === projectile ===
;; ;; (projectile-global-mode)
;; ;; (setq projectile-completion-system 'helm)
;; ;; (helm-projectile-on)
;; ;; (setq projectile-switch-project-action 'helm-projectile)
;; ;; ;; C-c p p switch projects
;; ;; ;; C-c p f find files in a project
;; ;; ;; C-c p F find files in projects

;; helm semantic
;; (semantic-mode 1)
;; (setq helm-semantic-fuzzy-match t
;;       helm-imenu-fuzzy-match    t)

(use-package helm-swoop
  :ensure t
  :config
  )
(use-package helm-projectile
    :ensure t)
(use-package helm-gtags
  :ensure t
  :config
  (global-set-key (kbd "C-j") 'helm-gtags-select)
  )
(use-package helm-git-grep
  :ensure t
  :config
  (global-set-key (kbd "C-t") 'helm-git-grep-at-point)
  )



(use-package helm-ag
  :ensure t
  :config
  (setq helm-ag-insert-at-point 'symbol)
  (global-set-key (kbd "C-c s") 'helm-ag)
  )
