(use-package writefreely
  :defer t
  :init
  (load (concat no-littering-var-directory "private/.writeas") nil t)
  :config
  (setq writefreely-auth-token writeas_token))
