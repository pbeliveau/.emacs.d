(use-package powershell
  :mode "\\.ps[12]?$"
  :config
  (setq powershell-indent 2))

(use-package ob-pwsh
  :after (org-mode)
  :straight (ob-pwsh :type git
                     :host github
                     :repo "togakangaroo/ob-pwsh"
                     :files ("src/ob-pwsh.el")))
