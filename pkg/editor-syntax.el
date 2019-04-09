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
  :bind (("C-c C-o t" . origami-toggle-node)
         ("C-c C-o r" . origami-toggle-all-nodes)
         ("C-c C-o c" . origami-close-node)
         ("C-c C-o o" . origami-open-node)
         ("C-c C-o s" . origami-close-all-nodes)
         ("C-c C-o w" . origami-open-all-nodes)
         ("C-c C-o n" . origami-next-fold)
         ("C-c C-o p" . origami-previous-fold)
         ("C-c C-o f" . origami-forward-fold)))

(use-package ws-butler
  :ensure t
  :defer t
  :diminish ws-butler-mode
  :hook (prog-mode . ws-butler-mode))

;; Don't use hard tabs
(setq-default indent-tabs-mode nil)
(setq electric-indent-mode nil)

;; Turn on disabled by default
(put 'set-goal-column 'disabled nil)

;; Enable narrow region and function to
;; make use of it with clone.
(put 'narrow-to-region 'disabled nil)
(defun narrow-to-region-indirect (start end)
  "Restrict editing in this buffer to the current region, indirectly."
  (interactive "r")
  (deactivate-mark)
  (let ((buf (clone-indirect-buffer nil nil)))
    (with-current-buffer buf
      (narrow-to-region start end))
      (switch-to-buffer buf)))
(bind-key "C-x n i" 'narrow-to-region-indirect)

;; Default parenthesis mode
(show-paren-mode 1)
(global-hl-line-mode 1)
