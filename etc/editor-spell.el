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
    :diminish flyspell-correct-auto-mode
    :bind (("C-c i n" . flyspell-correct-next)
           ("C-c i p" . flyspell-correct-previous))
    :config
    (defun frog-menu-flyspell-correct (candidates word)
      (let* ((corrects (if flyspell-sort-corrections
                       (sort candidates 'string<)
                     candidates))
         (actions `(("C-s" "Save word"         (save    . ,word))
                    ("C-a" "Accept (session)"  (session . ,word))
                    ("C-b" "Accept (buffer)"   (buffer  . ,word))
                    ("C-c" "Skip"              (skip    . ,word))))
         (prompt   (format "Dictionary: [%s]"  (or ispell-local-dictionary
                                                   ispell-dictionary
                                                   "default")))
         (res      (frog-menu-read prompt corrects actions)))
        (unless res
          (error "Quit"))
        res))
    (setq flyspell-correct-interface #'frog-menu-flyspell-correct))

(use-package lorem-ipsum
  :bind (("M-g C-l s" . lorem-ipsum-insert-sentences)
         ("M-g C-l p" . lorem-ipsum-insert-paragraphs)
         ("M-g C-l l" . lorem-ipsum-insert-list)))

(use-package ispell
  :disabled ;; Until find a way to point to a wsl application
  :straight (ispell :type built-in)
  :bind (("C-c i c" . ispell-comments-and-strings)
         ("C-c i d" . ispell-change-dictionary)
         ("C-c i k" . ispell-kill-ispell)
         ("C-c i m" . ispell-message)
         ("C-c i r" . ispell-region)
         ("C-c i w" . ispell-word))
  :config
  (setq ispell-program-name "wsl.exe -e /usr/bin/aspell"))

(use-package mw-thesaurus)

(use-package spell-fu
  :disabled ;; Until find a way to point to a wsl application, see ispell above
  :straight (spell-fu :type git
                      :host gitlab
                      :repo "ideasman42/emacs-spell-fu")
  :hook (org-mode . spell-fu-mode)
  :config
  (setq spell-fu-faces-exclude '(org-meta-line org-link org-code)
        spell-fu-directory (concat no-littering-var-directory "spell-fu")))

(use-package string-inflection
  :bind (:map prog-mode-map
              ("C-M-j" . string-inflection-all-cycle)))

(use-package typopunct
  :straight (typopunct :type git
                       :host github
                       :repo "emacsmirror/typopunct")
  :bind ("M-g t" . typopunct-mode))

;; mule-cmds.el settings
(setq default-input-method "latin-1-prefix")
(defvar use-default-input-method t)
(make-variable-buffer-local 'use-default-input-method)
(defun activate-default-input-method ()
  (interactive)
  (if use-default-input-method
      (activate-input-method default-input-method)
    (inactivate-input-method)))
