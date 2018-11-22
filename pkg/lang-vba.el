(use-package vbasense
  :ensure t
  :bind (("C-c v" . vbasense-popup-help))
  :mode (("\\.bas\\'" . vba-mode)
         ("\\.vb\\'" . vba-mode)
         ("\\.vbs\\'" . vba-mode)))
