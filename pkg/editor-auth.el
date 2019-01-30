(unless (memq window-system '(w32))
  (use-package auth-source-pass
    :ensure t
    :config (auth-source-pass-enable))

  (use-package auth-source
    :ensure t
    :preface
    (eval-when-compile
      (defvar auth-sources))
    :config
    (setq auth-sources '()))

  (use-package pass
    :ensure t
    :config
    (setq password-store-password-length 20))

  (use-package password-store
    :ensure t)

  (use-package password-store-otp
    :ensure t)

  (use-package pinentry
    :ensure t
    :config
    (setenv "INSIDE_EMACS" emacs-version)
    (defun gr/gpg-update-tty (&rest _args)
      (shell-command
       "gpg-connect-agent updatestartuptty /bye"
       " *gpg-update-tty*"))
    (with-eval-after-load 'magit
      (advice-add 'magit-start-git :before 'gr/gpg-update-tty)
      (advice-add 'magit-call-git :before 'gr/gpg-update-tty)))

  (use-package epa
    :after pinentry
    :ensure t
    :preface
    (eval-when-compile
      (defvar epa-pinentry-mode))
    :init
    (setq epa-pinentry-mode 'loopback))

  (use-package epg
    :ensure t
    :after epa
    :preface
    (declare-function pinentry-start nil)
    :config
    (pinentry-start))

  (defun kludge-gpg-agent ()
    (if (display-graphic-p)
        (setenv "DISPLAY" (terminal-name))
      (setenv "GPG_TTY" (terminal-name))
      (setenv "DISPLAY")))
  (add-hook 'window-configuration-change-hook 'kludge-gpg-agent)

  (use-package exec-path-from-shell
    :ensure t)

  (setenv "GPG_AGENT_INFO" nil)
  (setenv "SSH_AUTH_SOCK" (shell-command-to-string "gpgconf --list-dirs agent-ssh-socket"))
  (setenv "SSH_AGENT_PID" (shell-command-to-string ""))
  (setenv "GPG_TTY" (shell-command-to-string "echo $TTY"))
  (setenv "SSH_KEY_PATH" (shell-command-to-string "~/.ssh/rsa_id"))
  (setenv "SWAYSOCK" (shell-command-to-string "ls /run/user/*/sway-ipc.*.sock | head -n 1")))
