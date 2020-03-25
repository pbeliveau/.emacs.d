(use-package org
  :demand t
  :straight org-plus-contrib
  :bind (:map org-mode-map
              ("C-c i" . org-add-ids-to-headlines)
              ("C-c s" . org-table-mark-field)
              ("C-c 9" . org-table-yank-cell))
  :bind ("C-C t" . switch-to-org-tasks)
  :hook activate-default-input-method
  :init
  (setq org-directory (concat no-littering-var-directory "org"))
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((ledger . t)))
  (add-to-list
   'org-src-lang-modes '("plantuml" . plantuml))
  :config
  (use-package org-id
    :straight (org-id :local-repo nil))
  (use-package org-checklist
    :straight (org-checklist :local-repo nil))
  (setq fill-column                     80
        org-adapt-indentation           t
        org-hide-leading-stars          t
        org-id-link-to-org-use-id       'create-if-interactive-and-no-custom-id
        org-list-description-max-indent 4
        org-startup-folded              (quote overview)
        org-startup-indented            t
        org-src-tab-acts-natively       t
        org-cycle-separator-lines       0
        org-catch-invisible-edits       'show-and-error
        org-tag-alist                   '(
                                          ("crypt" . ?C))
        org-todo-keywords
        '((sequence "TODO" "STARTED" "RECUR" "PAUSED" "|" "DONE")
          (sequence "REPORT" "BUG" "KNOWNCAUSE" "|" "FIXED")
          (sequence "TODELEGATE" "DELEGATED" "|" "DONE")
          (sequence "TOBLOG" "WRITING" "|" "PUBLISHED")
          (sequence "TOMAIL" "DRAFT" "|" "SENT")
          (sequence "MEETING" "SETMEETING" "CANCELEDMEETING" "|" "DONE")
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
          ("DRAFT" :foreground "steelblue" :weight bold)))
    org-default-notes-file   (concat org-directory "/system/journal.org"))

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
    (find-file (concat org-directory "/system/tasks.org"))
    (switch-to-buffer "tasks.org"))

  (defun org-table-mark-field ()
    "Mark the current table field."
    (interactive)
    ;; Do not try to jump to the beginning of field if the point is already there
    (when (not (looking-back "|[[:blank:]]?"))
      (org-table-beginning-of-field 1))
    (set-mark-command nil)
    (org-table-end-of-field 1))

  (defun org-table-yank-cell ()
    (interactive)
    (org-table-mark-field)
    (easy-kill 1)))

(use-package org-contacts
  :straight nil
  :custom
  (org-contacts-files '(concat org-directory
                               "/system/contacts.org")))

(use-package org-agenda
  :straight nil
  :bind (("C-c a" . org-agenda))
  :after org
  :config
  (setq org-agenda-window-setup         'current-window
        org-agenda-files                (list (concat org-directory
                                            "/system/schedule.org")
                                              (concat org-directory
                                               "/system/tasks.org")
                                              (concat org-directory
                                          "/system/journal.org"))))

(use-package org-super-agenda
  :config
  (let ((org-super-agenda-groups
         '((:auto-category t))))
    (org-agenda-list)))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

(use-package org-download
  :config
  (setq org-download-image-dir         (concat org-directory "/img/")
        org-download-method            'directory
        org-download-screenshot-method "magick convert clipboard: %s")
  (org-download-enable))

(use-package org-pomodoro
  :config
  (setq org-pomodoro-format " %s"
        org-pomodoro-short-break-format "☕%s"
        org-pomodoro-long-break-format  " %s"))

(use-package org-capture
  :straight (org-capture :local-repo nil)
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
      (file+headline "system/tasks.org" "tasks"),
      my/org-task-template
      :empty-lines 1
      :immediate-finish t)
     ("j" "journal" entry
      (function org-journal-find-location),
      my/org-journal-template)
     ("l" "link" entry
      (file+headline "system/notes.org" "links")
           "* %? %^L %^g \n%T"
           :prepend t
           :immediate-finish t)
     ("b" "blog" entry
      (file+headline "system/tasks.org" "tasks")
           "* TOBLOG %?"
           :prepend t)
     ("s" "schedule" entry
      (file "system/schedule.org"),
      my/org-schedule-template)
     ("m" "mail todo" entry
      (file+headline "system/tasks.org" "Mail")
        my/org-mail-template))))

(use-package org-crypt
 :straight (org-crypt :local-repo nil)
 :after org
 :config
 (setq org-crypt-key nil
       org-tags-exclude-from-inheritance (quote ("crypt")))
 :custom
 (org-crypt-use-before-save-magic))

(use-package org-journal
  :after org
  :bind
  ("C-c n j" . org-journal-new-entry)
  ("C-c n y" . org-journal-file-yesterday)
  :init
  (defun get-journal-file-yesterday ()
    "Gets filename for yesterday's journal entry."
    (let* ((yesterday (time-subtract (current-time) (days-to-time 1)))
           (daily-name (format-time-string "%Y-%m-%d.org" yesterday)))
      (expand-file-name (concat org-journal-dir "/"daily-name))))

  (defun org-journal-file-yesterday ()
    "Creates and load a file based on yesterday's date."
    (interactive)
    (find-file (get-journal-file-yesterday)))
  :config
  (setq org-journal-date-format               "%A, %d %B %Y"
        org-journal-date-prefix               "#+TITLE: "
        org-journal-dir                       (concat org-directory "/records")
        org-journal-file-header               "#+SETUPFILE: ../system/config.org"
        org-journal-enable-agenda-integration t
        org-journal-enable-encryption         nil
        org-journal-encrypt-journal           nil
        org-journal-file-format               "%Y-%m-%d.org"
        org-journal-time-format               ""))

(use-package helm-org-rifle)

(use-package ox-word
  :after (:all org-ref ox)
  :demand t
  :straight (ox-word :type git
                     :host github
                     :repo "jkitchin/scimax"
                     :files ("ox-word.el")))

(use-package org-graph-view
  :straight (org-graph-view :type git
                            :host github
                            :repo "alphapapa/org-graph-view"))

(use-package ox-hugo
  :after ox
  :config
  (setq org-hugo-default-section-directory "posts"
        org-hugo-export-with-toc           nil))

(use-package org-index)
(use-package org-ql)
(use-package org-sidebar)
(use-package org-brain
  :init
  (setq org-brain-path (concat org-directory "/records"))
  :config
  (setq org-id-track-globally t)
  (setq org-id-locations-file (concat org-directory "/.org-id-locations"))
  (push '("b" "Brain" plain (function org-brain-goto-end)
          "* %i%?" :empty-lines 1)
        org-capture-templates)
  (setq org-brain-visualize-default-choices 'all)
  (setq org-brain-title-max-length 12))

(use-package deft
  :after org
  :bind
  ("C-c n d" . deft)
  :custom
  (deft-directory org-directory)
  (deft-recursive t)
  (deft-use-filename-as-title t)
  (deft-use-filter-string-for-filename t)
  (deft-default-extension '("org" "txt" "text" "md" "markdown" "org.gpg"))
  (deft-default-extension "org"))

(use-package org-roam
  :after org
  :hook ((org-mode   . org-roam-mode)
         (after-init . org-roam--build-cache-async))
  :straight (:type git
             :host github
             :repo "jethrokuan/org-roam")
  :bind
  ("C-c n b" . org-roam-switch-to-buffer)
  ("C-c n f" . org-roam-find-file)
  ("C-c n g" . org-roam-show-graph)
  ("C-c n i" . org-roam-insert)
  ("C-c n l" . org-roam)
  ("C-c n t" . org-roam-today)
  :init
  (setq org-roam-directory (concat org-directory "/records")
        org-roam-completion-system 'ivy
        org-roam-mute-cache-build t
        org-roam-graph-viewer (executable-find "imv")))

(use-package portable-org-screenshot
    :straight (portable-org-screenshot :type git
                                       :host github
                                       :repo "pbeliveau/portable-org-screenshot")
    :bind ("C-c 6" . portable-org-screenshot))

(use-package zpresent)
