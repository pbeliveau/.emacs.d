(use-package crux
  :bind (("C-k"          . crux-smart-kill-line)
         ("C-c k"        . crux-kill-other-buffers)
         ("C-c c"        . crux-cleanup-buffer-or-region)
         ("C-o"          . crux-other-window-or-switch-buffer)
         ("C-c M-d"      . crux-delete-file-and-buffer)
         ("C-c M-c"      . crux-copy-file-preserve-attributes)
         ("<deletechar>" . crux-kill-whole-line)))

(use-package embrace
  :bind ("C-c o" . embrace-commander))

(use-package files
  :ensure nil
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

(use-package iedit
  :bind ("C-;" . iedit-mode))

(use-package misc
  :ensure nil
  :bind ("M-z" . zap-up-to-char))

(use-package multifiles
  :bind ("C-!" . mf/mirror-region-in-multifile))

(use-package multiple-cursors
  :bind (("C->"           . mc/mark-next-like-this)
         ("C-<"           . mc/mark-previous-like-this)
         ("C-c C-<"       . mc/mark-all-like-this)
         ("C-S-c C-S-c"   . mc/edit-lines)
         ("C-S-<mouse-1>" . mc/add-cursor-on-click)))

(use-package mc-calc)
(use-package visual-regexp)

(prefer-coding-system 'utf-8)
(set-charset-priority 'unicode)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))
