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

;; font
;; (use-package all-the-icons
;;   :ensure t)

;; (use-package all-the-icons-dired
;;   :ensure t
;;   :init
;;   (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

;; (use-package all-the-icons-ivy
;;   :ensure t
;;   :config
;;   (all-the-icons-ivy-setup))

;; (use-package mode-icons
;;   :ensure t)

(set-face-attribute 'default nil :height 110)
(set-frame-font "Misc Tamsyn:pixelsize=14")
(setq default-frame-alist '((font . "Misc Tamsyn:pixelsize=14")))

;; theme
(use-package circadian
  :ensure t
  :init
  (use-package tao-theme            :ensure t :defer t)
  (use-package purp-theme           :ensure t :defer t)
  (use-package poet-theme           :ensure t :defer t)
  (setq calendar-latitude   45.41
        calendar-longitude -75.69)
  :config
  (setq circadian-themes '((:sunrise . tao-yang)
                           (:sunset  . purp)
))
  (circadian-setup))

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
