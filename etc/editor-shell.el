(use-package eshell
  :ensure nil
  :bind (([f2] . eshell)
         (:map eshell-mode-map
              ("<C-return>" . eshell/clear)))
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
      (find-file (concat "/sudo::" qualified-path))))

  (defun pb/clean-records ()
    (interactive)
    (with-current-buffer "*eshell*"
      (eshell-return-to-prompt)
      (eshell-kill-input)
      (insert "cd ~/.emacs.d/var/org/records/")
      (eshell-send-input)
      (eshell-return-to-prompt)
      (eshell-kill-input)
      (insert "mv *.pdf ~/.emacs.d/var/org/prints/")
      (eshell-send-input)
      (eshell-return-to-prompt)
      (eshell-kill-input)
      (insert "rm *.tex")
      (eshell-send-input)
      (eshell-return-to-prompt)
      (eshell-kill-input)
      (insert "mv *.png ~/.emacs.d/var/org/png/")
      (eshell-send-input)
      (eshell-return-to-prompt)
      (eshell-kill-input))))

(use-package eshell-toggle
  :bind ("C-'" . eshell-toggle))

(use-package eshell-prompt-extras
  :config
  (with-eval-after-load "esh-opt"
    (autoload 'epe-theme-lambda "eshell-prompt-extras")
    (setq eshell-highlight-prompt nil
          eshell-prompt-function 'epe-theme-lambda)))

(use-package better-shell
    :bind (("C-c ;" . better-shell-shell)
           ("C-c '" . better-shell-remote-open)))

(use-package terminal-here
  :bind (([f5] . terminal-here))
  :config
  (setq terminal-here-terminal-command (list "alacritty")))
