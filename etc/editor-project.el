(use-package annotate
  :blackout t
  :config
  (setq annotate-file (concat no-littering-var-directory "var/.notes")))

(use-package bm
  :demand t
  :bind
  ("C-c z a" . bm-bookmark-annotate)
  ("C-c z n" . bm-next)
  ("C-c z p" . bm-previous)
  ("C-c z s" . bm-show-all)
  ("C-c z t" . bm-toggle)
  :init
  (setq bm-restore-repository-on-load t)
  :config
  (setq bm-cycle-all-buffers t)
  (setq bm-repository-file (concat no-littering-var-directory "private/bm-repo"))
  (setq-default bm-buffer-persistence t)
  (add-hook 'after-init-hook 'bm-repository-load)
  (add-hook 'kill-buffer-hook #'bm-buffer-save)
  (add-hook 'kill-emacs-hook #'(lambda nil
                                   (bm-buffer-save-all)
                                   (bm-repository-save)))
  (add-hook 'after-save-hook #'bm-buffer-save)
  (add-hook 'find-file-hooks   #'bm-buffer-restore)
  (add-hook 'after-revert-hook #'bm-buffer-restore)
  (add-hook 'magit-pre-refresh-hook #'bm-buffer-save))

(use-package bookmark
  :straight nil
  :init
  (setq bookmark-default-file (concat
                               no-littering-var-directory
                               "private/bookmark-default.el")))

(use-package diff-hl
  :blackout diff-hl-mode
  :hook ((magit-post-refresh . diff-hl-magit-post-refresh)
         (dired-mode         . diff-hl-dired-mode))
  :config
  (global-diff-hl-mode))

(use-package projectile
  :init
  :bind (("C-c C-p" . projectile-command-map)))

(use-package magit
  :defer t
  :bind ("C-c 4" . magit))

(use-package markdown-changelog)

(use-package git-identity
  :disabled ;; Not working currently
  :after magit
  :bind (:map magit-status-mode
              ("I" . git-identity-info))
  :hook (magit-status-mode . git-identity-magit-mode)
  :config
  (setq git-identity-verify t
        git-identity-default-username user-full-name))

(use-package saveplace
  :straight (saveplace :type built-in)
  :defer 5
  :config
  (setq save-place t))
