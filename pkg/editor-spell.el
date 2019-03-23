(use-package flycheck
  :pin melpa
  :ensure t
  :commands (flycheck-mode
             flycheck-next-error
             flycheck-previous-error)
  :bind (("C-c i b"   . flyspell-buffer)
         ("C-c i f"   . flyspell-mode))
  :init
  (use-package ispell
    :ensure nil
    :bind (("C-c i c" . ispell-comments-and-strings)
           ("C-c i d" . ispell-change-dictionary)
           ("C-c i k" . ispell-kill-ispell)
           ("C-c i m" . ispell-message)
           ("C-c i r" . ispell-region)
           ("C-c i w" . ispell-word)))

  (use-package flycheck-ledger
    :if (not (memq window-system '(w32)))
    :ensure t
    :after ledger-mode)

  (use-package flyspell-correct
    :ensure t
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

  :config
  (defalias 'flycheck-show-error-at-point-soon 'flycheck-show-error-at-point))

(setq default-input-method "latin-1-prefix")

(use-package lorem-ipsum
  :ensure t
  :bind (("C-c C-l s" . lorem-ipsum-insert-sentences)
         ("C-c C-l p" . lorem-ipsum-insert-paragraphs)
         ("C-c C-l l" . lorem-ipsum-insert-list)))
