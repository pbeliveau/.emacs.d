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

;; Wish I could remove this in Windows 10.
;; Unfortunatly, can't move Emacs with Win32 snap
;; movement or the mouse without the top bar... ;(
;; (setq default-frame-alist '((undecorated . t)))

;; to move frame
(use-package pretty-hydra
  :bind ("M-<tab>" . pb-window/body)
  :config
  (defun with-faicon (icon str &optional height v-adjust)
    (s-concat (all-the-icons-faicon icon :v-adjust (or v-adjust 0) :height (or height 1)) " " str))

  (defvar pb-window--title (with-faicon "windows" "Window Management" 1 -0.05))

  (pretty-hydra-define pb-window (:foreign-keys warn :title pb-window--title :quit-key "q")
    ("Actions"
     (("TAB" other-window "switch")
      ("x" ace-delete-window "delete")
      ("m" ace-delete-other-windows "maximize")
      ("w" ace-swap-window "swap")
      ("a" ace-select-window "select"))

     "Appearance"
     (("W" writeroom-mode "writeroom")
      ("O" pb/toggle-writing-mode "olivetti")
      ("R" darkroom-mode "darkroom")
      ("E" set-night-theme "theme – night")
      ("D" set-day-theme "theme – day")
      ("C" set-code-theme "theme – code"))

     "Resize"
     (("h" move-border-left "←")
      ("j" move-border-down "↓")
      ("k" move-border-up "↑")
      ("l" move-border-right "→")
      ("=" balance-windows "balance")
      ("F" toggle-frame-fullscreen "toggle fullscreen"))

     "Split"
     (("a" split-window-right "horizontally")
      ("A" split-window-horizontally-instead "horizontally instead")
      ("v" split-window-below "vertically")
      ("V" split-window-vertically-instead "vertically instead"))

     "Window"
     (("p" windmove-up "↑")
      ("n" windmove-down "↓")
      ("b" windmove-left "←")
      ("f" windmove-right "→")
      ("P" windswap-up "↑ swap")
      ("N" windswap-down "↑ swap")
      ("B" windswap-left "↑ swap")
      ("F" windswap-right "↑ swap"))

     "Zoom"
     (("+" text-scale-increase "in")
      ("-" text-scale-decrease "out")
      ("0" text-scale-adjust "reset")))))

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

;; Dashboard
(use-package dashboard
  :config
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*"))
        dashboard-center-content t
        dashboard-set-heading-icons t
        dashboard-set-file-icons t
        dashboard-set-navigator t
        dashboard-startup-banner 3)
  (dashboard-setup-startup-hook))

;;; theme
(use-package naysayer-theme)
(use-package doom-themes
  :config
  (doom-themes-visual-bell-config)
  (doom-themes-org-config)
  (setq night-theme     'doom-city-lights
        day-theme       'doom-one-light
        code-theme      'naysayer)

  (defun set-day-theme ()
    (interactive)
    (pb/switch-theme day-theme))

   (defun set-night-theme ()
     (interactive)
     (pb/switch-theme night-theme))

   (defun set-code-theme ()
     (interactive)
     (pb/switch-theme code-theme))

   (defun pb/switch-theme (theme)
     "Disable active themes and load THEME."
     (interactive (list (intern (completing-read "Theme: "
                                                 (->> (custom-available-themes)
                                                      (-map #'symbol-name))))))
     (mapc #'disable-theme custom-enabled-themes)
     (load-theme theme 'no-confirm))

   (if (>= (ts-hour (ts-now)) 18)
       (set-night-theme)
    (set-day-theme)))


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
  :config
  (advice-add 'modern-fringes-invert-arrows :around #'silence)
  (modern-fringes-invert-arrows))

(use-package page-break-lines
  :blackout
  :init
  (push 'sh-mode page-break-lines-modes)
  (push 'prog-mode page-break-lines-modes)
  (global-page-break-lines-mode))

(use-package hide-mode-line
  :hook
  ((elfeed-show-mode elfeed-search-mode pocket-reader-mode nov-mode) . hide-mode-line-mode))

(use-package whitespace
  :ensure nil
  :blackout
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

(use-package olivetti
  :config
  (defun pb/toggle-writing-mode ()
    "Toggle a distraction-free environment for writing."
    (interactive)
    (cond ((bound-and-true-p olivetti-mode)
           (linum-mode 1)
           (olivetti-mode -1))
          (t
           (linum-mode -1)
           (olivetti-set-width 100)
           (olivetti-mode 1)))))

(use-package darkroom)

(use-package writeroom-mode
  :defer t
  :config
  (setq writeroom-fullscreen-effect    'maximized
        writeroom-maximize-window       nil
        writeroom-mode-line             nil
        writeroom-width                 140))
