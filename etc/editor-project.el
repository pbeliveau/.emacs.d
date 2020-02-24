(use-package annotate
  :ensure t
  :diminish
  :config
  (setq annotate-file (concat no-littering-var-directory "var/.notes")))

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
  :defer t
  :bind ("C-c 4" . magit))

(use-package saveplace
  :straight (saveplace :type built-in)
  :defer 5
  :config
  (setq save-place t))
