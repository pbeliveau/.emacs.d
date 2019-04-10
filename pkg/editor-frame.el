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

(use-package frog-menu
  :if (not (memq window-system '(w32)))
  :quelpa (frog-menu :fetcher github :repo "clemera/frog-menu"))

(use-package golden-ratio
  :ensure t
  :diminish
  :bind ("C-c g" . golden-ratio-mode)
  :config
  (setq golden-ratio-auto-scale t))

(use-package link-hint
  :ensure t
  :bind
  ("C-c C-c o" . link-hint-open-link)
  ("C-c C-c c" . link-hint-copy-link)
  ("C-c C-c y" . link-hint-copy-link-at-point)
  ("C-c C-c d" . link-open-multiple-links)
  :config
  (setq browse-url-browser-function 'browse-url-generic
        browse-url-generic-program "brave"))

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

(use-package move-text
  :ensure t
  :bind (("M-n" . move-text-down)
         ("M-p" . move-text-up)))

(use-package uniquify
  :ensure nil
  :config
  (setq uniquify-buffer-name-style 'forward))

(use-package winum
  :ensure t
  :diminish winum-mode
  :bind (("M-1" . winum-select-window-1)
         ("M-2" . winum-select-window-2)
         ("M-3" . winum-select-window-3)
         ("M-4" . winum-select-window-4)
         ("M-5" . winum-select-window-5))
  :config
  (winum-mode))

;; Enable narrow region and function to
;; make use of it with clone.
(put 'narrow-to-region 'disabled nil)
(defun narrow-to-region-indirect (start end)
  "Restrict editing in this buffer to the current region, indirectly."
  (interactive "r")
  (deactivate-mark)
  (let ((buf (clone-indirect-buffer nil nil)))
    (with-current-buffer buf
      (narrow-to-region start end))
      (switch-to-buffer buf)))
(bind-key "C-x n i" 'narrow-to-region-indirect)
