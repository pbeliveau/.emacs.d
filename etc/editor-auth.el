(use-package auth-source
  :ensure nil
  :preface
  (eval-when-compile
    (defvar auth-sources))
  :config
  (setq auth-sources
        (list
         (concat no-littering-var-directory "private/.authinfo.gpg"))))

(use-package pinentry
  :config
  (setenv "INSIDE_EMACS" emacs-version)
  (defun gr/gpg-update-tty (&rest _args)
    (shell-command
     "gpg-connect-agent updatestartuptty /bye"
     " *gpg-update-tty*")))

(use-package epa
  :ensure nil
  :after pinentry
  :preface
  (eval-when-compile
    (defvar epa-pinentry-mode))
  :init
  (setq epa-pinentry-mode 'loopback)
  :config
  (setq epa-file-select-keys nil
        epa-file-cache-passphrase-for-symmetric-encryption t))

(use-package epg
  :ensure nil
  :after epa)

(use-package exec-path-from-shell)

(use-package keychain-environment
  :config
  (keychain-refresh-environment))
