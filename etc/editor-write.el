(use-package writefreely
  :init
  (load (concat no-littering-var-directory "private/.writeas"))
  :config
  (setq writefreely-auth-token writeas_token))
