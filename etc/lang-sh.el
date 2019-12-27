(use-package sh-mode
  :straight (sh-mode :type built-in)
  :hook flycheck-mode
  :mode (("PKGBUILD\\'"   . sh-mode)
         ("\\.install\\'" . sh-mode)
         ("\\.sh\\'"      . sh-mode)
         ("\\.csh\\'"     . sh-mode)
         ("\\.zsh\\'"     . sh-mode))
  :config
  (setq sh-basic-offset 2
        sh-indentation  2))
