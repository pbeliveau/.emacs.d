(use-package anaconda-mode
  :ensure t)

(use-package python-mode
  :straight (python-mode :type built-in)
  :hook anaconda-mode)
