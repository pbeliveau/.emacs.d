(use-package subword-mode
  :ensure nil
  :hook clojure-mode)

(use-package clojure-mode
  :ensure t
  :mode (("\\.edn$"    . clojure-mode)
         ("\\.boot$"   . clojure-mode)
         ("\\.cljs.*$" . clojure-mode)
         ("lein-env"   . clojure-mode))
  :config
  (add-hook 'clojure-mode-hook
          (lambda ()
            (setq inferior-lisp-program "lein repl")
            (font-lock-add-keywords
             nil
             '(("(\\(facts?\\)"
                (1 font-lock-keyword-face))
               ("(\\(background?\\)"
                (1 font-lock-keyword-face))))
            (define-clojure-indent (fact 1))
            (define-clojure-indent (facts 1))))
  (use-package clojure-mode-extra-font-locking :ensure nil))

(use-package cider
  :ensure t
  :bind (("C-c C-v"  . cider-start-http-server)
         ("C-M-r"    . cider-refresh)
         ("C-c u"    . cider-user-ns)
         ("C-c u"    . cider-user-ns))
  :config
  (setq cider-repl-pop-to-buffer-on-connect t
        cider-show-error-buffer             t
        cider-auto-select-error-buffer      t
        cider-repl-history-file             (concat
                                             no-littering-var-directory
                                             "/cider/cider-history")
        cider-repl-wrap-history             t)
  (defun cider-start-http-server ()
    (interactive)
    (cider-load-current-buffer)
    (let ((ns (cider-current-ns)))
      (cider-repl-set-ns ns)
      (cider-interactive-eval (format "(println '(def server (%s/start))) (println 'server)" ns))
      (cider-interactive-eval (format "(def server (%s/start)) (println server)" ns))))

  (defun cider-refresh ()
    (interactive)
    (cider-interactive-eval (format "(user/reset)")))

  (defun cider-user-ns ()
    (interactive)
    (cider-repl-set-ns "user")))
