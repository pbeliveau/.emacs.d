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

(use-package anki-editor
  :config
  (setq anki-editor-create-decks t))

(use-package hypothesis
  :straight (hypothesis :type git
                        :host github
                        :repo "kungsgeten/hypothesis")
  :init
  (load (concat no-littering-var-directory "private/.hypothesis"))
  :config
  (setq hypothesis-token        hypothesis_api
        hypothesis-username     hypothesis_uname))

(use-package todoist
  :init
  (load (concat no-littering-var-directory "private/.todoist"))
  :config
  (setq todoist-token todoist_api))

(use-package calc-at-point)
