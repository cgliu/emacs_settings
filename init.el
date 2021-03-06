(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/Dropbox/emacs")

(require 'emacs_config)
(require 'cpp_config)
(require 'python_config)
(require 'local_helm_config)
(require 'org_config)
(require 'global_kbinding)
(require 'experimental)
(require 'myfun)
;; (require 'personal_config)
