;; generic settings
(fset 'yes-or-no-p 'y-or-n-p)
(setq create-lockfiles nil)

;; remove menubar, toolbar, scrollbar
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

;;; + line numbers
;;; - blinking cursor
;;; - no bell sound
;;; + clipboard system
(global-linum-mode)
(blink-cursor-mode 0)
(setq ring-bell-function 'ignore
      x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t)

(defun set-font-emacs ()
    (interactive)
    (set-face-attribute 'default nil :height 110)
    (if (eq system-type 'windows-nt)
        (progn
          (if (member "Fira Code" (font-family-list))
              (progn
                (set-frame-font "Fira Code:pixelsize=12")
                (setq default-frame-alist '((font . "Fira Code:pixelsize=12"))))
            (progn
              (set-frame-font "Consolas:pixelsize=13")
              (setq default-frame-alist '((font . "Consolas:pixelsize=13"))))
            ))))

;;; theme
(use-package naysayer-theme :defer t)
(use-package doom-themes
  :config
   (defun set-light-theme ()
     (interactive)
     (pb/switch-theme 'doom-one-light))

   (defun set-dark-theme ()
     (interactive)
     (pb/switch-theme 'doom-nord))

   (defun pb/switch-theme (theme)
     "Disable active themes and load THEME."
     (interactive (list (intern (completing-read "Theme: "
                                                 (->> (custom-available-themes)
                                                      (-map #'symbol-name))))))
     (mapc #'disable-theme custom-enabled-themes)
     (load-theme theme 'no-confirm)
     (set-font-emacs))

   (if (>= (ts-hour (ts-now)) 13)
       (pb/switch-theme 'doom-nord)
    (pb/switch-theme 'doom-one-light)))


(use-package doom-modeline
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
  (setq doom-modeline-icon                nil
      doom-modeline-major-mode-icon       nil
      doom-modeline-major-mode-color-icon nil)
  (doom-modeline-mode))

(use-package solaire-mode
  :hook
  ((change-major-mode after-revert ediff-prepare-buffer) . turn-on-solaire-mode)
  (minibuffer-setup . solaire-mode-in-minibuffer)
  :config
  (solaire-global-mode +1)
  (solaire-mode-swap-bg))

(use-package dimmer
  :init
  (dimmer-configure-org)
  (dimmer-configure-helm)
  (dimmer-configure-which-key)
  :config
  (dimmer-mode t))

(use-package modern-fringes
  :straight (modern-fringes :type git
                            :host github
                            :repo "SpecialBomb/emacs-modern-fringes")
  :config
  (modern-fringes-invert-arrows))

(use-package page-break-lines
  :blackout t
  :init
  (global-page-break-lines-mode))

(use-package hide-mode-line
  :hook
  ((elfeed-show-mode elfeed-search-mode) . hide-mode-line-mode))

(use-package whitespace
  :straight (whitespace :type built-in)
  :blackout t
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

(use-package darkroom)
(use-package writeroom-mode
  :defer t
  :config
  (setq writeroom-width                 140
        writeroom-mode-line             nil
        writeroom-maximize-window       nil))
