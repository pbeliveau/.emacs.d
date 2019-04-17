(use-package ahk-mode
  :if (memq window-system '(w32))
  :ensure t
  :diminish
  :mode "\\.ahk\\'")
