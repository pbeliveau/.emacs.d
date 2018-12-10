(use-package ess
  :ensure t
  :pin melpa-stable
  :init
  :commands R
  :mode ("\\.R\\'" . R-mode))

(use-package ess-smart-underscore
  :ensure t)

;; (use-package ess-view
;;   :ensure t)
