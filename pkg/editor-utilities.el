(use-package chronometer
  :ensure t)

(use-package md4rd
  :ensure t)

(use-package speed-type
  :ensure t)

(use-package rg
  :ensure t
  :bind (("C-c r" . rg))
  :config
  (setq rg-enable-default-bindings nil))

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
