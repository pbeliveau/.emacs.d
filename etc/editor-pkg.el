(use-package system-packages
  :if (not (memq window-system '(w32)))
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
               ("r" . system-packages-uninstall)
               ("V" . system-packages-verify-all-dependencies))
  :config
  (setq system-packages-use-sudo        nil
        system-packages-noconfirm       t
        system-packages-package-manager 'yay)
  (add-to-list 'system-packages-supported-package-managers
               '(yay .
                      ((default-sudo                    . nil)
                       (install                         . "yay -S")
                       (search                          . "yay -Ss")
                       (uninstall                       . "yay -Rs")
                       (update                          . "yay -Syu --devel --cleanafter")
                       (update-lg                       . "pacman -Qmq | grep -Ee '-(cvs|svn|git|hg|bzr|darcs)$' | yay -S --needed -")
                       (clean-cache                     . "yay -Sc")
                       (log                             . "cat /var/log/pacman.log")
                       (get-info                        . "yay -Qi")
                       (get-info-remote                 . "yay -Si")
                       (list-files-provided-by          . "yay -Ql")
                       (verify-all-packages             . "yay -Qkk")
                       (verify-all-dependencies         . "yay -Dk")
                       (remove-orphaned                 . "yay -Rns $(pacman -Qtdq)")
                       (list-installed-packages         . "yay -Qe")
                       (list-installed-packages-all     . "yay -Q")
                       (list-dependencies-of            . "yay -Qi")
                       (noconfirm                       . "--noconfirm")))))

;; View and manager disk-usage
(use-package disk-usage)
