(use-package emms
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
  (require 'emms-source-file)
  (require 'emms-setup)
  (require 'emms-source-playlist)
  (require 'emms-player-simple)
  (require 'emms-player-mplayer)
  (require 'emms-info-libtag)
  (emms-all)
  (emms-default-players)
  (setq emms-repeat-playlist nil
        emms-source-file-default-directory "~/media/audio/"
        emms-show-format "NP: %s"
        emms-track-description-function 'emms-track-simple-description)
  :config
  (define-emms-simple-player mplayer '(file url)
    (regexp-opt '(".ogg" ".mp3" ".wav" ".mpg" ".mpeg" ".wmv" ".wma"
                  ".mov" ".avi" ".divx" ".ogm" ".asf" ".mkv" "http://" "mms://"
                  ".rm" ".rmvb" ".mp4" ".flac" ".vob" ".m4a" ".flv" ".ogv" ".pls"))
    "mplayer" "-slave" "-quiet" "-really-quiet" "-fullscreen")

  (setq emms-player-list '(emms-player-mpg321
                           emms-player-ogg123
                           emms-player-mplayer))
  (use-package emms-browser
    :straight (emms-browser :local-repo nil)))

(use-package vlc)

(use-package bongo
  :config
  (setq bongo-enabled-backends '(mplayer)))

(use-package ytel)
