(use-package eshell
  :ensure nil
  :bind (:map eshell-mode
              ("M-r" . eshell/clear))
  :config
  (use-package em-smart :ensure nil)
  (setq eshell-smart-space-goes-to-end t)
  (defun eshell/clear ()
    "Clear the eshell buffer."
    (interactive)
    (let ((inhibit-read-only t))
      (erase-buffer)
      (eshell-send-input))))

(use-package better-shell
    :ensure t
    :bind (("C-c ;" . better-shell-shell)
           ("C-c '" . better-shell-remote-open)))

(use-package terminal-here
  :ensure t
  :bind (([f5] . terminal-here))
  :config
  (setq terminal-here-terminal-command (list "alacritty")))
