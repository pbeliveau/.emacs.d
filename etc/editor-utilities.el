(use-package chronometer)
(use-package disk-usage)
(use-package key-quiz)
(use-package md4rd)
(use-package memory-usage)
(use-package noccur)
(use-package speed-type)
(use-package spray)

(use-package help
  :straight nil
  :config
  (define-key help-map "h" (lambda () (interactive)
                             "Go to the *Help* buffer"
                             (display-buffer "*Help*"))))

(use-package explain-pause-mode
  :straight (explain-pause-mode :type git
                         :host github
                         :repo "lastquestion/explain-pause-mode")
  :config
  (setq explain-pause-blocking-too-long-ms 100))

(use-package keypression
  :straight (keypression :type git
                         :host github
                         :repo "chuntaro/emacs-keypression")
  :config
  (setq keypression-use-child-frame nil
        keypression-fade-out-delay 1.0
        keypression-frame-justify 'keypression-left-justified
        keypression-cast-command-name t
        keypression-cast-command-name-format "%s  %s"
        keypression-combine-same-keystrokes t
        keypression-font-face-attribute '(:width normal :height 200 :weight bold)))

(use-package mount
  :commands mount-mode
  :straight (mount :type git :host github :repo "zellerin/mount-mode"))

(use-package deadgrep
  :demand t
  ;; :bind (("C-c r" . dg))
  :config
  (defun dg (search-term directory)
    "Start a ripgrep search for SEARCH-TERM from DIRECTORY. If
called with a prefix argument, create the results buffer but
don't actually start the search."
  (interactive
   (list (deadgrep--read-search-term)
           (read-directory-name "Directory: "
                                (funcall deadgrep-project-root-function))))
  (let ( (deadgrep-project-root-function (list 'lambda '() directory)) )
    (deadgrep search-term))))

(use-package pomidor
  :config (setq pomidor-sound-tick nil
                pomidor-sound-tack nil)
  :hook (pomidor-mode . (lambda ()
                          (display-line-numbers-mode -1)
                          (setq left-fringe-width 0 right-fringe-width 0)
                          (setq left-margin-width 2 right-margin-width 0)
                          (set-window-buffer nil (current-buffer)))))

(use-package wgrep
  :config
  (setq wgrep-auto-save-buffer t
        wgrep-change-readonly-file t
        wgrep-enable-key "r"))

;; Using rg until the pull request in wgrep for deadgrep is merged. ;(
(use-package rg
  :config
  (setq rg-default-alias-fallback "everything"
        rg-keymap-prefix "r")
  (rg-enable-menu))

(use-package memento-mori
  :blackout t
  :init
  (load (concat no-littering-var-directory "private/.memento"))
  :config
  (setq memento-mori-birth-date age_string)
  (memento-mori-mode))

(use-package url-shortener
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
