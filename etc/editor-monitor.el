(use-package proced
  :ensure nil
  :bind ("C-x p" . proced)
  :config
  (add-to-list 'proced-format-alist
               '(tiny tree pid pcpu rss (args comm)))
  (add-to-list 'same-window-buffer-names "*Proced*"))
