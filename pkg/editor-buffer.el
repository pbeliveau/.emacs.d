(use-package buffer-expose
  :ensure nil
  :init
  (buffer-expose-mode 1))

(use-package buffer-flip
  :ensure t
  :bind  (("M-<tab>" . buffer-flip)
          :map buffer-flip-map
          ("M-<tab>" .   buffer-flip-forward)
          ("M-ESC" .     buffer-flip-abort))
  :config
  (setq buffer-flip-skip-patterns
        '("^\\*helm\\b"
          "^\\*swiper\\*$")))

(use-package ibuffer
  :bind (:map ibuffer-mode-map
        ("M-o" . nil)
        ("M-g" . nil)))

(use-package scratch
  :ensure t
  :bind ("C-c b" . scratch))
