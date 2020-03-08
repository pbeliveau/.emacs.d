(use-package counsel-spotify
  :if (not (memq window-system '(w32)))
  :bind (("C-c C-s n" . counsel-spotify-next)
         ("C-c C-s p" . counsel-spotify-previous)
         ("C-c C-s t" . counsel-spotify-toggle-play-pause)
         ("C-c C-s s" . counsel-spotify-search-track)))
