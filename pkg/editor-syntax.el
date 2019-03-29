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

(use-package fold-this
  :ensure t
  :bind ("C-c C-f" . fold-this))

(use-package origami
  :ensure t
  :diminish
  :commands origami-mode
  :hook prog-mode
  :bind (("C-c C-o t" . origami-toggle-node)
         ("C-c C-o r" . origami-toggle-all-nodes)
         ("C-c C-o c" . origami-close-node)
         ("C-c C-o o" . origami-open-node)
         ("C-c C-o s" . origami-close-all-nodes)
         ("C-c C-o w" . origami-open-all-nodes)
         ("C-c C-o n" . origami-next-fold)
         ("C-c C-o p" . origami-previous-fold)
         ("C-c C-o f" . origami-forward-fold))
  :config
  (global-origami-mode))

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
