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

(use-package sudoku
  :defer t)

(use-package deflayer
  :straight (deflayer :type git
                      :host github
                      :repo "dustinlacewell/deflayer.el"))
