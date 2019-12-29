(use-package chronometer
  :ensure t
  :defer t)

(use-package key-quiz
  :ensure t
  :defer t)

(use-package md4rd
  :ensure t
  :defer t)

(use-package mount
  :commands mount-mode
  :straight (mount :type git :host github :repo "zellerin/mount-mode"))

(use-package speed-type
  :ensure t
  :defer t)

(use-package spray
  :ensure t
  :defer t)

(use-package deadgrep
  :ensure t
  :bind (("C-c r" . deadgrep)))

(use-package memento-mori
  :ensure t
  :diminish
  :init
  (if (eq (file-exists-p (concat no-littering-var-directory "memento/.memento")) nil)
      (progn
        (make-directory (concat no-littering-var-directory "memento"))
        (make-empty-file (concat no-littering-var-directory "memento/.memento"))))
  (load (concat no-littering-var-directory "memento/.memento"))
  :config
  (setq memento-mori-birth-date age_string)
  (memento-mori-mode))

(use-package memory-usage
  :ensure t)

(use-package noccur)

(use-package url-shortener
  :if (not (memq window-system '(w32)))
  :ensure t
  :init
  (if (eq (file-exists-p (concat no-littering-var-directory "bitly/.bitly")) nil)
      (progn
        (make-directory (concat no-littering-var-directory "bitly"))
        (make-empty-file (concat no-littering-var-directory "bitly/.bitly"))))
  (load (concat no-littering-var-directory "bitly/.bitly"))
  :config
  (setq bitly-access-token bitly_token))

(use-package wttrin
  :ensure t
  :config
  (setq wttrin-default-cities          '("Ottawa")
        wttrin-default-accept-language '("Accept-Language" . "en-US")))

(use-package webpaste
  :disabled
  :ensure t
  :bind (("C-c C-b" . webpaste-paste-buffer)
         ("C-c C-r" . webpaste-paste-region))
  :config
  (setq webpaste-paste-raw-text     t
        webpaste-paste-confirmation t
        webpaste-open-in-browser    t
        webpaste-provider-priority '("gist.github.com"))
  (add-hook 'webpaste-return-url-hook
          (lambda (url)
            (message "Copied URL to clipboard: %S" url)
            (simpleclip-set-contents url))))

(use-package web-search
  :ensure t
  :defer t
  :bind ("C-x w" . web-search)
  :config
  (setq web-search-default-provider "DuckDuckGo"))
