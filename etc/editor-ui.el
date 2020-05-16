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

;; remove windows ugly top bar and add bindings
;; to move frame
(setq default-frame-alist '((undecorated . t)))
(use-package frame-cmds
  :straight (frame-cmds :type git
                        :host github
                        :repo "emacsmirror/frame-cmds")
  :bind (("M-<up>"      . move-frame-up)
         ("M-<down>"    . move-frame-down)
         ("M-<left>"    . move-frame-left)
         ("M-<right>"   . move-frame-right)
         ("C-M-<up>"    . enlarge-frame)
         ("C-M-<down>"  . shrink-frame)
         ("C-M-<right>" . enlarge-frame-horizontally)
         ("C-M-<left>"  . shrink-frame-horizontally)))

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
     (load-theme theme 'no-confirm))

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
  ((elfeed-show-mode elfeed-search-mode pocket-reader-mode nov-mode) . hide-mode-line-mode))

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
