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

(use-package org-taskforecast
  :config
  (setq org-taskforecast-dailylist-file (concat org-directory
                                                "/system"
                                                "/taskforecast"
                                                "/%Y-%m-%d.org")))

(use-package org-superstar
  :hook (org-mode . org-superstar-mode))

(use-package org-num-mode
  :straight nil
  :hook (org-mode . org-num-mode))

(use-package ox-latex
  :straight nil
  :demand t
  :config
  (setq org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f")))

(use-package helm-bibtex
  :disabled
  :straight (helm-bibtex :type git
                         :host github
                         :repo "tmalsburg/helm-bibtex"))

(use-package bibtex-completion
  :disabled
  :straight (bibtex-completion :type git
                               :host github
                               :repo "tmalsburg/helm-bibtex"
                               :files ("bibtex-completion.el")))

(use-package org-ref
  :disabled
  :after org
  :config
  (setq org-ref-default-bibliography '("~/.emacs.d/var/org/data/refs.bib")
        org-ref-pdf-directory (concat org-directory "/prints/")
        doi-utils-toggle-pdf-download t))

(use-package org-download
  :config
  (setq org-download-image-dir         (concat org-directory "/img/")
        org-download-method            'directory
        org-download-edit-cmd          "nomacs.exe %s"
        org-download-screenshot-method "magick convert clipboard: %s")
  (org-download-enable))

(use-package org-pomodoro
  :config
  (setq org-pomodoro-format " %s"
        org-pomodoro-short-break-format "☕%s"
        org-pomodoro-long-break-format  " %s"))

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

(use-package org-chef)
(use-package org-ql)
(use-package org-sidebar)

(use-package org-spacer
  :straight (org-spacer :type git
                        :host github
                        :repo "dustinlacewell/org-spacer.el")
  :config
  (setq org-spacer-element-blanks
          '((0 headline plain-list)
            (1 src-block table property-drawer)))
  (add-hook 'org-mode-hook
            (lambda () (add-hook 'before-save-hook
                                 'org-spacer-enforce nil 'make-it-local))))

(use-package portable-org-screenshot
    :straight (portable-org-screenshot :type git
                                       :host github
                                       :repo "pbeliveau/portable-org-screenshot")
    :bind ("C-c 6" . portable-org-screenshot))

(use-package zpresent)
(use-package org-kanban)
(use-package org-make-toc)
