(use-package company
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
  :after (company latex))

(use-package company-anaconda
  :after (company python-mode anaconda-mode))

(use-package company-org-roam
  :straight (company-org-roam :type git
                              :host github
                              :repo "jethrokuan/org-roam"
                              :files ("company-org-roam.el"))
  :after org-roam company org
  :config
  (company-org-roam-init))

(use-package company-emoji
  :config
  (add-to-list 'company-backends 'company-emoji))

(use-package emojify
  :config
  (setq emojify-company-tooltips-p t)
  (add-hook 'after-init-hook #'global-emojify-mode))

(use-package hippie-exp
  :straight (hippie-exp :type built-in)
  :bind ("M-/" . hippie-expand)
  :config
  (setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol)))

(use-package which-key
  :defer 5
  :diminish
  :commands which-key-mode
  :config
  (which-key-mode))

(use-package recentf
  :straight (recentf :type built-in)
  :defer 10
  :init
  (recentf-mode 1)
  :config
  (setq recentf-max-menu-items 100
        ))

(use-package smex
  :defer 10
  :commands smex
  :bind ("M-x" . smex))

(use-package prescient
  :config
  (progn
    (prescient-persist-mode t)))

(use-package company-prescient
  :after company
  :config
  (progn
    (company-prescient-mode t)))
