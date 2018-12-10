(use-package company
  :ensure t
  :diminish
  :init (global-company-mode 1)
  :commands (company-mode)
  :bind (:map company-active-map
          ("M-n" . nil)
          ("M-p" . nil)
          ([tab] . company-select-next)
          ([backtab] . company-select-previous)
          ("C-n" . company-select-next)
          ("C-p" . company-select-previous))
  :config
  (setq company-idle-delay            0.1
        company-minimum-prefix-length 3
        company-selection-wrap-around t
        company-show-numbers          t))

(use-package company-auctex
  :ensure t
  :after (company latex))

(use-package auto-complete
  :ensure t
  :disabled t
  :diminish auto-complete-mode
  :bind (("M-RET" . auto-complete)
           :map ac-menu-map
             ("C-n" . ac-next)
             ("C-p" . ac-previous)
             ("<tab>" . ac-complete)
             ("C-SPC" . ac-expand))
  :config
  (progn
    (ac-config-default)
    (global-auto-complete-mode t))
  (setq ac-auto-start   nil
        ac-dwim         t
        ac-ignore-case  t
        ac-menu-height  20
        ac-use-fuzzy    nil
        ac-use-menu-map t
        ac-modes '(emacs-lisp-mode
                   lisp-mode
                   c-mode
                   clojure-mode
                   clojurescript-mode
                   scala-mode
                   scheme-mode
                   perl-mode
                   python-mode
                   ruby-mode
                   ecmascript-mode
                   js-mode
                   css-mode
                   makefile-mode
                   sh-mode
                   xml-mode)))

(global-set-key (kbd "M-/") 'hippie-expand)
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

(use-package which-key
  :ensure t
  :defer 5
  :diminish
  :commands which-key-mode
  :config
  (which-key-mode))

(use-package recentf
  :ensure nil
  :defer 10
  :init
  (setq recentf-save-file (concat user-emacs-directory ".recentf"))
  (recentf-mode 1)
  :config
  (setq recentf-max-menu-items 100))

(use-package smex
  :ensure t
  :defer 10
  :commands smex
  :bind ("M-x" . smex)
  :config
  (setq smex-save-file (concat user-emacs-directory ".smex-items")))
