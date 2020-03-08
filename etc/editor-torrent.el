(use-package mentor
  :if (not (memq window-system '(w32)))
  :defer t
  :config
  (setq mentor-rtorrent-download-directory "~/tmp"
        mentor-rtorrent-keep-session       t
        mentor-rtorrent-url                "scgi://127.0.0.1:5000"))
