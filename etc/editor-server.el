(use-package server
  :demand t
  :straight nil
  :bind (("C-x C-c" . my-done)
         ("C-M-c"   . kill-server))
  :defer 5
  :init
  (when (equal window-system 'w32)
    (setq server-use-tcp t))
  (setq server-auth-dir
      (let ((dir (concat user-emacs-directory
                         "server_" (format "%s_%s"
                                           emacs-major-version
                                           emacs-minor-version)
                         "_" (system-name)
                         "/")))
        (make-directory dir :parents)
        dir))
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

(use-package impatient-mode)
