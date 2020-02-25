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
  :disabled
  :ensure t
  :bind ("M-o" . ace-window))

(use-package beacon
  :ensure t
  :diminish
  :config
  (beacon-mode 1))

(use-package dumb-jump
  :ensure t
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g i" . dumb-jump-go-prompt)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config (setq dumb-jump-selector 'ivy))

(use-package focus
  :ensure t)

(use-package frog-menu
  :straight (frog-menu :type git :host github :repo "clemera/frog-menu"))

(use-package frog-jump-buffer
  :bind ("M-g f" . frog-jump-buffer))

(use-package golden-ratio
  :ensure t
  :diminish
  :bind ("C-c g" . golden-ratio-mode)
  :config
  (setq golden-ratio-auto-scale t))

(use-package link-hint
  :ensure t
  :bind
  ("C-c p o" . link-hint-open-link)
  ("C-c p c" . link-hint-copy-link)
  ("C-c p y" . link-hint-copy-link-at-point)
  ("C-c p d" . link-open-multiple-links)
  :config
  (setq browse-url-browser-function 'browse-url-generic
        browse-url-generic-program "firefox"))

(use-package minimap
  :ensure t
  :diminish
  :bind ("C-c m" . minimap-mode)
  :config
  (setq minimap-window-location 'right
        minimap-update-delay    0.5
        minimap-width-fraction  0.1)
  :custom-face
  (minimap-active-region-background ((t (:background "#b0b6c1")))))

(use-package move-text
  :ensure t
  :bind (("M-n" . move-text-down)
         ("M-p" . move-text-up)))

(use-package uniquify
  :straight (uniquify :type built-in)
  :config
  (setq uniquify-buffer-name-style 'forward))

(use-package window
  :straight (window :type built-in)
  :bind (("M-o" . other-window)
         ("C-," . delete-window))
  :init
  (setq pop-up-windows t)
  (add-to-list 'same-window-regexps "*Help*")
  (add-to-list 'same-window-buffer-names "*Proced*")
  (add-to-list 'same-window-buffer-names "*Password-Store*")
  (add-to-list 'same-window-buffer-names "*system-packages")
  (add-to-list 'same-window-buffer-names "*Packages*"))

(use-package winum
  :ensure t
  :defer t
  :diminish winum-mode
  :bind (("M-1" . winum-select-window-1)
         ("M-2" . winum-select-window-2)
         ("M-3" . winum-select-window-3)
         ("M-4" . winum-select-window-4)
         ("M-5" . winum-select-window-5))
  :config
  (winum-mode))
