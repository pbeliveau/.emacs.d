(use-package exwm
  :if (not (memq window-system '(w32)))
  :if (string= (getenv "exwm_enable") "yes")
  :pin melpa
  :ensure t
  :demand t
  :config
  (setq mouse-autoselect-window t
        focus-follows-mouse     t)

  (use-package exwm-config
    :after exwm
    :ensure nil
    :demand t
    :config
    (exwm-config-default))

  (use-package exwm-edit
    :ensure t
    :after exwm
    :demand t)

  (use-package exwm-systemtray
    :after exwm
    :ensure nil
    :demand t
    :config
    (exwm-systemtray-enable))

  (use-package dmenu
    :ensure t
    :config
    (setq dmenu-prompt-string "dmenu: ")
    (exwm-input-set-key (kbd "M-g d") 'dmenu))

  (use-package exwm-randr
    :after exwm
    :ensure nil
    :demand t
    :init
    (setq exwm-randr-workspace-monitor-plist '(0 "eDP1" 1 "HDMI1" 2 "DVI-I-1-1"))
    :config
    (exwm-randr-enable))

  (use-package exwm-input
    :ensure nil
    :after exwm
    :demand t
    :preface
    (progn
      (defun my/list-all-windows ()
      "Return the list of all Emacs windows."
      (seq-mapcat (lambda (frame) (window-list frame)) (frame-list))))

    :config

    (use-package exwm-surf
      :ensure t
      :config
      (setq exwm-surf-history-file "/home/me/.surf/history")
      (setq exwm-surf-bookmark-file "/home/me/.surf/bookmarks")
      (add-hook 'exwm-manage-finish-hook 'exwm-surf-init))

    (use-package buffer-move
      :after exwm-input
      :ensure t
      :demand t
      :config
      (progn
        (exwm-input-set-key (kbd "<s-up>") #'buf-move-up)
        (exwm-input-set-key (kbd "<s-down>") #'buf-move-down)
        (exwm-input-set-key (kbd "<s-left>") #'buf-move-left)
        (exwm-input-set-key (kbd "<s-right>") #'buf-move-right)))

    (use-package desktop-environment
      :ensure t
      :demand t
      :after exwm-input
      :bind (("s-y"   . desktop-environment-screenshot-part)
             ("s-p"   . desktop-environment-screenshot)
             ("s-s m" . desktop-environment-toggle-mute)
             ("s-s i" . desktop-environment-volume-increment)
             ("s-s d" . desktop-environment-volume-decrement)
             ("s-b i" . desktop-environment-brightness-increment)
             ("s-b d" . desktop-environment-brightness-decrement))
      :config
      (setq desktop-environment-screenshot-directory "~/media/screenshot")
      (progn
        (desktop-environment-mode)))

    (use-package exwm-mff
      :if (not (memq window-system '(w32)))
      :quelpa (exwm-mff :fetcher github :repo "ieure/exwm-mff")
      :defer 30
      :diminish
      :config
      (exwm-mff-mode))

    (progn
      ;; Key bindings accessible from everywhere:
      (exwm-input-set-key (kbd "s-r") #'exwm-reset)
      (exwm-input-set-key (kbd "s-w") #'exwm-workspace-switch)
      (exwm-input-set-key (kbd "s-;") #'other-frame)
      (exwm-input-set-key (kbd "s-e") #'eshell)

    ;; Bind C-q so that the next key is sent literally to the
    ;; application
    (add-to-list 'exwm-input-prefix-keys ?\C-q)
    (define-key exwm-mode-map [?\C-q] #'exwm-input-send-next-key)
    (add-to-list 'exwm-input-prefix-keys ?\C-.)
    (add-to-list 'exwm-input-prefix-keys ?\C-,)
    (setq exwm-input-simulation-keys
          `(
            ([?\C-b]       . [left])
            ([?\M-b]       . [C-left])
            ([?\C-f]       . [right])
            ([?\M-f]       . [C-right])
            ([?\C-p]       . [up])
            ([?\C-n]       . [down])
            ([?\C-a]       . [home])
            ([S-left]      . [C-home])
            ([S-right]     . [C-end])
            ([?\C-e]       . [end])
            ([?\M-v]       . [prior])
            ([?\C-v]       . [next])
            ([?\C-d]       . [delete])
            ([?\C-k]       . [S-end ?\C-x])
            ([?\C-w]       . [?\C-x])
            ([?\M-w]       . [?\C-c])
            ([?\C-y]       . [?\C-v])
            ([?\M-d]       . [C-S-right ?\C-x])
            ([M-backspace] . [C-S-left ?\C-x])
            ([?\C-s]       . [?\C-f])
            ([?\C-g]       . [escape])))))

  (defun pbeliveau/emacs-teardown ()
    "This saves all buffers and runs `kill-emacs-hook' without killing exwm or Emacs."
    (save-some-buffers t)
    ;; `run-hooks' doesn't work with let binding.
    (setq pbeliveau-kill-hook (thread-last kill-emacs-hook
                            (remove 'exwm--server-stop)
                            (remove 'server-force-stop)))
    (run-hooks 'pbeliveau-kill-hook))

  (defun pbeliveau/poweroff ()
    "Clock out, save all Emacs buffers and shut computer down."
    (interactive)
    (when (y-or-n-p "Really want to shut down?")
      (when (org-clock-is-active)
        (org-clock-out))
      (pbeliveau/emacs-teardown)
      (start-process-shell-command "systemctl poweroff" nil "systemctl poweroff")))

  (defun pbeliveau/reboot ()
    "Save all Emacs buffers and reboot."
    (interactive)
    (when (y-or-n-p "Really want to reboot?")
      (pbeliveau/emacs-teardown)
      (start-process-shell-command "systemctl reboot" nil "systemctl reboot")))

  (defun pbeliveau/sleep ()
    "Save all Emacs buffers and reboot."
    (interactive)
    (when (y-or-n-p "Really want to suspend?")
      (start-process-shell-command "systemctl suspend" nil "systemctl suspend")))

  (exwm-enable)
  (call-powersettings))

  (use-package time
    :ensure nil
    :config
    (setq display-time-day-and-date t
          display-time-default-load-average nil)
    (display-time))

  (use-package battery
    :ensure nil
    :config
    (setq battery-update-interval 300
          battery-mode-line-format " %p%% %L")
    (display-battery-mode 1))
