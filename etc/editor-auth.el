(unless (eq system-type 'windows-nt)
  (use-package auth-source-pass
    :straight (auth-source-pass :type built-in)
    :config (auth-source-pass-enable))

  (use-package auth-source
    :straight (auth-source :type built-in)
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
    :straight (epa :type built-in)
    :after pinentry
    :preface
    (eval-when-compile
      (defvar epa-pinentry-mode))
    :init
    (setq epa-pinentry-mode 'loopback))

  (use-package epg
    :straight (epg :type built-in)
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
    :straight nil
    :config
    (setq tramp-default-method "ssh"))

  (use-package prf-tramp
    :straight (prf-tramp :type git :host github :repo "p3r7/prf-tramp")
    :after tramp)

  (use-package prf-tramp-method
    :straight (prf-tramp-method :type git :host github :repo "p3r7/prf-tramp")
    :after tramp)

  (use-package prf-tramp-friendly-parsing
    :straight (prf-tramp-friendly-parsing :type git :host github :repo "p3r7/prf-tramp")
    :after tramp)

  (let ((cert-path "~/.ssh/id_dsa")
        (ssh-methods '("ssh" "sshx")))
    (setq tramp-methods
          (-map-when
           (lambda (e) (member (car e) ssh-methods))
           (lambda (e) (prf/tramp/method/def/with-cert-in-args e "-i" cert-path))
           tramp-methods))))
