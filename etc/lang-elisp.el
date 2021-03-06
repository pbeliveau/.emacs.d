(use-package smartparens
  :hook (prog-mode . smartparens-mode)
  :bind (("C-:"     . sp-comment)
         ("C-c d K" . sp-kill-whole-line)
         ("C-c d W" . sp-delete-region)
         ("C-c d b" . sp-beginning-of-sexp)
         ("C-c d c" . sp-clone-sexp)
         ("C-c d d" . sp-delete-char)
         ("C-c d e" . sp-end-of-sexp)
         ("C-c d i" . sp-indent-adjust-sexp)
         ("C-c d k" . sp-kill-sexp)
         ("C-c d n" . sp-next-sexp)
         ("C-c d p" . sp-previous-sexp)
         ("C-c d u" . sp-unwrap-sexp)
         ("C-c d w" . sp-delete-word)
         ("C-j"     . sp-newline)))

(use-package eldoc
  :ensure nil
  :blackout
  :hook ((emacs-lisp-mode        . turn-on-eldoc-mode)
          (lisp-interaction-mode . turn-on-eldoc-mode)
          (ielm-mode             . turn-on-eldoc-mode)
          (cider-mode            . turn-on-eldoc-mode)))

(use-package eldoc-eval
  :blackout
  :config
  (autoload 'eldoc-in-minibuffer-mode "eldoc-eval")
  (eldoc-in-minibuffer-mode 1))

(use-package with-emacs)
