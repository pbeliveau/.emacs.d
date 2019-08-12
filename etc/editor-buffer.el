(use-package bird-mode
  :ensure nil
  :load-path "var/lisp/"
  :bind ("M-g v" . bird-mode))

(use-package buffer-expose
  :ensure t
  :init
  (buffer-expose-mode 1))

(use-package buffer-flip
  :ensure t
  :bind  (("M-<tab>" . buffer-flip)
          :map buffer-flip-map
          ("M-<tab>" .   buffer-flip-forward)
          ("M-ESC" .     buffer-flip-abort))
  :config
  (setq buffer-flip-skip-patterns
        '("^\\*helm\\b"
          "^\\*swiper\\*$")))

(use-package ibuffer
  :bind (:map ibuffer-mode-map
        ("M-o" . nil)
        ("M-g" . nil)))

(use-package fast-scroll
  :quelpa (fast-scroll :fetcher github :repo "ahungry/fast-scroll")
  :config
  (fast-scroll-config)
  (fast-scroll-advice-scroll-functions))

(use-package scratch
  :ensure t
  :bind ("C-c b" . scratch))

(use-package so-long
  :ensure nil
  :if (version<= "27" emacs-version)
  :config
  (global-so-long-mode))

;; Force warning buffer into smaller frame
(setq display-buffer-alist
  '(("[*]Warnings[*]" .
     (display-buffer-in-side-window . '((side . bottom))))))
