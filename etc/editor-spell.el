(use-package alt-codes
  :defer t
  :bind ("C-x c" . alt-codes-insert))

(use-package flycheck
  :commands (flycheck-mode
             flycheck-next-error
             flycheck-previous-error)
  :bind (("C-c i b"   . flyspell-buffer)
         ("C-c i f"   . flyspell-mode))
  :init
  (use-package flycheck-ledger
    :after ledger-mode)

  :config
  (defalias 'flycheck-show-error-at-point-soon 'flycheck-show-error-at-point)

  (use-package flycheck-plantuml
    :config
    (flycheck-plantuml-setup)))

(use-package flyspell-correct
    :blackout flyspell-correct-auto-mode
    :bind (("C-c i n" . flyspell-correct-next)
           ("C-c i p" . flyspell-correct-previous)))

(use-package lorem-ipsum
  :bind (("M-g C-l s" . lorem-ipsum-insert-sentences)
         ("M-g C-l p" . lorem-ipsum-insert-paragraphs)
         ("M-g C-l l" . lorem-ipsum-insert-list)))

(use-package ispell
  :ensure nil
  :bind (("C-c i c" . ispell-comments-and-strings)
         ("C-c i d" . ispell-change-dictionary)
         ("C-c i k" . ispell-kill-ispell)
         ("C-c i m" . ispell-message)
         ("C-c i r" . ispell-region)
         ("C-c i w" . ispell-word))
  :config
  (setq ispell-program-name "hunspell")
        ispell-local-dictionary-alist
        '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8)))

(use-package mw-thesaurus)

(use-package spell-fu
  :hook (org-mode . spell-fu-mode)
  :config
  (setq spell-fu-faces-exclude '(org-meta-line org-link org-code)
        spell-fu-directory (concat no-littering-var-directory "spell-fu")))

(use-package string-inflection
  :bind (:map prog-mode-map
              ("C-M-j" . string-inflection-all-cycle)))

(use-package typopunct
  :quelpa (typopunct
           :fetcher github
           :repo "emacsmirror/typopunct")
  :bind ("M-g t" . typopunct-mode)
  :hook (org-mode . typopunct-mode))

(use-package sdcv
  :quelpa (sdcv
           :fetcher github
           :repo "manateelazycat/sdcv")
  :config
  (setq sdcv-dictionary-data-dir (expand-file-name "~/.local/share/dic")))

;; mule-cmds.el settings
(setq default-input-method "latin-1-prefix")
(defvar use-default-input-method t)
(make-variable-buffer-local 'use-default-input-method)
(defun activate-default-input-method ()
  (interactive)
  (if use-default-input-method
      (activate-input-method default-input-method)
    (inactivate-input-method)))
(add-hook 'org-mode-hook 'activate-default-input-method)
