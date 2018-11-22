(use-package server
  :ensure nil
  :if window-system
  :bind ("C-x C-c" . my-done)
  :defer 5
  :config
  (unless (server-running-p)
    (server-start))
  (defun my-done ()
    "Exit server buffers and hide the main Emacs window"
    (interactive)
    (server-edit)
    (make-frame-invisible nil t)))

(global-set-key (kbd "C-M-c") 'save-buffers-kill-emacs)
