(use-package diff-hl
  :ensure t
  :diminish diff-hl-mode
  :hook ((magit-post-refresh . diff-hl-magit-post-refresh)
         (dired-mode         . diff-hl-dired-mode))
  :config
  (global-diff-hl-mode))

(use-package projectile
  :ensure t
  :init
  :bind (("C-c p" . projectile-command-map)))

(use-package magit
  :pin melpa-stable
  :ensure t
  :defer t)

(use-package saveplace
  :ensure nil
  :defer 5
  :config
  (setq save-place-file (concat user-emacs-directory "places")))

(setq backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups"))))
