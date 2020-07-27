(use-package csv-mode
  :mode "\\.[Cc][Ss][Vv]\\'"
  :init (setq csv-separators '("," ";" "|"))
  :config
  (defun pb/insert-delimiter ()
    "Simple function to insert CSV-like delimiter at the column position
for every line in the active buffer. The cursor position is used for
the column. Modified version of xah-insert-column-az function from
ergomacs.org"
    (interactive)
    (let (($insChar (string-to-char (read-string "Default: " ",")))
          ($howmany (count-lines (point-min) (point-max)))
          ($colpos (- (point) (line-beginning-position))))
      (beginning-of-buffer)
      (dotimes ($i $howmany )
        (progn
          (beginning-of-line)
          (forward-char $colpos)
          (insert-char $insChar)
          (forward-line))))))

(use-package yaml-mode
  :mode ("\\.yml\\'" "\\.yaml\\'"))

(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'"       . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "pandoc -f markdown -t html -s --mathjax --highlight-style=pygments"))

(use-package pandoc-mode)
