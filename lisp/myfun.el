(provide 'myfun)

(defun count-words-region (beginning end)
  "Print number of words in the region."
  (interactive "r")
  (save-excursion
    (let ((count 0))
      (goto-char beginning)
      (while (and (< (point) end)
                  (re-search-forward "\\w+\\W*" end t))
        (setq count (1+ count)))
      (cond ((zerop count) (message "The region does NOT have any words."))
            ((= 1 count) (message "The region has 1 word."))
            (t (message "The region has %d words." count))))))

(defun count-lines-in-region ()
  "Count lines in the current region."
  (interactive)
  (if (use-region-p)
      (message "Region has %d lines"
               (count-lines (region-beginning) (region-end)))
    (message "No region selected")))

(defun find-matching-paren ()
  "Locate the matching parenthetical."
  (interactive)
  (cond ((looking-at "[[({]") (forward-sexp 1) (backward-char 1))
        ((looking-at "[])}]") (forward-char 1) (backward-sexp 1))
        (t (ding))))

(defun copy-buffer-to-clipboard ()
  "Copy entire buffer to clipboard."
  (interactive)
  (clipboard-kill-ring-save (point-min) (point-max)))

(defun copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

(defun copy-org-file-link ()
  "Copy org-mode style file link with line number."
  (interactive)
  (let ((file-path (buffer-file-name))
        (line-number (line-number-at-pos)))
    (if file-path
        (let ((link (format "[[file:%s::%d]]" file-path line-number)))
          (kill-new link)
          (message "Copied org link: %s" link))
      (message "Buffer is not visiting a file"))))

(defun my/copy-file-region ()
  "Copy file:line range reference to kill ring."
  (interactive)
  (let ((text (format "%s:L%d-%d"
                      (buffer-file-name)
                      (line-number-at-pos (region-beginning))
                      (line-number-at-pos (region-end)))))
    (kill-new text)
    (deactivate-mark)
    (message "Copied: %s" text)))

(defun get-point (symbol &optional arg)
  (funcall symbol arg)
  (point))

(defun copy-thing (begin-of-thing end-of-thing &optional arg)
  "Copy thing between beg & end into kill ring."
  (save-excursion
    (let ((beg (get-point begin-of-thing 1))
          (end (get-point end-of-thing arg)))
      (copy-region-as-kill beg end))))

(defun copy-word (&optional arg)
  "Copy words at point into kill-ring."
  (interactive "P")
  (copy-thing 'backward-word 'forward-word arg))

(defun copy-line (&optional arg)
  "Save current line into Kill-Ring without mark the line."
  (interactive "P")
  (copy-thing 'beginning-of-line 'end-of-line arg))

(defvar my/--vterm-send-marker nil)
(defvar my/--vterm-send-buffer nil)

(defun my/send-region-to-buffer (start end)
  "Send the selected region to a user-specified buffer."
  (interactive "r")
  (let* ((buf-name (read-buffer "Send region to buffer: " nil nil))
         (file-ref (format "%s:L%d-%d"
                           (buffer-file-name)
                           (line-number-at-pos start)
                           (line-number-at-pos end)))
         (text (concat "explain " (buffer-substring-no-properties start end) " in " file-ref))
         (target (get-buffer-create buf-name)))
    (with-current-buffer target
      (if (derived-mode-p 'vterm-mode)
          (vterm-send-string text)
        (when current-prefix-arg (erase-buffer))
        (goto-char (point-max))
        (insert text "\n")))
    (pop-to-buffer target)
    (message "Region sent to buffer '%s'" buf-name)))

(defun my/send-to-buffer-and-run (start end)
  "Send region to buffer and execute, stay in current buffer."
  (interactive "r")
  (let* ((buf-name (read-buffer "Send region to buffer: " nil nil))
         (text (buffer-substring-no-properties start end))
         (target (get-buffer-create buf-name)))
    (with-current-buffer target
      (setq my/--vterm-send-marker (point-max))
      (setq my/--vterm-send-buffer buf-name)
      (if (derived-mode-p 'vterm-mode)
          (progn (vterm-send-string text) (vterm-send-return))
        (when current-prefix-arg (erase-buffer))
        (goto-char (point-max))
        (insert text "\n")))
    (message "Region sent and executed in buffer '%s'" buf-name)))

(defun my/grab-vterm-output ()
  "Insert the most recent output from the last send target."
  (interactive)
  (unless my/--vterm-send-buffer
    (error "No previous send-to-buffer-and-run target"))
  (let* ((target (get-buffer my/--vterm-send-buffer))
         (text (with-current-buffer target
                 (buffer-substring-no-properties my/--vterm-send-marker (point-max)))))
    (insert (string-trim text))))

(defun flyspell-check-next-highlighted-word ()
  "Spell check next highlighted word."
  (interactive)
  (flyspell-goto-next-error)
  (ispell-word))

(defun ask-before-closing ()
  "Ask whether or not to close, and then close if y was pressed."
  (interactive)
  (if (y-or-n-p "Are you sure you want to exit Emacs? ")
      (save-buffers-kill-emacs)
    (message "Canceled exit")))
