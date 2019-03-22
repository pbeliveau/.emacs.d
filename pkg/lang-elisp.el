(use-package paredit
  :ensure t
  :diminish
  :hook ((emacs-lisp-mode                  . paredit-mode)
         (eval-expression-minibuffer-setup . paredit-mode)
         (ielm-mode                        . paredit-mode)
         (lisp-mode                        . paredit-mode)
         (lisp-interaction-mode            . paredit-mode)
         (scheme-mode                      . paredit-mode)
         (clojure-mode                     . paredit-mode)
         (cider-repl-mode                  . paredit-mode)))


(use-package eldoc
  :ensure nil
  :diminish
  :hook ((emacs-lisp-mode        . turn-on-eldoc-mode)
          (lisp-interaction-mode . turn-on-eldoc-mode)
          (ielm-mode             . turn-on-eldoc-mode)
          (cider-mode            . turn-on-eldoc-mode)))
