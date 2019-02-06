(use-package flycheck
  :pin melpa
  :ensure t
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
  :commands (flycheck-mode
             flycheck-next-error
             flycheck-previous-error)
  :config
  (defalias 'flycheck-show-error-at-point-soon 'flycheck-show-error-at-point))

(setq default-input-method "latin-1-prefix")

(use-package lorem-ipsum
  :ensure t
  :bind (("C-c C-l s" . lorem-ipsum-insert-sentences)
         ("C-c C-l p" . lorem-ipsum-insert-paragraphs)
         ("C-c C-l l" . lorem-ipsum-insert-list)))
