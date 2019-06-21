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
  :quelpa (mount :fetcher github :repo "zellerin/mount-mode"))

(use-package mw-thesaurus
  :quelpa (mw-thesaurus :fetcher github :repo "agzam/mw-thesaurus.el"))

(use-package frog-menu
  :quelpa (frog-menu :fetcher github :repo "clemera/frog-menu"))

(use-package speed-type
  :ensure t
  :defer t)

(use-package spray
  :ensure t
  :defer t)

(use-package deadgrep
  :ensure t
  :bind (("C-c r" . deadgrep)))

(use-package url-shortener
  :if (not (memq window-system '(w32)))
  :ensure t
  :init
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
