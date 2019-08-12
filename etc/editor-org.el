(if (not (memq window-system '(w32)))
    (setq tasksfile "/tasks.org")
  (setq tasksfile "/tasks-work.org"))

(use-package org
  :pin org
  :ensure org-plus-contrib
  :bind (:map org-mode-map
          ("C-c i" . org-add-ids-to-headlines)
          ("C-c s" . org-table-mark-field))
  :bind ("C-C t" . switch-to-org-tasks)
  :init
  (setq org-directory "~/.emacs.d/var/org")
  :config
  (use-package org-id :ensure nil)
  (use-package org-checklist :ensure nil)
  (setq fill-column                     80
        org-adapt-indentation           nil
        org-default-notes-file          (concat org-directory "/journal.org")
        org-hide-leading-stars          t
        org-id-link-to-org-use-id       'create-if-interactive-and-no-custom-id
        org-list-description-max-indent 4
        org-startup-folded              (quote overview)
        org-startup-indented            t
        org-cycle-separator-lines       0
        org-catch-invisible-edits       'show-and-error
        org-tag-alist                   '(
                                          ("crypt" . ?C))
        org-refile-targets
          '((((concat org-directory tasksfile) :maxlevel . 2)))
        org-todo-keywords
        '((sequence "TODO" "STARTED" "RECUR" "PAUSED" "|" "DONE")
          (sequence "REPORT" "BUG" "KNOWNCAUSE" "|" "FIXED")
          (sequence "TODELEGATE" "DELEGATED" "|" "DONE")
          (sequence "TOBLOG" "WRITING" "|" "PUBLISHED")
          (sequence "TOMAIL" "DRAFT" "|" "SENT")
          (sequence "|" "CANCELED" "WAITING" "SOMEDAY"))
        org-todo-keyword-faces
        (quote
         (("STARTED" :foreground "firebrick2" :weight bold)
          ("RECUR" :foreground "light coral" :weight bold)
          ("PAUSED" :foreground "orange" :weight bold)
          ("TODELEGATE" :foreground "gray" :weight bold)
          ("DELEGATED" :foreground "dark gray" :weight bold)
          ("WAITING" :foreground "PeachPuff3" :weight bold)
          ("SOMEDAY" :foreground "snow4" :weight bold)
          ("TOBLOG" :foreground "dark sea green" :weight bold)
          ("WRITING" :foreground "sea green" :weight bold)
          ("TOMAIL" :foreground "steelblue3" :weight bold)
          ("DRAFT" :foreground "steelblue" :weight bold))))

  ;; Functions to add custom id to headers
  (defun org-custom-id-get (&optional pom create prefix)
    (interactive)
    (org-with-point-at pom
      (let ((id (org-entry-get nil "CUSTOM_ID")))
        (cond
         ((and id (stringp id) (string-match "\\S-" id))
          id)
         (create
          (setq id (org-id-new (concat prefix "h")))
          (org-entry-put pom "CUSTOM_ID" id)
          (org-id-add-location id (buffer-file-name (buffer-base-buffer)))
          id)))))

  (defun org-add-ids-to-headlines ()
    (interactive)
    (org-map-entries (lambda () (org-custom-id-get (point) 'create))))

  (defun switch-to-org-tasks ()
    (interactive)
    (find-file (concat org-directory "/tasks.org"))
    (switch-to-buffer "tasks.org"))

  (defun org-table-mark-field ()
    "Mark the current table field."
    (interactive)
    ;; Do not try to jump to the beginning of field if the point is already there
    (when (not (looking-back "|[[:blank:]]?"))
      (org-table-beginning-of-field 1))
    (set-mark-command nil)
    (org-table-end-of-field 1)))

(use-package org-contacts
  :if (not (memq window-system '(w32)))
  :ensure nil
  :custom
  (org-contacts-files '(concat org-directory
                               "/system/contacts.org")))

(use-package org-agenda
  :ensure nil
  :bind (("C-c a" . org-agenda))
  :after org
  :config
  (setq org-agenda-window-setup         'current-window
        org-agenda-files                (list (concat org-directory
                                            "/system/schedule.org")
                                              (concat org-directory
                                                      "/tasks.org")
                                              (concat org-directory
                                                 "/tasks-work.org")
                                              (concat org-directory
                                                 "/journal.org"))))

(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode))

(use-package org-download
  :if (not (memq window-system '(w32)))
  :ensure t
  ;; :bind (:map org-mode-map
  ;;             ("M-g M-d" . org-download-image)
  ;;             ("M-g M-y" . org-download-screenshot))
  :config
  (setq org-download-image-dir         (concat org-directory "/img/")
        org-download-method            'directory
        org-download-screenshot-method "scrot -s %s")
  (org-download-enable))

(use-package org-pomodoro
  :ensure t
  :config
  (setq org-pomodoro-format " %s"
        org-pomodoro-short-break-format "☕%s"
        org-pomodoro-long-break-format  " %s"))

(use-package org-gcal
  :if (not (memq window-system '(w32)))
  :ensure t
  :init
  (load (concat no-littering-var-directory "org/gcal/.calauth"))
  :config
  (setq org-gcal-client-id     clientid
        org-gcal-client-secret clientsecret
        org-gcal-file-alist    '(("beliveau.philippe@gmail.com" .
                                  "~/org/system/schedule.org"))))

(use-package org-capture
  :ensure nil
  :bind (("C-c c" . org-capture))
  :after org
  :init
  (defvar my/org-contacts-template "* %(org-contacts-template-name)
:PROPERTIES:
:GEO: %^{GEO}
:COMPANY:
:BIRTHDAY: %^{yyyy-mm-dd}
:EMAIL: %(org-contacts-template-email)
:PHONE: %^{PHONE}
:NOTE: %^{NOTE}
:END:" "Template for org-contacts.")

  (defvar my/org-schedule-template "* %?
:PROPERTIES:
:LOCATION: %^{LOCATION}
:END:" "template for calendar")

  (defvar my/org-task-template "* TODO %^{TASK}
:PROPERTIES:
:EFFORT: %^{effort|0:05|0:15|0:30|1:00|2:00|4:00}
:LINK: %^{LINK}
:END:
Captured %<%Y-%m-%d %H:%M>" "Template for basic task.")

  (defvar my/org-mail-template "* TOMAIL %^{TASK}
:PROPERTIES:
:TO: %^{TO}
:SUBJECT: %^{SUBJECT}
:END:" "Template for mail.")

  (defun org-journal-find-location ()
    (org-journal-new-entry t)
    (goto-char (point-min)))

  (defvar my/org-journal-template "* %(format-time-string org-journal-time-format)
%^{Title}
%i%?")

  :config
  (setq org-capture-templates
   `(("f" "contact-friend" entry
      (file+headline "system/contacts.org" "friend"),
      my/org-contacts-template
      :empty-lines 1)
     ("a" "contact-family" entry
      (file+headline "system/contacts.org" "family"),
      my/org-contacts-template
      :empty-lines 1)
     ("w" "contact-work" entry
      (file+headline "system/contacts.org" "work"),
      my/org-contacts-template
      :empty-lines 1)
     ("o" "contact-other" entry
      (file+headline "system/contacts.org" "other"),
      my/org-contacts-template
      :empty-lines 1)
     ("t" "todo" entry
      (file+headline "/tasks.org" "tasks"),
      my/org-task-template
      :empty-lines 1
      :immediate-finish t)
     ("j" "journal" entry
      (function org-journal-find-location),
      my/org-journal-template)
     ("l" "link" entry
      (file+headline "notes.org" "links")
           "* %? %^L %^g \n%T"
           :prepend t
           :immediate-finish t)
     ("b" "blog" entry
      (file+headline "/tasks.org" "tasks")
           "* TOBLOG %?"
           :prepend t)
     ("s" "schedule" entry
      (file "system/schedule.org"),
      my/org-schedule-template)
     ("m" "mail todo" entry
      (file+headline "/tasks.org" "Mail")
        my/org-mail-template))))

(use-package org-crypt
 :ensure nil
 :after org
 :config
 (setq org-crypt-key "8BED3C59AE2C7F3632720D33F40268B8FFE4102A"
       org-tags-exclude-from-inheritance (quote ("crypt"))))

(use-package org-journal
  :ensure t
  :after org
  :bind (("C-c Y" . journal-file-yesterday))
  :init
  (defun get-journal-file-yesterday ()
    "Gets filename for yesterday's journal entry."
    (let* ((yesterday (time-subtract (current-time) (days-to-time 1)))
           (daily-name (format-time-string "%Y%m%d.org" yesterday)))
      (expand-file-name (concat org-journal-dir daily-name))))

  (defun journal-file-yesterday ()
    "Creates and load a file based on yesterday's date."
    (interactive)
    (find-file (get-journal-file-yesterday)))
  :config
  (setq org-journal-date-format               "%e %b %Y (%A)"
        org-journal-dir (concat org-directory "/authorship/")
        org-journal-enable-agenda-integration t
        org-journal-enable-encryption         t
        org-journal-file-format               "%Y%m%d.org"
        org-journal-time-format               ""))

(use-package helm-org-rifle
  :ensure t)

(use-package ox-word
  :if (not (memq window-system '(w32)))
  :ensure nil
  :after org
  :init
  (use-package ox
    :ensure nil)
  :load-path "var/lisp/")

(use-package org-contacts
  :ensure nil
  :config
  (setq org-contacts-files (concat org-directory "/system/contacts.org")))

(use-package org-index
  :ensure t)

(use-package ox-hugo
  :ensure t
  :after ox)

(use-package org-brain
  :ensure t
  :if (not (memq window-system '(w32)))
  :init
  (setq org-brain-path (concat org-directory "/brain"))
  :config
  (setq org-id-track-globally t)
  (setq org-id-locations-file (concat org-directory "/.org-id-locations"))
  (push '("b" "Brain" plain (function org-brain-goto-end)
          "* %i%?" :empty-lines 1)
        org-capture-templates)
  (setq org-brain-visualize-default-choices 'all)
  (setq org-brain-title-max-length 12))

(use-package zpresent
  :ensure t)
