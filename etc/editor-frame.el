(use-package avy
  :bind (("C-q"   . avy-goto-char-in-line)
         ("C-c f" . avy-goto-char)
         ("C-c h" . avy-goto-char-2)
         ("C-c l" . avy-goto-line)
         ("C-c o" . avy-org-goto-heading-timer)
         ("M-g a" . avy-copy-line)
         ("M-g d" . avy-copy-region)
         ("M-g y" . avy-kill-ring-save-whole-line)
         ("M-g w" . avy-kill-whole-line)
         ("M-g l" . avy-move-line)
         ("M-g c" . avy-kill-ring-save-region)
         ("M-g m" . avy-move-region)
         ("M-g k" . avy-kill-region)))

(use-package ace-window
  :disabled
  :bind ("M-o" . ace-window))

(use-package beacon
  :blackout t
  :config
  (beacon-mode 1))

(use-package beginend
  :config
  (beginend-global-mode))

(use-package dbc
  :config
  (dbc-add-ruleset "pop-up-frame" dbc-pop-up-frame-action)
  (dbc-add-ruleset "same-frame" dbc-same-window-action)
  (dbc-add-ruleset "bottom" '(display-buffer-reuse-window display-buffer-below-selected))
  (dbc-add-ruleset "right" '((display-buffer-reuse-window display-buffer-in-side-window) . ((side . right) (window-width . 0.4))))
  (dbc-add-rule "same-frame" "magit" :newmajor "magit")
  (dbc-add-rule "same-frame" "help" :newname "\\*help\\*")
  (dbc-add-rule "same-frame" "proced" :newname "\\*proced\\*")
  (dbc-add-rule "same-frame" "deadgrep" :newmajor "deadgrep"))


(use-package dumb-jump
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g i" . dumb-jump-go-prompt)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config (setq dumb-jump-selector 'ivy))

(use-package focus)

(use-package frog-menu
  :straight (frog-menu :type git :host github :repo "clemera/frog-menu"))

(use-package frog-jump-buffer
  :bind ("M-g f" . frog-jump-buffer))

(use-package golden-ratio
  :blackout t
  :bind ("C-c g" . golden-ratio-mode)
  :config
  (setq golden-ratio-auto-scale t))

(use-package goto-last-point
  :bind ("C-<" . goto-last-point)
  :config (goto-last-point-mode))

(use-package goto-addr
  :hook ((compilation-mode . goto-address-mode)
         (prog-mode . goto-address-prog-mode)
         (elfeed-show-mode . goto-address-mode)
         (eshell-mode . goto-address-mode)
         (shell-mode . goto-address-mode))
  :bind (:map goto-address-highlight-keymap
              ("C-c C-l" . goto-address-at-point))
  :commands (goto-address-prog-mode
             goto-address-mode))

(use-package link-hint
  :bind
  ("C-c p o" . link-hint-open-link)
  ("C-c p c" . link-hint-copy-link)
  ("C-c p y" . link-hint-copy-link-at-point)
  ("C-c p d" . link-open-multiple-links)
  :config
  (setq browse-url-browser-function 'browse-url-generic
        browse-url-generic-program "firefox"))

(use-package minimap
  :blackout t
  :bind ("C-c m" . minimap-mode)
  :config
  (setq minimap-window-location 'right
        minimap-update-delay    0.5
        minimap-width-fraction  0.1)
  :custom-face
  (minimap-active-region-background ((t (:background "#b0b6c1")))))

(use-package move-text
  :bind (("M-n" . move-text-down)
         ("M-p" . move-text-up)))

(use-package uniquify
  :straight (uniquify :type built-in)
  :config
  (setq uniquify-buffer-name-style 'forward))

(use-package window
  :straight (window :type built-in)
  :bind (("M-o"   . other-window)
         ("C-,"   . delete-window)
         ("C-M-," . delete-other-windows))
  :config
  (add-to-list 'display-buffer-alist
               (cons "\\*Async Shell Command\\*.*"
                     (cons #'display-buffer-no-window nil))))

(use-package winum
  :defer t
  :blackout winum-mode
  :bind (("M-1" . winum-select-window-1)
         ("M-2" . winum-select-window-2)
         ("M-3" . winum-select-window-3)
         ("M-4" . winum-select-window-4)
         ("M-5" . winum-select-window-5))
  :config
  (winum-mode))
