(provide 'gitlab_config)

(use-package lab
  :ensure t)

(add-to-list 'load-path "~/.emacs.d/elpa/git-share/")
(require 'git-share)

(defun my/lab-review-reviewer-mrs ()
  "List open MRs where I'm a reviewer and open diff in Emacs."
  (interactive)
  (cd "~/av-stack/")
  (lab--request
   "merge_requests"
   :reviewer_username "frank.liu"
   :state "opened"
   :scope "all"
   :%success
   (lambda (mrs)
     (let* ((candidates
             (mapcar (lambda (mr)
                       (cons (format "%s | %s"
                                     (alist-get 'title mr)
                                     (alist-get 'web_url mr))
                             mr))
                     mrs))
            (choice (completing-read "Review MR: " candidates nil t))
            (mr (cdr (assoc choice candidates))))
       (lab-open-merge-request-diff (alist-get 'web_url mr))))))

(defun my/lab-checkout-mr-branch ()
  "Checkout the MR branch or specific revision of the current lab diff buffer."
  (interactive)
  (cd "~/av-stack/")
  (unless (bound-and-true-p lab--merge-request)
    (user-error "Not in a lab merge request diff buffer"))
  (let* ((mr lab--merge-request)
         (branch (alist-get 'source_branch mr))
         (sha (when (bound-and-true-p lab--merge-request-versions)
                (alist-get 'head_commit_sha (car lab--merge-request-versions))))
         (choice (read-char-choice
                  (format "Checkout [b]ranch (%s) or [r]evision (%s)? "
                          branch (if sha (substring sha 0 8) "N/A"))
                  '(?b ?r)))
         (default-directory (expand-file-name "~/av-stack/"))
         (ref (pcase choice
                (?b branch)
                (?r (or sha (user-error "No revision SHA available for this MR"))))))
    (with-temp-buffer
      (unless (zerop (call-process "git" nil t nil "fetch" "origin" branch))
        (user-error "git fetch failed: %s" (buffer-string)))
      (erase-buffer)
      (unless (zerop (call-process "git" nil t nil "checkout" ref))
        (user-error "git checkout failed: %s" (buffer-string))))
    (message "Checked out %s" ref)))

(with-eval-after-load 'lab
  (define-key lab-merge-request-diff-mode-map (kbd "C-c ; g") #'my/lab-checkout-mr-branch))
