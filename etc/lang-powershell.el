(use-package powershell
  :mode ("\\.ps[12]?$" . powershell-mode)
  :config
  (setq powershell-indent 2))

(use-package ob-pwsh
  :after (org-mode)
  :load-path "var/lisp")
