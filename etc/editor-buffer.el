(use-package bird-mode
  :straight (bird-mode :type git :host github :repo "rakete/bird-mode")
  :bind ("M-g v" . bird-mode))

(use-package buffer-expose
  :init
  (buffer-expose-mode 1))

(use-package buffer-flip
  :bind  (("M-<tab>" . buffer-flip-forward)
          ("M-<iso-lefttab>" . buffer-flip-backward))
  :config
  (setq buffer-flip-skip-patterns
        '("^\\*helm\\b"
          "^\\*swiper\\*$")))

(use-package bufler
  :straight (bufler :type git
                    :host github
                    :repo "alphapapa/bufler.el")
  :bind (("C-x C-b" . bufler)
         ("C-x b"   . bufler-switch-buffer)))

(use-package ibuffer
  :bind (:map ibuffer-mode-map
        ("M-o" . nil)
        ("M-g" . nil)))

(use-package fast-scroll
  :config
  (fast-scroll-config)
  (fast-scroll-advice-scroll-functions)
  (fast-scroll-mode 1))

(use-package scratch
  :bind ("C-c b" . scratch))

(use-package simple
  :straight (simple :type built-in)
  :bind (("C-."   . kill-current-buffer)
         ("C-c 0" . toggle-truncate-lines))
  :config
  (setq column-number-mode t))

;; Prior to 27.1, not included.
(use-package so-long
  :straight (so-long :type git
                     :repo "https://git.savannah.gnu.org/git/so-long.git")
  :config
  (global-so-long-mode))

;; Force warning buffer into smaller frame
(setq display-buffer-alist
  '(("[*]Warnings[*]" .
     (display-buffer-in-side-window . '((side . bottom))))))
