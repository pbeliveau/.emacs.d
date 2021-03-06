(use-package elmacro
  :blackout elmacro
  :bind (("C-c C-e" . elmacro-mode)
         ("C-x C-)" . elmacro-show-last-macro)))

(use-package dot-mode
  :bind (:map dot-mode-map
              ("M-."   . dot-mode-execute)
              ("C-."   . nil)
              ("M-,"   . dot-mode-copy-to-last-kbd-macro)
              ("C-c ." . nil))
  :config
  (global-dot-mode))

(use-package copy-as-format)
