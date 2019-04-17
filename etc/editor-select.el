(use-package xah-lookup
  :ensure t
  :diminish
  :init
  (setq xah-lookup-browser-function 'eww))

(use-package selected
  :ensure t
  :demand t
  :diminish selected-minor-mode
  :bind (:map selected-keymap
              ("U" . unfill-region)
              ("R" . query-replace)
              ("a" . align)
              ("d" . downcase-region)
              ("m" . apply-macro-to-region-lines)
              ("q" . selected-off)
              ("r" . reverse-region)
              ("s" . sort-lines)
              ("u" . upcase-region)
              ("w" . count-words-region)
              ("f" . write-region)
              ("G" . xah-lookup-google)
              ("W" . xah-lookup-wikipedia)
              ("D" . xah-lookup-word-definition)
              :map selected-org-mode-map
              ("t" . org-table-convert-region))
  :init
  (setq selected-org-mode-map (make-sparse-keymap))
  :config
  (selected-global-mode 1))

(use-package palimpsest
  :ensure t
  :defer t
  :diminish palimpsest-mode
  :config
  (setq palimpsest-trash-file-suffix (concat
                                      no-littering-var-directory
                                      ".archive")))
