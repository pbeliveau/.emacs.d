(use-package emms
  :ensure t
  :defer t
  :bind
  (("C-c M-e g"   . emms-play-directory)
   ("C-c M-e d"   . emms-play-dired)
   ("C-c M-e v"   . emms-playlist-mode-go)
   ("C-c M-e x"   . emms-start)
   ("C-c M-e SPC" . emms-pause)
   ("C-c M-e s"   . emms-stop)
   ("C-c M-e n"   . emms-next)
   ("C-c M-e p"   . emms-previous)
   ("C-c M-e e"   . emms-play-file)
   ("C-c M-e h"   . emms-shuffle)
   ("C-c M-e r"   . emms-toggle-repeat-track)
   ("C-c M-e R"   . emms-toggle-repeat-playlist)
   ("C-c M-e >"   . emms-seek-forward)
   ("C-c M-e <"   . emms-seek-backward)
   ("C-c M-e f"   . emms-show))
  :init
  (setq emms-repeat-playlist nil
        emms-source-file-default-directory "~/media/audio/"
        emms-show-format "NP: %s"
        emms-track-description-function 'emms-track-simple-description)
  :config
  (emms-standard)
  (use-package emms-browser
    :straight (emms-browser :local-repo nil))
  (use-package emms-player-mpv
    :straight (emms-browser-mpv :local-repo nil)
    :init
    (progn
      (require 'emms-player-mpv)
      (add-to-list 'emms-player-list 'emms-player-mpv))))
