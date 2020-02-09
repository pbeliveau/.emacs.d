(use-package plantuml-mode
  :mode "\\.plantuml\\'"
  :config
  (setq plantuml-executable-path
        (shell-command-to-string "printf %s \"$(which plantuml)\"")
        plantuml-default-exec-mode 'executable
        plantuml-output-type "png"))
