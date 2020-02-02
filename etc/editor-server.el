(use-package server
  :straight nil
  :bind (("C-x C-c" . my-done)
         ("C-M-c"   . kill-server))
  :defer 5
  :config
  (unless (server-running-p)
    (server-start))
  (defun my-done ()
    "Exit server buffers and hide the main Emacs window"
    (interactive)
    (save-some-buffers)
    (server-edit)
    (make-frame-invisible nil t))
  (defun kill-server ()
    "Exit server and kill daemon"
    (interactive)
    (save-some-buffers t)
    (kill-emacs)))
