(use-package browse-kill-ring
  :bind ("M-y" . browse-kill-ring))

(use-package easy-kill
  :bind ("M-w" . easy-kill))

(use-package mark-thing-at
  :config
  (mark-thing-at-mode))

(use-package ox-clip)

(use-package undo-fu
  :bind (("C-z"   . undo-fu-only-undo)
         ("C-S-z" . undo-fu-only-redo)))

(use-package undo-fu-session
  :config
  (setq undo-fu-session-directory (concat no-littering-var-directory "undo-fu")
        undo-fu-session-incompatible-files '("/COMMIT_EDITMSG\\'" "/git-rebase-todo\\'"))
  (global-undo-fu-session-mode))

(use-package volatile-highlights
  :blackout t
  :config
  (volatile-highlights-mode t))
