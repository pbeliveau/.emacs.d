(use-package ess
  :ensure t
  :pin melpa
  :init
  :commands R
  :mode ("\\.R\\'" . R-mode))

(use-package ess-smart-underscore
  :ensure t)
