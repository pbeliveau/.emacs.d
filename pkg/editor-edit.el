(use-package files
  :ensure nil
  :config
  (setq require-final-newline t))

(use-package misc
  :ensure nil
  :bind ("M-z" . zap-up-to-char))

(use-package multiple-cursors
  :ensure t
  :bind (("C->"           . mc/mark-next-like-this)
         ("C-<"           . mc/mark-previous-like-this)
         ("C-c C-<"       . mc/mark-all-like-this)
         ("C-S-c C-S-c"   . mc/edit-lines)
         ("C-S-<mouse-1>" . mc/add-cursor-on-click)))
