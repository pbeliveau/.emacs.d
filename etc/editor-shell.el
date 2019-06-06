(use-package eshell
  :ensure nil
  :bind (([f2] . eshell))
  :config
  (use-package em-smart :ensure nil)
  (setq eshell-smart-space-goes-to-end t)
  (defun eshell/clear ()
    "Clear the eshell buffer."
    (interactive)
    (let ((inhibit-read-only t))
      (erase-buffer)
      (eshell-send-input)))
  (defun eshell/sudo-find-file (path)
  (let ((qualified-path (if (string-match "^/" path)
                            path
                          (concat (expand-file-name (eshell/pwd)) "/" path))))
    (find-file (concat "/sudo::" qualified-path)))))

(use-package better-shell
    :ensure t
    :bind (("C-c ;" . better-shell-shell)
           ("C-c '" . better-shell-remote-open)))

(use-package terminal-here
  :ensure t
  :bind (([f5] . terminal-here))
  :config
  (setq terminal-here-terminal-command (list "alacritty")))
