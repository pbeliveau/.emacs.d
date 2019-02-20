;; Manage package outside GNU Emacs
(use-package system-packages
  :if (not (memq window-system '(w32)))
  :pin gnu
  :ensure t
  :bind
  (:prefix-map my/system-packages-map
               :prefix "<f12>"
               ("i" . system-packages-install)
               ("s" . system-packages-search)
               ("U" . system-packages-uninstall)
               ("D" . system-packages-list-dependencies-of)
               ("I" . system-packages-get-info)
               ("P" . system-packages-list-files-provided-by)
               ("u" . system-packages-update)
               ("O" . system-packages-remove-orphaned)
               ("l" . system-packages-list-installed-packages)
               ("C" . system-packages-clean-cache)
               ("L" . system-packages-log)
               ("v" . system-packages-verify-all-packages)
               ("V" . system-packages-verify-all-dependencies))
  :config
  (setq system-packages-use-sudo  t
        system-packages-noconfirm t))

;; Change package menu
(use-package paradox
  :ensure t
  :defer 1
  :config
  (setq paradox-display-download-count t
        paradox-execute-asynchronously t)
  (paradox-enable))

;; View and manager disk-usage
(use-package disk-usage
  :ensure t)
