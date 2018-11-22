(use-package auto-fill-mode
  :ensure nil
  :diminish t
  :init
  (setq-default fill-column 80)
  :hook
  ((markdown-mode text-mode org-mode tex-mode)))

;; comments
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

;; Don't use hard tabs
(setq-default indent-tabs-mode nil)
(setq electric-indent-mode nil)
; enable set-column goal
(put 'set-goal-column 'disabled nil)

;; ucase and dcase enabled
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
