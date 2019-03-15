(use-package auto-fill-mode
  :ensure nil
  :diminish
  :init
  (setq-default fill-column 80)
  :hook
  ((markdown-mode text-mode org-mode tex-mode)))

(use-package dynamic-spaces
  :ensure t
  :diminish dynamic-spaces-mode
  :config
  (dynamic-spaces-global-mode t))

(use-package fix-word
  :ensure t
  :bind (("M-u" . fix-word-upcase)
         ("M-l" . fix-word-downcase)
         ("M-c" . fix-word-capitalize)))

(use-package origami
  :ensure t)

(use-package ws-butler
  :ensure t
  :defer t
  :diminish ws-butler-mode
  :hook (prog-mode . ws-butler-mode))

;; Don't use hard tabs
(setq-default indent-tabs-mode nil)
(setq electric-indent-mode nil)

;;; Turn on disabled by default
(put 'set-goal-column 'disabled nil)
