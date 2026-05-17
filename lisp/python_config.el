(provide 'python_config)

(use-package better-defaults :ensure t)
(use-package ein :ensure t)
(use-package flyspell :ensure t)
(use-package py-autopep8 :ensure t)

(use-package elpy
  :ensure t
  :init (setq elpy-rpc-python-command "python3")
  :config
  (elpy-enable)
  (when (require 'flycheck nil t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode))
  (add-hook 'elpy-mode-hook 'py-autopep8-mode)
  (setq py-autopep8-options '("--max-line-length=120")))

(use-package pyvenv
  :ensure t
  :config
  (pyvenv-activate (expand-file-name "~/miniforge3")))

;; Python interpreter
(setq python-interpreter "~/miniforge3/bin/python")
(setq python-shell-virtualenv-root (expand-file-name "~/miniforge3"))
(setq python-shell-interpreter (expand-file-name "~/miniforge3/bin/python"))
(setenv "WORKON_HOME" (expand-file-name "~/miniforge3/bin"))
(setenv "KMP_DUPLICATE_LIB_OK" "TRUE")

;; Code cell execution (delimited by # %%)
(defun my/save-and-send-codecell ()
  "Save buffer then send the current code cell (delimited by # %%) to Python shell."
  (interactive)
  (save-buffer)
  (let ((start (save-excursion
                 (if (re-search-backward "^# %%" nil t) (forward-line 1) (goto-char (point-min)))
                 (point)))
        (end (save-excursion
               (if (re-search-forward "^# %%" nil t) (line-beginning-position) (point-max)))))
    (python-shell-send-region start end)))

(with-eval-after-load 'python
  (define-key python-mode-map (kbd "C-c C-c") #'my/save-and-send-codecell))
