(use-package spotify
  :if (not (memq window-system '(w32)))
  :ensure t
  :bind (("C-c C-s n" . spotify-next)
         ("C-c C-s p" . spotify-previous)
         ("C-c C-s t" . spotify-playpause)
         ("C-c C-s c" . spotify-current)
         ("C-c C-s q" . spotify-quit))
  :config (spotify-enable-song-notifications))
