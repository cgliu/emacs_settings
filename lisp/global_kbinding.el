(provide 'global_kbinding)

;; Window layout management
(winner-mode)
(global-set-key [f7] 'winner-undo)
(global-set-key [C-f7] 'winner-redo)

;; Magit
(global-set-key (kbd "C-x g") 'magit-status)

;; Send region
(global-set-key (kbd "C-c q") 'my/send-region-to-buffer)

;; Backspace
(global-set-key (kbd "C-M-h") 'backward-kill-word)

;; Quick file access
(global-set-key [(f2)] 'open-work)
(global-set-key [(f3)] 'open-personal)
(global-set-key [(f4)] 'open-notes)
(global-set-key [(f5)] 'open-log)
(global-set-key [f6] 'goto-line)
(global-set-key [(f8)] 'calendar)
(global-set-key (kbd "C-c e") 'open-english)

;; Paren matching
(global-set-key (kbd "C-o") 'find-matching-paren)

;; Compilation / errors
(global-set-key "\C-cn" 'next-error)
(global-set-key "\C-x\C-m" 'compile)

;; Comment region
(global-set-key "\C-c\C-c" 'comment-region)

;; Recent files
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; Jump to definition with fallback
(defun my/jump-to-definition ()
  "Try xref-find-definitions, fall back to dumb-jump-go on failure."
  (interactive)
  (condition-case nil
      (xref-find-definitions (thing-at-point 'symbol t))
    (error (dumb-jump-go))))

(global-set-key (kbd "\C-c <down>") 'my/jump-to-definition)
(global-set-key (kbd "\C-c <up>") 'xref-go-back)
(global-set-key "\C-cf" 'helm-lsp-global-workspace-symbol)
(global-set-key "\C-cr" 'xref-find-references)

;; Window navigation
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x o") (lambda () (interactive) (other-window -1)))

;; Magit find file
(global-set-key (kbd "C-c M-p") 'magit-find-file-completing-read)

;; Copy/edit convenience
(global-set-key (kbd "C-c w") 'copy-word)
(global-set-key (kbd "C-x b") 'ido-switch-buffer)
(global-set-key (kbd "C-c C-h") 'copy-buffer-to-clipboard)
(global-set-key (kbd "C-c l") #'my/copy-file-region)

;; Search
(global-set-key "\C-cs" 'helm-ag)
(global-set-key "\M-l" 'git-share)
(global-set-key "\M-*" 'helm-lsp-global-workspace-symbol)
(global-set-key (kbd "C-c C-f") 'f3)

;; Send to buffer and run
(global-set-key (kbd "<f12>") 'my/send-to-buffer-and-run)

;; Spelling
(global-set-key (kbd "M-<f8>") 'flyspell-check-next-highlighted-word)

;; Disable accidental quit
(global-unset-key (kbd "C-x C-c"))

;; Right-click context menu
(context-menu-mode 1)

;; Narrow
(put 'narrow-to-region 'disabled nil)
(put 'list-timers 'disabled nil)
