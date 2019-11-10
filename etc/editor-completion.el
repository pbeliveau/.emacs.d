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

(use-package company-anaconda
  :ensure t
  :after (company python-mode anaconda-mode))

(use-package hippie-exp
  :ensure nil
  :bind ("M-/" . hippie-expand)
  :config
  (setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol)))

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
  (recentf-mode 1)
  :config
  (setq recentf-max-menu-items 100
        ))

(use-package smex
  :ensure t
  :defer 10
  :commands smex
  :bind ("M-x" . smex))

(use-package prescient
  :ensure t
  :config
  (progn
    (prescient-persist-mode t)))

(use-package company-prescient
  :ensure t
  :after company
  :config
  (progn
    (company-prescient-mode t)))

(use-package ivy-prescient
  :ensure t
  :after ivy
  :config
  (progn
    (ivy-prescient-mode t)))
