;;; org_roam_config.el --- Org-roam configuration -*- lexical-binding: t -*-

(use-package org-roam
  :custom
  (org-roam-directory (file-truename "~/org-roam"))
  :config
  (make-directory org-roam-directory t)
  (org-roam-db-autosync-mode))

(use-package org-roam-ui
  :after org-roam
  :custom
  (org-roam-ui-sync-theme t)
  (org-roam-ui-follow t)
  (org-roam-ui-update-on-save t))

;; Trigger org-roam-node-insert when typing "[[" in org-mode
(defun my/org-roam-link-insert ()
  "When `[[' is typed in org-mode, delete it and call `org-roam-node-insert'."
  (when (and (eq major-mode 'org-mode)
             (looking-back "\\[\\[" 2))
    (delete-char -2)
    (org-roam-node-insert)))
(add-hook 'post-self-insert-hook #'my/org-roam-link-insert)

(provide 'org_roam_config)
;;; org_roam_config.el ends here
