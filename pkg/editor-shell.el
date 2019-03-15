(use-package eshell
  :ensure nil
  :config
  (use-package em-smart :ensure nil)
  (setq eshell-smart-space-goes-to-end t))

(use-package better-shell
    :ensure t
    :bind (("C-c ;" . better-shell-shell)
           ("C-c '" . better-shell-remote-open)))

(use-package terminal-here
  :ensure t
  :bind (([f5] . terminal-here))
  :config
  (setq terminal-here-terminal-command (list "alacritty")))
