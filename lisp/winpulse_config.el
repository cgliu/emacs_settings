(provide 'winpulse_config)

(use-package winpulse
  :vc (:url "https://github.com/xenodium/winpulse"
       :rev :newest)
  :config
  (winpulse-mode +1))

(use-package nyan-mode
  :ensure t
  :config
  (nyan-mode +1))

(use-package org-fragtog
  :ensure t
  :hook (org-mode . org-fragtog-mode))