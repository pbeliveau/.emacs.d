(use-package ess
  :bind ("C-c 2" . run-ess-r)
  :init
  :mode ("\\.R\\'" . R-mode)
  :config
  (setq ess-style 'Rstudio
        ess-eval-visibly nil
        ess-tab-complete-in-script t
        ess-ask-for-ess-directory nil)
  '(ess-smart-S-assign-key nil))

(use-package ess-R-data-view
  :after  (:any ess-r-mode inferior-ess-r-mode ess-r-transcript-mode))

(use-package ess-view
  :after  (:any ess-r-mode inferior-ess-r-mode ess-r-transcript-mode))

(use-package ess-smart-equals
  :init   (setq ess-smart-equals-extra-ops '(brace paren percent))
  :after  (:any ess-r-mode inferior-ess-r-mode ess-r-transcript-mode)
  :config (ess-smart-equals-activate))

(use-package ess-smart-underscore
  :after  (:any ess-r-mode inferior-ess-r-mode ess-r-transcript-mode))
