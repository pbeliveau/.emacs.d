(use-package message
  :ensure nil
  :init
  (load "~/.emacs.d/mail/.mailauth")
  (progn
    (defun choose-msmtp-account ()
      (if (message-mail-p)
          (save-excursion
            (let*
                ((from (save-restriction
                         (message-narrow-to-headers)
                         (message-fetch-field "from")))
                 (account
                  (cond
                   ((string-match google from) "gmail")
                   ((string-match ncf from) "ncf")
                   ((string-match uqtr from) "uqtr"))))
              (setq message-sendmail-extra-arguments (list '"-a" account)))))))
  :config
  (setq
        message-kill-buffer-on-exit    t
        message-sendmail-envelope-from 'header
        message-send-mail-function     'message-send-mail-with-sendmail
        message-signature-directory    "~/.emacs.d/mail/signatures"
        sendmail-program               "/usr/bin/msmtp"
        user-full-name                 fullname)
  (add-hook 'message-send-mail-hook 'choose-msmtp-account))

(use-package mu4e
  :if (executable-find "mu")
  :ensure nil
  :load-path "site-lisp/mu4e/"
  :bind ("C-c 4" . mu4e)
  :init
  (load "~/.emacs.d/mail/.mailauth")
  :config
  (require 'smtpmail)
  (setq
        mu4e-maildir                        (expand-file-name "~/.emacs.d/mail")
        mu4e-attachment-dir                 "~/tmp"
        mu4e-drafts-folder                  "/drafts"
        mu4e-change-filenames-when-moving   t
        mu4e-sent-folder                    "/sent"
        mu4e-sent-messages-behavior         'sent
        mu4e-get-mail-command               "~/.emacs.d/mail/script/mbsync-update.sh"
        mu4e-compose-signature-auto-include nil
        mu4e-headers-date-format            "%Y/%m/%d %H:%M"
        mu4e-html2text-command              "iconv -c -t utf-8 | pandoc -f html -t plain"
        mu4e-view-show-addresses            t
        mu4e-view-show-images               t
        mu4e-view-image-max-width           800
        mu4e-headers-fields
                                     '( (:date          .  25)
                                        (:flags         .   6)
                                        (:from          .  22)
                                        (:subject       .  nil))
        mu4e-user-mail-address-list  (list google
                                           ncf
                                           uqtr)
        mu4e-account-alist
	  '(("gmail"
	     (mu4e-sent-messages-behavior sent)
	     (mu4e-sent-folder "/gmail/sent")
	     (mu4e-drafts-folder "/gmail/drafts")
	     (mu4e-get-mail-command "offlineimap -a gmail")
	     (user-mail-address google))
	    ("ncf"
	     (mu4e-sent-messages-behavior sent)
	     (mu4e-sent-folder "/ncf/sent")
	     (mu4e-drafts-folder "/ncf/drafts")
	     (mu4e-get-mail-command "offlineimap -a ncf")
	     (user-mail-address ncf))
	    ("uqtr"
	     (mu4e-send-messages-behavior sent)
	     (mu4e-sent-folder "/uqtr/sent")
	     (mu4e-drafts-folder "/uqtr/drafts")
	     (mu4e-get-mail-command "offlineimap -a uqtr")
	     (user-mail-address uqtr))))

  (add-hook 'mu4e-compose-pre-hook
    (defun my-set-from-address ()
      (let ((msg mu4e-compose-parent-message))
        (when msg
          (setq user-mail-address
            (cond
              ((mu4e-message-contact-field-matches msg :to google)
                google)
              ((mu4e-message-contact-field-matches msg :to ncf)
                ncf)
              ((mu4e-message-contact-field-matches msg :to uqtr)
                uqtr)
              (t ncf))))))))

  (use-package mu4e-alert
    :if (executable-find "mu")
    :ensure t
    :hook
    ((after-init . mu4e-alert-enable-notifications)
    (after-init . mu4e-alert-enable-mode-line-display))
    :config
    (setq mu4e-alert-notify-repeated-mails t)
    (mu4e-update-index)
    (mu4e-alert-notify-unread-mail-async)
    (mu4e-alert-enable-notifications)
    (mu4e-alert-set-default-style 'libnotify))

  (use-package mu4e-vars
    :ensure nil
    :config
    (setq
     mu4e-confirm-quit nil
     mu4e-context-policy 'pick-first
     mu4e-bookmarks
     '(("flag:unread AND NOT flag:trashed AND NOT flag:list" "Unread messages, no lists" ?U)
       ("flag:unread AND NOT flag:trashed"                   "Unread messages"           ?u)
       ("flag:flagged"                                       "Flagged"                   ?f)
       ("flag:unread AND NOT flag:trashed AND flag:list"     "Unread lists"              ?l)
       ("date:1h..now AND NOT flag:list"                     "Last hour"                 ?h)
       ("date:today..now AND NOT flag:list"                  "Today's messages"          ?t)
       ("date:7d..now AND NOT flag:list"                     "Last 7 days"               ?w)
       ("mime:image/*"                                       "Messages with images"      ?p)
       ("flag:attach"                                        "With attachments"          ?a)
       ("mime:application/pdf"                               "With documents"            ?d))))

(with-eval-after-load 'org
  (with-eval-after-load 'mu4e
    (use-package org-mu4e
      :ensure nil
      :init
      (setq org-mu4e-link-query-in-headers-mode nil))))
