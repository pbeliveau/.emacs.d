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
(use-package circadian
  :if (display-graphic-p)
  :if (not (memq window-system '(w32)))
  :ensure t
  :init
  (use-package tao-theme :ensure t :defer t)
  (use-package spacemacs-theme
    :ensure t
    :defer t
    :init
    (setq spacemacs-theme-org-height    nil
          spacemacs-theme-org-highlight nil
          spacemacs-theme-org-bold      nil))
  (setq calendar-latitude   45.41
        calendar-longitude -75.69)
  :config
  (setq circadian-themes '((:sunrise . tao-yang)
                           (:sunset  . spacemacs-dark)))
  (circadian-setup))

(if (memq window-system '(w32))
    (load-theme 'tao-yang t))

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
