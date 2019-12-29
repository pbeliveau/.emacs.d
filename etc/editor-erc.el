(use-package erc
  :if (not (memq window-system '(w32)))
  :straight (erc :type built-in)
  :ensure t
  :bind (("C-c s" . start-irc)
         ("C-c q" . stop-irc))
  :init
  (setq erc-server-coding-system '(utf-8 . utf-8)
        erc-interpret-mirc-color t
        erc-kill-buffer-on-part t
        erc-kill-queries-on-quit t
        erc-kill-server-buffer-on-quit t
        erc-save-buffer-on-part t
        erc-query-display 'buffer
        erc-log-channels-directory (concat no-littering-var-directory "erc/logs/")
        erc-auto-discard-away t
        erc-prompt-for-nickserv-password nil
        erc-services-mode 1
        erc-hide-list '("JOIN" "PART" "MODE" "NICK" "QUIT")
        erc-autojoin-channels-alist '(("#sway" "#emacs"))
        erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                  "324" "329" "332" "333" "353" "477"))
  :config
  (use-package erc-log
    :straight (erc-log :type built-in))
  (use-package erc-spelling
    :straight (erc-spelling :type built-in))

  (load (concat no-littering-var-directory "erc/.erc-auth"))

  (defun start-irc ()
     "Connect to IRC."
     (interactive)
     (erc-tls :server "irc.freenode.net"
              :port 6697
              :nick freenode-nick
              :password freenode-pass))

  (defun filter-server-buffers ()
    (delq nil
          (mapcar
           (lambda (x) (and (erc-server-buffer-p x) x))
           (buffer-list))))

  (defun stop-irc ()
    "Disconnect from IRC."
    (interactive)
    (dolist (buffer (filter-server-buffers))
        (message "Server buffer: %s" (buffer-name buffer))
        (with-current-buffer buffer
        (erc-quit-server nil)))))
