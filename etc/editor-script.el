(use-package elmacro
  :ensure t
  :diminish elmacro
  :bind (("C-c C-e" . elmacro-mode)
         ("C-x C-)" . elmacro-show-last-macro)))

(use-package piper
  :straight (emacs-piper :type git
                         :host gitlab
                         :repo "howardabrams/emacs-piper")
  :bind ("C-c C-|" . piper))
