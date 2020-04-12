(use-package elmacro
  :blackout elmacro
  :bind (("C-c C-e" . elmacro-mode)
         ("C-x C-)" . elmacro-show-last-macro)))

(use-package piper
  :straight (emacs-piper :type git
                         :host gitlab
                         :repo "howardabrams/emacs-piper")
  :bind ("C-c C-|" . piper))

(use-package dot-mode
  :config
  (global-dot-mode))

(use-package copy-as-format)
