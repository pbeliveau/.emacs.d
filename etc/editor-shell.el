(use-package eshell
  :straight (eshell :type built-in)
  :bind (([f2] . eshell))
  :config
  (setq eshell-smart-space-goes-to-end t)
  (defun eshell/clear ()
    "Clear the eshell buffer."
    (interactive)
    (let ((inhibit-read-only t))
      (erase-buffer)
      (eshell-send-input)))
  (defun eshell/offrecord ()
    "Clear all history"
    (interactive)
    (kill-matching-buffers "eshell" t t)
    (shell-command "rm -rf ~/.emacs.d/var/eshell/history")
    (shell-command "rm -rf ~/.emacs.d/var/eshell/lastdir"))
  (defun eshell/sudo-find-file (path)
    (let ((qualified-path (if (string-match "^/" path)
                              path
                            (concat (expand-file-name (eshell/pwd)) "/" path))))
      (find-file (concat "/sudo::" qualified-path)))))

(use-package eshell-toggle
  :bind ("C-'" . eshell-toggle))

(use-package better-shell
    :bind (("C-c ;" . better-shell-shell)
           ("C-c '" . better-shell-remote-open)))

(use-package terminal-here
  :bind (([f5] . terminal-here))
  :config
  (setq terminal-here-terminal-command (list "alacritty")))
