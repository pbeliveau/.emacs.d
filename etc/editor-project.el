(use-package annotate
  :diminish
  :config
  (setq annotate-file (concat no-littering-var-directory "var/.notes")))

(use-package diff-hl
  :diminish diff-hl-mode
  :hook ((magit-post-refresh . diff-hl-magit-post-refresh)
         (dired-mode         . diff-hl-dired-mode))
  :config
  (global-diff-hl-mode))

(use-package git-auto-commit-mode
  :init
  (setq gac-debounce-interval 1000))

(use-package projectile
  :init
  :bind (("C-c C-p" . projectile-command-map)))

(use-package magit
  :defer t
  :bind ("C-c 4" . magit))

(use-package saveplace
  :straight (saveplace :type built-in)
  :defer 5
  :config
  (setq save-place t))
