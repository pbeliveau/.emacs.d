(use-package csv-mode
  :ensure t
  :mode "\\.[Cc][Ss][Vv]\\'"
  :init (setq csv-separators '("," ";" "|")))

(use-package yaml-mode
  :ensure t
  :mode ("\\.yml\\'" "\\.yaml\\'"))

(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'"       . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "pandoc -f markdown -t html -s --mathjax --highlight-style=pygments"))
