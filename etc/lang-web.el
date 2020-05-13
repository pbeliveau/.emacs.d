(use-package js
  :straight (eldoc :type built-in))

(use-package js2-mode
  :mode "\\.js\\'"
  :interpreter "node"
  :config
  (setq js2-basic-offset 2))

(use-package web-mode
  :config
  (setq web-mode-enable-auto-pairing t
        web-mode-enable-css-colorization t
        web-mode-enable-current-element-highlight t
        web-mode-enable-part-face t
        web-mode-enable-current-column-highlight t))
