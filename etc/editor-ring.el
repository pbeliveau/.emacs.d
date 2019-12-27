(use-package browse-kill-ring
  :ensure t
  :bind ("M-y" . browse-kill-ring))

(use-package easy-kill
  :ensure t
  :bind ("M-w" . easy-kill))

(use-package simpleclip
  :disabled t
  :ensure t
  :diminish
  :config
  (simpleclip-mode 1))

(use-package undo-fu
  :ensure t
  :bind (("C-z"   . undo-fu-only-undo)
         ("C-S-z" . undo-fu-only-redo)))
