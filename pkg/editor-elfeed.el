(use-package elfeed
  :ensure   t
  :commands elfeed
  :bind (("C-x w" . elfeed)
         :map elfeed-search-mode-map
                ("R" . elfeed-mark-all-as-read)
                ("U" . elfeed-update)
                ("A" . bjm/elfeed-show-all)
                ("D" . bjm/elfeed-show-daily)
                ("E" . bjm/elfeed-show-emacs)
                ("T" . bjm/elfeed-show-tech)
                ("P" . bjm/elfeed-show-pol)
                ("L" . bjm/elfeed-show-lang)
                ("O" . bjm/elfeed-show-unix))
  :config
  (setq-default elfeed-search-filter "@1-week-ago +unread")
  (defun elfeed-mark-all-as-read ()
      (interactive)
      (mark-whole-buffer)
      (elfeed-search-untag-all-unread))
  (defun bjm/elfeed-show-all ()
    (interactive)
    (bookmark-maybe-load-default-file)
    (bookmark-jump "elfeed-all"))
  (defun bjm/elfeed-show-daily ()
    (interactive)
    (bookmark-maybe-load-default-file)
    (bookmark-jump "elfeed-daily"))
  (defun bjm/elfeed-show-emacs ()
    (interactive)
    (bookmark-maybe-load-default-file)
    (bookmark-jump "elfeed-emacs"))
  (defun bjm/elfeed-show-tech ()
    (interactive)
    (bookmark-maybe-load-default-file)
    (bookmark-jump "elfeed-tech"))
  (defun bjm/elfeed-show-politics ()
    (interactive)
    (bookmark-maybe-load-default-file)
    (bookmark-jump "elfeed-politics"))
  (defun bjm/elfeed-show-lang ()
    (interactive)
    (bookmark-maybe-load-default-file)
    (bookmark-jump "elfeed-lang"))
  (defun bjm/elfeed-show-unix ()
    (interactive)
    (bookmark-maybe-load-default-file)
    (bookmark-jump "elfeed-unix"))
  :custom
  (shr-width 80))

(use-package elfeed-org
  :ensure t
  :after elfeed
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files (list "~/.emacs.d/elfeed.org")))
