(use-package xah-lookup
  :ensure t
  :diminish
  :init
  (setq xah-lookup-browser-function 'eww))

(use-package selected
  :ensure t
  :demand t
  :diminish
  :bind (:map selected-keymap
              ("U" . unfill-region)
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
