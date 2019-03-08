(use-package avy
  :ensure t
  :bind (("C-c f" . avy-goto-char)
         ("C-c h" . avy-goto-char-2)
         ("C-c l" . avy-goto-line)
         ("C-c w" . avy-goto-word-1)
         ("C-c o" . avy-org-goto-heading-timer)
         ("M-g a" . avy-copy-line)
         ("M-g r" . avy-copy-region)
         ("M-g y" . avy-kill-ring-save-whole-line)
         ("M-g w" . avy-kill-whole-line)
         ("M-g l" . avy-move-line)
         ("M-g c" . avy-kill-ring-save-region)
         ("M-g m" . avy-move-region)
         ("M-g k" . avy-kill-region)))

(use-package ace-window
  :ensure t
  :init
  (use-package ibuffer
    :bind (:map ibuffer-mode-map
          ("M-o" . nil)))
  :bind ("M-o" . ace-window))

(use-package buffer-expose
  :ensure nil
  :init
  (buffer-expose-mode 1))

(use-package buffer-flip
  :ensure t
  :bind  (("M-<tab>" . buffer-flip)
          :map buffer-flip-map
          ( "M-<tab>" .   buffer-flip-forward)
          ( "M-S-<tab>" . buffer-flip-backward)
          ( "M-ESC" .     buffer-flip-abort))
  :config
  (setq buffer-flip-skip-patterns
        '("^\\*helm\\b"
          "^\\*swiper\\*$")))

(use-package golden-ratio
  :ensure t
  :diminish
  :init
  (golden-ratio-mode 1)
  :config
  (setq golden-ratio-auto-scale t))

(use-package minimap
  :if (display-graphic-p)
  :ensure t
  :diminish
  :bind ("C-c m" . minimap-mode)
  :config
  (setq minimap-window-location 'right
        minimap-update-delay    0.5
        minimap-width-fraction  0.1)
  :custom-face
  (minimap-active-region-background ((t (:background "#b0b6c1")))))

(use-package uniquify
  :ensure nil
  :config
  (setq uniquify-buffer-name-style 'forward))

(use-package move-text
  :ensure t
  :bind (("M-n" . move-text-down)
         ("M-p" . move-text-up)))

(show-paren-mode 1)
(global-hl-line-mode 1)
