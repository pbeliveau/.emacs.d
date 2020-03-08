(use-package auto-fill-mode
  :straight (saveplace :type built-in)
  :diminish
  :init
  (setq-default fill-column 80)
  :hook
  ((markdown-mode text-mode org-mode tex-mode pdf-annot-minor-mode)))

(use-package dynamic-spaces
  :diminish dynamic-spaces-mode
  :config
  (dynamic-spaces-global-mode t))

(use-package format-all)

(use-package fix-word
  :bind (("M-u" . fix-word-upcase)
         ("M-l" . fix-word-downcase)
         ("M-c" . fix-word-capitalize)))

(use-package fold-this
  :bind ("C-c C-f" . fold-this))

(use-package origami
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
  :defer t
  :diminish ws-butler-mode
  :hook (prog-mode . ws-butler-mode))

;; Don't use hard tabs
(setq-default indent-tabs-mode nil)
(setq electric-indent-mode nil)

;; Turn on disabled by default
(put 'set-goal-column 'disabled nil)

;; Default parenthesis mode
(show-paren-mode 1)
(global-hl-line-mode 1)

(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))
(global-set-key (kbd "C-;") 'toggle-comment-on-line)

;; use 2 spaces for tabs
(defun die-tabs ()
  (interactive)
  (set-variable 'tab-width 2)
  (mark-whole-buffer)
  (untabify (region-beginning) (region-end))
  (keyboard-quit))
