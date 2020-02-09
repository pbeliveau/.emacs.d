(use-package dashboard
  :disabled
  :init
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  :config
  (setq dashboard-set-init-info         t
        dashboard-center-content        t
        dashboard-set-heading-icons     t
        dashboard-set-file-icons        t
        dashboard-startup-banner        'logo)
  (dashboard-setup-startup-hook))
