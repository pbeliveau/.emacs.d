(defun dashboard-insert-custom (dashboard)
  (insert "Shortcuts\n")
  (insert "    ")
  (insert-button "Agenda"
                 'action (lambda (_) (org-agenda-list))
                 'follow-link t)
  (insert "\n    ")
  (insert-button "TODO"
                 'action (lambda (_) (org-todo-list))
                 'follow-link t)
  (insert "\n    "))

(use-package dashboard
  :disabled
  :init
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*"))
        dashboard-items '((recents  . 10)
                         (bookmarks . 5)
                         (agenda    . 5))
        dashboard-startup-banner 'logo)
  :config
  (dashboard-setup-startup-hook))
