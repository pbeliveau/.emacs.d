(use-package eww
  :straight (eww :type built-in)
  :after shr
  :bind (:map eww-mode-map
              ("I" . my/eww-toggle-images))
  :config
  (defun my/eww-toggle-images ()
    (interactive)
    (setq-local shr-inhibit-images (not shr-inhibit-images))
    (eww-reload t)
    (message "Images are now %s"
             (if shr-inhibit-images "off" "on"))))

(use-package shr
  :straight (shr :type built-in)
  :init
  (setq-default shr-inhibit-images t
                shr-use-fonts      nil))
