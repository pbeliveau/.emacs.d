(use-package elfeed
  :commands elfeed
  :bind (("C-c 3" . elfeed)
         :map elfeed-search-mode-map
         ("A" . pb/elfeed-show-all)
         ("B" . pb/elfeed-show-blog)
         ("D" . pb/elfeed-show-daily)
         ("E" . pb/elfeed-show-emacs)
         ("L" . pb/elfeed-show-lang)
         ("O" . pb/elfeed-show-unix)
         ("P" . pb/elfeed-show-pol)
         ("R" . elfeed-mark-all-as-read)
         ("T" . pb/elfeed-show-tech)
         ("U" . elfeed-update))
  :config
  (setq-default elfeed-search-filter "@1-week-ago +unread")
  (defun elfeed-mark-all-as-read ()
    (interactive)
    (mark-whole-buffer)
    (elfeed-search-untag-all-unread))
  (defun pb/elfeed-show-all ()
    (interactive)
    (bookmark-maybe-load-default-file)
    (bookmark-jump "elfeed-all"))
  (defun pb/elfeed-show-daily ()
    (interactive)
    (bookmark-maybe-load-default-file)
    (bookmark-jump "elfeed-daily"))
  (defun pb/elfeed-show-emacs ()
    (interactive)
    (bookmark-maybe-load-default-file)
    (bookmark-jump "elfeed-emacs"))
  (defun pb/elfeed-show-tech ()
    (interactive)
    (bookmark-maybe-load-default-file)
    (bookmark-jump "elfeed-tech"))
  (defun pb/elfeed-show-pol ()
    (interactive)
    (bookmark-maybe-load-default-file)
    (bookmark-jump "elfeed-politics"))
  (defun pb/elfeed-show-lang ()
    (interactive)
    (bookmark-maybe-load-default-file)
    (bookmark-jump "elfeed-lang"))
  (defun pb/elfeed-show-unix ()
    (interactive)
    (bookmark-maybe-load-default-file)
    (bookmark-jump "elfeed-unix"))
  (defun pb/elfeed-show-blog ()
    (interactive)
    (bookmark-maybe-load-default-file)
    (bookmark-jump "elfeed-blog"))

  ;; From ieure config
  (defun ime-elfeed-podcast-tagger (entry)
    (when (elfeed-entry-enclosures entry)
      (elfeed-tag entry 'podcast)))
  (add-hook 'elfeed-new-entry-hook #'ime-elfeed-podcast-tagger)

  :custom
  (shr-width 80))

(use-package elfeed-org
  :after elfeed
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files (list (concat no-littering-var-directory
                                           "/elfeed/elfeed.org"))))

(use-package elfeed-goodies
  :config
  (elfeed-goodies/setup))

(use-package pocket-reader)
