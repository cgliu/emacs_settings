(provide 'myfun)

;; (defun recursive-count-words (region-end)
;;   "Number of words between point and REGION-END."
;; ;;; 1. do-again-test
;; (if (and (< (point) region-end)
;; 	 (re-search-forward "\\w+\\W*" region-end t))
;; ;;; 2. then-part: the recursive call
;;     (1+ (recursive-count-words region-end))
;; ;;; 3. else-part
;;   0))
;; ;;°ü×°º¯Êý£º
;; ;;; Recursive version
;; (defun count-words-region (beginning end)
;;   "Print number of words in the region.Words are defined as at least one word-constituentcharacter followed by at least one character that isnot a word-constituent.  The buffer's syntax tabledetermines which characters these are."
;;   (interactive "r")
;;   (message "Counting words in region ... ")
;;   (save-excursion    (goto-char beginning)
;; 		     (let ((count (recursive-count-words end)))
;; 		       (cond ((zerop count)
;; 			      (message
;; 			       "The region does NOT have any words."))
;; 			     ((= 1 count)
;; 			      (message "The region has 1 word."))
;; 			     (t
;; 			      (message "The region has %d words." count))))))


;;; Final version: while
(defun count-words-region (beginning end)
  "Print number of words in the region."
  (interactive "r")
  (message "Counting words in region ... ")
;;; 1. Set up appropriate conditions.
  (save-excursion
    (let ((count 0))
      (goto-char beginning)
;;; 2. Run the while loop.
      (while (and (< (point) end)
                  (re-search-forward "\\w+\\W*" end t))
        (setq count (1+ count)))
;;; 3. Send a message to the user.
      (cond ((zerop count)
             (message              "The region does NOT have any words."))
            ((= 1 count)
	     (message              "The region has 1 word."))
	    (t   (message              "The region has %d words." count))))))

;;comment-region replace by cr
(defun cr (beg end &optional arg)
    "same to comment-region   more help please see comment-region"
    (interactive "*r\nP")
    (message "comment region :beg:%d   end:%d" beg end)
    (comment-region beg end arg)    )
;;uncomment-region replace by ucr
(defun ucr (beg end)
  "same to comment-region  more help please see comment-region"
  (interactive "*r\n")
  (message "uncomment region :beg:%d   end:%d" beg end)
  (uncomment-region beg end)    )

(defun find-matching-paren ()
  "Locate the matching parenthtical"
  (interactive)
  (cond ((looking-at "[[({]") (forward-sexp 1) (backward-char 1))
	((looking-at "[])}]") (forward-char 1) (backward-sexp 1))
	(t (ding))          ))

(defun mark-beginning-of-buffer ()
  "mark to the beginning of buffer"
  (interactive)
  (push-mark (point) nil t)
  (goto-char (point-min))    )

(defun mark-end-of-buffer ()
  "mark to the end of buffer"
  (interactive)
  (push-mark (point) nil t)
  (goto-char (point-max))    )
;line-to-top-of-window
(defun line-to-top-of-window ()
  "line to the top of current window"
  (interactive)    (recenter 0)    )


;;
(defun w32-restore-frame ()
  "Restore a minimized frame"
  (interactive)
  (w32-send-sys-command 61728))

(defun w32-maximize-frame ()
  "Maximize the current frame"
  (interactive)
  (w32-send-sys-command 61488))

;; for CL
(set-variable 'inferior-lisp-program "F:/cl-lisp/bin/gcl.exe")
(autoload 'fi:common-lisp "fi-site-init" "" t)

;;
(defun copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

(defun flyspell-goto-previous-error (arg)
  "Go to arg previous spelling error."
  (interactive "p")
  (while (not (= 0 arg))
    (let ((pos (point))
          (min (point-min)))
      (if (and (eq (current-buffer) flyspell-old-buffer-error)
               (eq pos flyspell-old-pos-error))
          (progn
            (if (= flyspell-old-pos-error min)
                ;; goto beginning of buffer
                (progn
                  (message "Restarting from end of buffer")
                  (goto-char (point-max)))
              (backward-word 1))
            (setq pos (point))))
      ;; seek the next error
      (while (and (> pos min)
                  (let ((ovs (overlays-at pos))
                        (r '()))
                    (while (and (not r) (consp ovs))
                      (if (flyspell-overlay-p (car ovs))
                          (setq r t)
                        (setq ovs (cdr ovs))))
                    (not r)))
        (backward-word 1)
        (setq pos (point)))
      ;; save the current location for next invocation
      (setq arg (1- arg))
      (setq flyspell-old-pos-error pos)
      (setq flyspell-old-buffer-error (current-buffer))
      (goto-char pos)
      (if (= pos min)
          (progn
            (message "No more miss-spelled word!")
            (setq arg 0))))))


(defun check-previous-spelling-error ()
  "Jump to previous spelling error and correct it"
  (interactive)
  (push-mark-no-activate)
  (flyspell-goto-previous-error 1)
  (call-interactively 'helm-flyspell-correct))

(defun check-next-spelling-error ()
  "Jump to next spelling error and correct it"
  (interactive)
  (push-mark-no-activate)
  (flyspell-goto-next-error)
  (call-interactively 'helm-flyspell-correct))

(defun push-mark-no-activate ()
  "Pushes `point' to `mark-ring' and does not activate the region
 Equivalent to \\[set-mark-command] when \\[transient-mark-mode] is disabled"
  (interactive)
  (push-mark (point) t nil)
  (message "Pushed mark to ring"))

;; convenience for edit
;; refer to https://www.emacswiki.org/emacs/CopyWithoutSelection
(defun get-point (symbol &optional arg)
  "get the point"
  (funcall symbol arg)
  (point)
  )

(defun copy-thing (begin-of-thing end-of-thing &optional arg)
  "copy thing between beg & end into kill ring"
  (save-excursion
    (let ((beg (get-point begin-of-thing 1))
          (end (get-point end-of-thing arg)))
      (copy-region-as-kill beg end)))
  )

(defun paste-to-mark(&optional arg)
  "Paste things to mark, or to the prompt in shell-mode"
  (let ((pasteMe
     	 (lambda()
     	   (if (string= "shell-mode" major-mode)
               (progn (comint-next-prompt 25535) (yank))
             (progn (goto-char (mark)) (yank) )))))
    (if arg
        (if (= arg 1)
            nil
          (funcall pasteMe))
      (funcall pasteMe))
    ))


(defun copy-word (&optional arg)
  "Copy words at point into kill-ring"
  (interactive "P")
  (copy-thing 'backward-word 'forward-word arg)
  ;;(paste-to-mark arg)
  )

(defun copy-line (&optional arg)
  "Save current line into Kill-Ring without mark the line "
  (interactive "P")
  (copy-thing 'beginning-of-line 'end-of-line arg)
  (paste-to-mark arg)
  )

(defun copy-paragraph (&optional arg)
  "Copy paragraphes at point"
  (interactive "P")
  (copy-thing 'backward-paragraph 'forward-paragraph arg)
  (paste-to-mark arg)
  )

(defun beginning-of-string(&optional arg)
  "  "
  (re-search-backward "[ \t]" (line-beginning-position) 3 1)
  (if (looking-at "[\t ]")  (goto-char (+ (point) 1)) )
  )
(defun end-of-string(&optional arg)
  " "
  (re-search-forward "[ \t]" (line-end-position) 3 arg)
  (if (looking-back "[\t ]") (goto-char (- (point) 1)) )
  )

(defun thing-copy-string-to-mark(&optional arg)
  " Try to copy a string and paste it to the mark
     When used in shell-mode, it will paste string on shell prompt by default "
  (interactive "P")
  (copy-thing 'beginning-of-string 'end-of-string arg)
  (paste-to-mark arg)
  )
