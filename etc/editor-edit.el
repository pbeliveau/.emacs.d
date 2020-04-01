(use-package files
  :straight (files :type built-in)
  :config
  (setq require-final-newline t
        version-control       t
        enable-local-eval     t
        backup-by-copying     t
        make-backup-files     t
        delete-old-versions   t
        kept-new-versions     64
        kept-old-versions     0
        delete-old-versions   t
        auto-save-default     nil))

(use-package iedit)

(use-package misc
  :straight (misc :type built-in)
  :bind ("M-z" . zap-up-to-char))

(use-package multiple-cursors
  :bind (("C->"           . mc/mark-next-like-this)
         ("C-<"           . mc/mark-previous-like-this)
         ("C-c C-<"       . mc/mark-all-like-this)
         ("C-S-c C-S-c"   . mc/edit-lines)
         ("C-S-<mouse-1>" . mc/add-cursor-on-click)))

(prefer-coding-system 'utf-8)
(set-charset-priority 'unicode)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))
