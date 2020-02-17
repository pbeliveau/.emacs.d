;; Conf for mail
(setq maildir (concat no-littering-var-directory "mail"))

(use-package notmuch
  :if (not (string-equal system-type "windows-nt"))
  :demand t
  :straight (notmuch :local-repo nil)
  :bind ("C-c 1" . notmuch)
  :init
  (autoload 'notmuch "notmuch" t))

(use-package notmuch-unread
  :if (not (string-equal system-type "windows-nt"))
  :straight (notmuch-unread :type git
                            :host github
                            :repo "tmearnest/notmuch-unread")
  :config
  (setq notmuch-unread-icon " \xe0be ")
  (notmuch-unread-mode))


(use-package message
  :if (not (string-equal system-type "windows-nt"))
  :straight (message :type built-in)
  :config
  (setq message-kill-buffer-on-exit    t
        message-sendmail-envelope-from 'header
        message-send-mail-function     'message-send-mail-with-sendmail
        message-signature-directory    (concat no-littering-var-directory "mail/signatures")
        sendmail-program               (concat no-littering-var-directory "mail/script/msmtp-enqueue.sh")
        user-full-name                 "Philippe"))
