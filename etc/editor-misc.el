(use-package sudoku
  :defer t)

(use-package deflayer
  :quelpa (deflayer
            :fetcher github
            :repo "dustinlacewell/deflayer.el"))

(use-package anki-editor
  :config
  (setq anki-editor-create-decks t))

(use-package hypothesis
  :defer t
  :quelpa (hypothesis
           :fetcher github
           :repo "Kungsgeten/hypothesis")
  :init
  (load (concat no-littering-var-directory "private/.hypothesis") nil t)
  :config
  (setq hypothesis-token        hypothesis_api
        hypothesis-username     hypothesis_uname))

(use-package todoist
  :defer t
  :init
  (load (concat no-littering-var-directory "private/.todoist") nil t)
  :config
  (setq todoist-token todoist_api))

(use-package calc-at-point)
