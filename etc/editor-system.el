(use-package desktop-environment
  :if (string-equal system-type "gnu/linux"))

(use-package daemons
  :if (string-equal system-type "gnu/linux"))

(use-package pulseaudio-control
  :if (string-equal system-type "gnu/linux")
  :config
  (pulseaudio-control-default-keybindings))
