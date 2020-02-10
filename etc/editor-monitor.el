(use-package battery
  :disabled
  :straight nil
  :config
  (setq battery-update-interval 300
        battery-mode-line-format " %p%% %L")
  (display-battery-mode 1))

(use-package daemons
  :ensure t
  :bind ("<f11>" . daemons)
  :config
  (setq daemons-always-sudo t))

(use-package esup
  :commands (esup))

(use-package proced
  :straight (proced :type built-in)
  :bind ("C-x p" . proced)
  :config
  (add-to-list 'proced-format-alist
               '(tiny tree pid pcpu rss (args comm))))

(use-package pulseaudio-control
  :ensure t
  :config
  (pulseaudio-control-default-keybindings))

(use-package time
  :straight (time :type built-in)
  :config
  (setq display-time-day-and-date t
        display-time-default-load-average nil)
  (display-time))

(use-package symon
  :if (not (memq window-system '(w32)))
  :ensure t
  :diminish
  :config
  (setq symon-sparkline-type 'plain
        symon-sparkline-width 120)
  (symon-mode))
