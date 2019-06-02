(provide 'global_kbinding)

;; windows layout management
(winner-mode)
(global-set-key [f7] 'winner-undo)
(global-set-key [C-f7] 'winner-redo)

;; magit seeting
(global-set-key (kbd "C-x g") 'magit-status)
;; dictionary
(global-set-key (kbd "C-c q") 'online-dict)

;; ;; ;;;ibuffer
;; ;; (require 'ibuffer)
;; ;; (global-set-key (kbd "C-x C-b") 'ibuffer)

;; backspace
(global-set-key (kbd "C-M-h") 'backward-kill-word)
;;bookmark

;;(global-set-key [(f1)] 'bookmark-jump)
;;(global-set-key [(f2)] ('save-buffer 'TeX-command-master ))
(global-set-key [(f2)] 'open-work)
(global-set-key [(f3)] 'open-personal)
(global-set-key [(f4)] 'open-notes)
(global-set-key [(f5)] 'open-log)

(global-set-key [f6] 'goto-line)
;; (global-set-key [(f7)] 'compile)
(global-set-key [(f8)] 'calendar)
;; (global-set-key [(f9)] 'list-bookmarks)
(global-set-key [(f12)] 'open-english)

(global-set-key (kbd "C-o") 'find-matching-paren)

;;(global-set-key (kbd "C-c t") 'line-to-top-of-window)
;; (global-set-key "\C-x\C-b" 'buffer-menu)
;; (global-set-key "\C-ci" 'imenu)

(global-set-key "\C-cn" 'next-error)
;; (global-set-key "\C-c;" 'comment-region)

(global-set-key "\C-x\C-m" 'compile)
;; (define-key c-mode-map "\M-n" 'next-error)

(global-set-key "\C-c\C-c"  'comment-region)

(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; (global-set-key "\M-." 'gtags-find-tag) ;; M-. finds tag
;; (global-set-key "\M-*" 'gtags-pop-stack) ;; M-. finds tag
;; (global-set-key "\C-cr" 'gtags-find-rtag)
;; (global-set-key "\C-cs" 'gtags-find-symbol) ;; C-M-, find all usages of symbol. ;; C-M-, find all usages of symbol.
;; (global-set-key "\C-cf" 'gtags-find-file)

;; experimental stuffs
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)

;; convenience for programming
(global-set-key (kbd "C-c p") 'magit-find-file-completing-read)
;; keybinding for edit convenience
(global-set-key (kbd "C-c w")         (quote copy-word))
(global-set-key (kbd "C-x b") `ido-switch-buffer)
