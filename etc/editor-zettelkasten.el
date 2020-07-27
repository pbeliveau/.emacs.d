(use-package deft
  :blackout
  :after org
  :bind
  ("C-c n d" . deft)
  :custom
  (deft-directory (concat org-directory "/records"))
  (deft-recursive t)
  (deft-use-filename-as-title t)
  (deft-use-filter-string-for-filename t)
  (deft-default-extension '("org" "txt" "text" "md" "markdown" "org.gpg"))
  (deft-default-extension "org"))

(use-package zetteldeft
  :blackout
  :after deft
  :config
    (zetteldeft-set-classic-keybindings)
    (org-link-set-parameters
     "zdlink"
     :follow (lambda (str) (zetteldeft--search-filename (zetteldeft--lift-id str)))
     :complete 'efls/zd-complete-link
     :help-echo "Searches provided ID in Zetteldeft")

    (defun efls/zd-complete-link ()
      "Link completion for `tslink' type links"
      (let* ((file (completing-read "File to link to: "
                                    (deft-find-all-files-no-prefix)))
             (link (zetteldeft--lift-id file)))
        (unless link (user-error "No file selected"))
        (concat "zdlink:" link))))

(use-package org-roam
  :blackout
  :hook
  (after-init . org-roam-mode)
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
        org-roam-mute-cache-build t))

(use-package org-brain
  :blackout
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

(use-package org-index)
