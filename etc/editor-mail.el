;; Directory for mail
(setq maildir (concat no-littering-var-directory "mail"))

(use-package notmuch
  :if (not (memq window-system '(w32)))
  :straight (notmuch :local-repo nil)
  :init
  (autoload 'notmuch "notmuch" t))

(use-package message
  :if (not (memq window-system '(w32)))
  :straight (message :type built-in)
  :config
  (setq message-kill-buffer-on-exit    t
        message-sendmail-envelope-from 'header
        message-send-mail-function     'message-send-mail-with-sendmail
        message-signature-directory    (concat no-littering-var-directory "mail/signatures")
        sendmail-program               (concat no-littering-var-directory "mail/script/msmtp-enqueue.sh")
        user-full-name                 "Philippe"))
