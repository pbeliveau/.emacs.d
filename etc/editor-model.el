(use-package plantuml-mode
  :mode "\\.plantuml\\'"
  :config
  (setq plantuml-executable-path "plantuml"
        plantuml-default-exec-mode 'executable
        plantuml-output-type "png"))
