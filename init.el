;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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
