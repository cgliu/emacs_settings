(provide 'vterm_config)

(use-package vterm
  :ensure t
  :bind (("<f9>" . my/new-vterm)
         :map vterm-mode-map
         ("<f9>" . my/new-vterm)
         ("M-/" . hippie-expand)
         ("M-y" . helm-show-kill-ring))
  :config
  (add-to-list 'vterm-environment "COLORTERM=truecolor")
  (add-hook 'vterm-mode-hook #'goto-address-mode)
  (add-hook 'vterm-mode-hook
            (lambda ()
              (define-key vterm-mode-map (kbd "M-<left>") 'vterm--self-insert)
              (define-key vterm-mode-map (kbd "M-<right>") 'vterm--self-insert))))

(defun my/new-vterm ()
  "Create a new vterm buffer with an auto-incremented number."
  (interactive)
  (let ((n 1))
    (while (get-buffer (format "*vterm*<%d>" n))
      (setq n (1+ n)))
    (vterm (format "*vterm*<%d>" n))))

(defun kiro-cli ()
  "Start kiro-cli in a new vterm buffer under `default-directory'."
  (interactive)
  (let ((vterm-buffer-name (generate-new-buffer-name "*q*"))
        (vterm-shell "kiro-cli chat --classic"))
    (vterm)))

(global-set-key (kbd "C-c k") 'kiro-cli)

(defun my/vterm-helm-kill-ring ()
  "Browse kill ring with helm and paste into vterm."
  (interactive)
  (let ((helm-kill-ring-actions
         '(("Paste to vterm" .
            (lambda (candidate)
              (vterm-send-string candidate))))))
    (helm-show-kill-ring)))

;; agent-shell with Kiro CLI via ACP
(use-package agent-shell
  :ensure t
  :config
  (setq agent-shell-preferred-agent-config (agent-shell-kiro-make-config)))
