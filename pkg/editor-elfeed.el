(use-package elfeed
  :if (not (memq window-system '(w32)))
  :ensure t
  :commands elfeed
  :bind (("C-c 3" . elfeed)
         :map elfeed-search-mode-map
         ("R" . elfeed-mark-all-as-read)
         ("U" . elfeed-update)
         ("A" . pb/elfeed-show-all)
         ("D" . pb/elfeed-show-daily)
         ("E" . pb/elfeed-show-emacs)
         ("T" . pb/elfeed-show-tech)
         ("P" . pb/elfeed-show-pol)
         ("L" . pb/elfeed-show-lang)
         ("O" . pb/elfeed-show-unix))
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
  (defun pb/elfeed-show-politics ()
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
  :custom
  (shr-width 80))

(use-package elfeed-org
  :if (not (memq window-system '(w32)))
  :ensure t
  :after elfeed
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files (list "~/.emacs.d/elfeed.org")))
