(use-package js
  :defer t)

(use-package js2-mode
  :ensure t
  :mode "\\.js\\'"
  :interpreter "node"
  :config
  (setq js2-basic-offset 2))
