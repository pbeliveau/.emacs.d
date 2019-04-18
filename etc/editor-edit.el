(use-package files
  :ensure nil
  :config
  (setq require-final-newline t
        version-control       t
        backup-by-copying     t
        kept-new-versions     64
        kept-old-versions     0
        delete-old-versions   nil
        auto-save-default     nil))

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

(prefer-coding-system 'utf-8)
(set-charset-priority 'unicode)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))