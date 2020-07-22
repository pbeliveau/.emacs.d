(use-package bird-mode
  :load-path "var/lisp"
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

(use-package helm
  :bind ("C-c j v" . helm-occur-visible-buffers))

(use-package ibuffer
  :bind (:map ibuffer-mode-map
        ("M-o" . nil)
        ("M-g" . nil)))

(use-package fast-scroll
  :blackout
  :config
  (fast-scroll-config)
  (fast-scroll-advice-scroll-functions)
  (fast-scroll-mode 1))

(use-package scratch
  :bind ("C-c b" . scratch))

(use-package simple
  :ensure nil
  :bind (("C-."   . kill-current-buffer)
         ("C-c 0" . toggle-truncate-lines))
  :config
  (setq column-number-mode t))

;; Prior to 27.1, not included.
(if (version<= "27" emacs-version)
    (progn (use-package so-long
      :load-path "var/lisp"
      :config
      (global-so-long-mode)))
  (global-so-long-mode))

;; Force warning buffer into smaller frame
(setq display-buffer-alist
  '(("[*]Warnings[*]" .
     (display-buffer-in-side-window . '((side . bottom))))))
