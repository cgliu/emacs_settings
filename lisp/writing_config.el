(provide 'writing_config)

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :config
  (setq markdown-enable-wiki-links t)
  (setq markdown-wiki-link-fontify-missing t)
  (setq markdown-wiki-link-search-subdirectories t)
  :bind (:map markdown-mode-map
              ("C-c C-e" . markdown-do)))

(use-package obsidian
  :ensure t
  :custom
  (obsidian-directory "~/Dropbox/org/intervies/obsidian_dir")
  :config
  (global-obsidian-mode t)
  :bind (:map obsidian-mode-map
              ("C-c C-o" . obsidian-follow-link-at-point)
              ("C-c C-l" . obsidian-insert-wikilink)))
