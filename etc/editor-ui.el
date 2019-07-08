; generic settings
(fset 'yes-or-no-p 'y-or-n-p)
(setq create-lockfiles nil)

; remove menubar, toolbar, scrollbar
(menu-bar-mode -1)
(tool-bar-mode -1)
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(defun my/disable-scroll-bars (frame)
  (modify-frame-parameters frame
                           '((vertical-scroll-bars . nil)
                             (horizontal-scroll-bars . nil))))
(add-hook 'after-make-frame-functions 'my/disable-scroll-bars)
(global-set-key (kbd "s-t") '(lambda () (interactive)))
(setq-default frame-title-format "%b (%f)")

;; + line numbers
;; - blinking cursor
;; - no bell sound
;; + clipboard system
(global-linum-mode)
(blink-cursor-mode 0)
(setq ring-bell-function 'ignore
      x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t)

(set-face-attribute 'default nil :height 110)
(if (eq system-type 'windows-nt)
    (progn
        (set-frame-font "Consolas:pixelsize=13")
        (setq default-frame-alist '((font . "Consolas:pixelsize=13"))))
  (progn
        (set-frame-font "Fira Code:pixelsize=12")
        (setq default-frame-alist '((font . "Fira Code:pixelsize=12")))))

;; theme
(use-package naysayer-theme :ensure t :defer t)
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-spacegrey t))

(use-package doom-modeline
  :ensure t
  :after doom-themes
  :init
  (setq doom-modeline-bar-width                 3
        doom-modeline-buffer-encoding           t
        doom-modeline-enable-word-count         nil
        doom-modeline-height                    25
        doom-modeline-icon                      t
        doom-modeline-indent-info               nil
        doom-modeline-lsp                       nil
        doom-modeline-major-mode-color-icon     t
        doom-modeline-major-mode-icon           t
        doom-modeline-minor-modes               nil)
  :config
  (if (memq window-system '(w32))
      (setq doom-modeline-icon                  nil
            doom-modeline-major-mode-icon       nil
            doom-modeline-major-mode-color-icon nil))
  (doom-modeline-mode))

(use-package solaire-mode
  :hook
  ((change-major-mode after-revert ediff-prepare-buffer) . turn-on-solaire-mode)
  (minibuffer-setup . solaire-mode-in-minibuffer)
  :config
  (solaire-global-mode +1)
  (solaire-mode-swap-bg))

(use-package page-break-lines
  :ensure t
  :diminish
  :init
  (global-page-break-lines-mode))

(use-package whitespace
  :ensure nil
  :diminish
  :init
  (add-hook 'prog-mode-hook 'whitespace-mode)
  :config
  (setq whitespace-line-column 80
        whitespace-style '(face lines-tail
                                tabs
                                trailing
                                empty
                                space-before-tab::tab
                                space-before-tab::space)))

(use-package darkroom
  :pin gnu
  :ensure t)

(use-package smart-mode-line
  :ensure t
  :config
  (setq sml/name-width            25
        sml/no-confirm-load-theme t
        sml/shorten-directory     nil
        sml/shorten-modes         t)
  (smart-mode-line-enable))
