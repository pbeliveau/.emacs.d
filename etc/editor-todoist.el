(use-package todoist
  :init
  (load (concat no-littering-var-directory "private/.todoist"))
  :config
  (setq todoist-token todoist_api))
