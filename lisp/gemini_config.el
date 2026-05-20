(provide 'gemini_config)

;;;; --- Gemini LLM Integration (llm.el) ---
(use-package llm
  :ensure t
  :config
  (setq llm-default-provider 'gemini)
  (setq llm-gemini-model "gemini-1.5-flash-latest"))

;;;; --- gptel for interactive LLM chat ---
(use-package gptel
  :ensure t
  :config
  (setq gptel-model 'gemini-1.5-flash-latest
        gptel-backend (gptel-make-gemini "Gemini"
                        :key #'gptel-api-key
                        :stream t)))

;;;; --- gemini-region: send region to Gemini CLI ---
(defun gemini-region (begin end)
  "Send the selected region to the Gemini CLI and replace it with the output."
  (interactive "r")
  (let ((prompt (read-string "Prompt for Gemini: ")))
    (shell-command-on-region begin end
                             (format "gemini \"%s\"" prompt)
                             (current-buffer) t t)))

;;;; --- agent-shell: ACP-powered agent shell ---
(use-package agent-shell
  :ensure t
  :config
  (setq agent-shell-google-authentication
        (agent-shell-google-make-authentication :login t)))
