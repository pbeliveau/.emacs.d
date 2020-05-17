(use-package sudoku
  :defer t)

(use-package deflayer
  :straight (deflayer :type git
                      :host github
                      :repo "dustinlacewell/deflayer.el"))

(use-package anki-editor
  :config
  (setq anki-editor-create-decks t))

(use-package hypothesis
  :straight (hypothesis :type git
                        :host github
                        :repo "kungsgeten/hypothesis")
  :init
  (load (concat no-littering-var-directory "private/.hypothesis"))
  :config
  (setq hypothesis-token        hypothesis_api
        hypothesis-username     hypothesis_uname))

(use-package todoist
  :init
  (load (concat no-littering-var-directory "private/.todoist"))
  :config
  (setq todoist-token todoist_api))

(use-package calc-at-point)
