(use-package sudoku
  :ensure t)

(use-package simple
  :straight (simple :type built-in)
  :bind ("C-." . kill-current-buffer)
  :config
  (setq column-number-mode t))
