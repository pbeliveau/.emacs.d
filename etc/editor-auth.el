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

  (use-package exec-path-from-shell
    :ensure t)

  (use-package keychain-environment
    :ensure t
    :config
    (keychain-refresh-environment))

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

  (use-package tramp
    :ensure t
    :defer t
    :config
    (setq tramp-default-method "ssh")))
