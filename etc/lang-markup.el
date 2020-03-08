(use-package csv-mode
  :mode "\\.[Cc][Ss][Vv]\\'"
  :init (setq csv-separators '("," ";" "|")))

(use-package yaml-mode
  :mode ("\\.yml\\'" "\\.yaml\\'"))

(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'"       . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "pandoc -f markdown -t html -s --mathjax --highlight-style=pygments"))

(use-package pandoc-mode)
