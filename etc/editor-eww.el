(use-package eww
  :ensure nil
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
  :ensure nil
  :init
  (setq-default shr-inhibit-images t
                shr-use-fonts      nil))

(use-package shrface
  :ensure t
  :after shr
  :init
  (use-package org-bullets))
