(use-package battery
  :ensure nil
  :config
  (setq battery-update-interval 300
        battery-mode-line-format " %p%% %L"))

(use-package esup
  :commands (esup))

(use-package proced
  :ensure nil
  :bind ("C-x p" . proced)
  :config
  (add-to-list 'proced-format-alist
               '(tiny tree pid pcpu rss (args comm))))

(use-package time
  :ensure nil
  :config
  (setq display-time-day-and-date t
        display-time-default-load-average nil)
  (display-time))

(use-package symon
  :blackout
  :config
  (setq symon-sparkline-type 'plain
        symon-sparkline-width 120))
