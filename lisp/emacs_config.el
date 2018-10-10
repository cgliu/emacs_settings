(provide 'emacs_config)

;; Appearance settings
(use-package material-theme :ensure t)
(load-theme 'material t) ;; load material theme
;; (load-theme 'material-light t) ;; load material theme

;; (setq inhibit-startup-message t) ;; hide the startup message
;; (global-linum-mode t) ;; enable line numbers globally

(setq inhibit-startup-message t)
(setq frame-title-format "emacs@%b")
(global-font-lock-mode t)
(menu-bar-mode nil)
(transient-mark-mode nil)
(line-number-mode t)
(column-number-mode t)
(setq truncate-partial-width-windows t)
(fset 'yes-or-no-p 'y-or-n-p)

;; Show matching pairs of parentheses
(show-paren-mode t)
(setq show-paren-style 'parentheses)
(setq display-time-day-and-date t)
(display-time) ;;will make the display of date and time persistent.

;; --------------------------------------------------
(setq ac-ignore-case nil)
(windmove-default-keybindings)

;; Cursor settings
(setq-default cursor-type '(bar . 10))
(setq visible-bell t)
(set-cursor-color "steelblue")

;; Displays the current function name in the mode line
(which-function-mode 1)

(setq query-replace-highlight t) ;;will highlight during query.

(setq search-highlight t) ;;highlight incremental search
(global-hl-line-mode)

;; Configure the timestamp format
(add-hook 'write-file-hooks 'time-stamp)
(setq time-stamp-format "%:u %02m/%02d/%04y %02H:%02M:%02S (%s)")

;; --------------------------------------------------------------------------------
;; Spell checker
;; --------------------------------------------------------------------------------
(setq-default ispell-program-name "aspell")
(setq-default ispell-local-dictionary "american")
;; (global-set-key (kbd "") 'ispell-complete-word)
;; sentence-end  fill
(setq sentence-end "\\([]\\|\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)

;; (when (executable-find "hunspell")
;;  (setq-default ispell-program-name "hunspell")
;;  (setq ispell-really-hunspell t))

(dolist (mode '(emacs-lisp-mode-hook
                inferior-lisp-mode-hook
                clojure-mode-hook
                python-mode-hook
                js-mode-hook
                R-mode-hook))
  (add-hook mode
            '(lambda ()
               (flyspell-prog-mode))))

(defun flyspell-check-next-highlighted-word ()
  "Custom function to spell check next highlighted word"
  (interactive)
  (flyspell-goto-next-error)
  (ispell-word))
(global-set-key (kbd "M-<f8>") 'flyspell-check-next-highlighted-word)
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)

;; Show ansi-color in compilation buffer
(ignore-errors
  (require 'ansi-color)
  (defun my-colorize-compilation-buffer ()
    (when (eq major-mode 'compilation-mode)
      (ansi-color-apply-on-region compilation-filter-start (point-max))))
  (add-hook 'compilation-filter-hook 'my-colorize-compilation-buffer))


;; major mode  text-mode,  fundamental-mode.
(setq default-major-mode 'text-mode)

;; dired settings
(setq dired-recursive-copies 'top)
(setq dired-recursive-deletes 'top)

;; If you set the variable bookmark-save-flag to 1, each command that sets a bookmark will also save your bookmarks;
;; this way, you don't lose any bookmark values even if Emacs crashes.
(setq bookmark-save-flag 1)

;; When a file changes on disk outside of my text editor, I would like my editor to notice the change and start showing
;; the new version unless I have unsaved changes.
(auto-revert-mode t)

;; general hooks
(add-hook 'diary-mode-hook 'flyspell-mode)

;; fill paragraph setting
(setq-default fill-column 120)

;; --------------------------------------------------------------------------------
;; Configuration for backup
;; --------------------------------------------------------------------------------
(setq version-control t)
(setq kept-new-versions 3)
(setq delete-old-versions t)
(setq kept-old-versions 10)
(setq dired-kept-versions 1)
;; Maintain directories neat
(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.saves"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 10
 kept-old-versions 10
 version-control t)       ; use versioned backups

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; --------------------------------------------------------------------------------
;; gtags
;; --------------------------------------------------------------------------------
(setq gtags-auto-update t)

(defun gtags-root-dir ()
  "Returns GTAGS root directory or nil if doesn't exist."
  (with-temp-buffer
    (if (zerop (call-process "global" nil t nil "-pr"))
	(buffer-substring (point-min) (1- (point-max)))
      nil)))

(defun gtags-update ()
    "Make GTAGS incremental update"
    (call-process "global" nil nil nil "-u"))

(defun gtags-update-hook ()
  (when (gtags-root-dir)
    (gtags-update)))

(defun ask-before-closing ()
  "Ask whether or not to close, and then close if y was pressed"
  (interactive)
  (if (y-or-n-p (format "Are you sure you want to exit Emacs? "))
      (if (< emacs-major-version 22)
          (save-buffers-kill-terminal)
        (save-buffers-kill-emacs))
    (message "Canceled exit")))

;; --------------------------------------------------------------------------------
;; Default mode settings
;; --------------------------------------------------------------------------------
(add-to-list 'auto-mode-alist '("\\.launch$" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.hidl$" . c-mode))

;; Delete Selection mode lets you treat an Emacs region much like a typical text selection outside of Emacs: You can
;; replace the active region just by typing text, and you can delete the selected text just by hitting the Backspace key
;; ( 'DEL' ).
(delete-selection-mode 1)

;; (setq column-enforce-column 121)
;; (global-column-enforce-mode)

;; use company-mode in all buffers
(add-hook 'after-init-hook 'global-company-mode)
