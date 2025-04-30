(provide 'python_config)

;; init.el --- Emacs configuration
;; INSTALL PACKAGES
;; --------------------------------------

(use-package better-defaults :ensure t)
(use-package ein :ensure t)

;; For elpy (Emacs Lisp Python Environment) to run properly,  
;; 1) Make use the following packages are installed. If not, run
;; pip install --upgrade elpy jedi rope black flake8 autopep8 yapf
;; 2) If you are using a virtual environment, activate it first and make sure Emacs is using the same venv  
(use-package elpy :ensure t)

(use-package flyspell :ensure t)
(use-package py-autopep8 :ensure t)

;; PYTHON CONFIGURATION
;; --------------------------------------

(elpy-enable)
;; (elpy-use-ipython)
;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
   (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
   (add-hook 'elpy-mode-hook 'flycheck-mode))

(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
(setq py-autopep8-options '("--max-line-length=120"))
;; the following doesn't work
;; (add-hook 'after-init-hook 'global-color-identifiers-mode)

;; (setq column-enforce-column 121)
;; (global-column-enforce-mode)

;; disable ac-complete
;; (setq ac-modes (delq 'python-mode ac-mode))
