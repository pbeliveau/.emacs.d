(unless (memq window-system '(w32))
  (use-package auth-source-pass
    :config (auth-source-pass-enable))

  (use-package auth-source
    :preface
    (eval-when-compile
      (defvar auth-sources))
    :config
    (setq auth-sources '()))

  (use-package pinentry
    :config
    (setenv "INSIDE_EMACS" emacs-version)
    (defun gr/gpg-update-tty (&rest _args)
      (shell-command
       "gpg-connect-agent updatestartuptty /bye"
       " *gpg-update-tty*")))

  (use-package epa
    :after pinentry
    :preface
    (eval-when-compile
      (defvar epa-pinentry-mode))
    :init
    (setq epa-pinentry-mode 'loopback))

  (use-package epg
    :after epa
    :init
    (declare-function pinentry-start nil)
    :config
    (pinentry-start))

  (use-package exec-path-from-shell)

  (use-package keychain-environment
    :config
    (keychain-refresh-environment))

  (use-package pass
    :bind ("<f9>" . pass)
    :config
    (setq password-store-password-length 20))

  (use-package password-store)

  (use-package password-store-otp)

  (use-package tramp
    :defer t
    :config
    (setq tramp-default-method "ssh")))
