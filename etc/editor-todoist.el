(use-package todoist
  :ensure t
  :init
  (load (concat no-littering-var-directory "todoist/.todoist"))
  :config
  (setq todoist-token todoist_api))
