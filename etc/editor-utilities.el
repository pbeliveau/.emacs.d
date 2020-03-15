(use-package chronometer)
(use-package key-quiz)
(use-package md4rd)
(use-package memory-usage)
(use-package noccur)
(use-package speed-type)
(use-package spray)

(use-package mount
  :commands mount-mode
  :straight (mount :type git :host github :repo "zellerin/mount-mode"))

(use-package deadgrep
  :bind (("C-c r" . deadgrep)))

(use-package memento-mori
  :if (not (memq window-system '(w32)))
  :diminish
  :init
  (load (concat no-littering-var-directory "private/.memento"))
  :config
  (setq memento-mori-birth-date age_string)
  (memento-mori-mode))

(use-package url-shortener
  :if (not (memq window-system '(w32)))
  :init
  (load (concat no-littering-var-directory "private/.bitly"))
  :config
  (setq bitly-access-token bitly_token))

(use-package wttrin
  :config
  (setq wttrin-default-cities          '("Ottawa")
        wttrin-default-accept-language '("Accept-Language" . "en-US")))

(use-package webpaste
  :disabled
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
  :defer t
  :bind ("C-x w" . web-search)
  :config
  (setq web-search-default-provider "DuckDuckGo"))
