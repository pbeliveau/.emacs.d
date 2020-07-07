(use-package elfeed
  :commands elfeed
  :bind (("C-c 3" . elfeed)
         :map elfeed-search-mode-map
         ("R" . elfeed-mark-all-as-read)
         ("I" . elfeed-protocol-ttrss-reinit)
         ("O" . elfeed-protocol-ttrss-update-older)
         ("S" . elfeed-protocol-ttrss-update-star)
         ("U" . elfeed-protocol-ttrss-update)
         ("f" . elfeed-firefox-open)
         ("e" . elfeed-eww-open))
  :init
  (use-package elfeed-protocol
    :config
    (setq elfeed-protocol-ttrss-maxsize 10))
  :config
  (setq-default elfeed-search-filter "@1-week-ago +unread")
  (setq elfeed-use-curl t
        elfeed-protocol-ttrss-maxsize 10
        elfeed-feeds
        '(
          ("ttrss+https://pbeliveau@feed.pbeliveau.ca"
           :use-authinfo t)
          ))

  (defun elfeed-mark-all-as-read ()
    (interactive)
    (mark-whole-buffer)
    (elfeed-search-untag-all-unread))

  ;; From nooker blog.
  (defun elfeed-eww-open (&optional use-generic-p)
    "open with eww"
    (interactive "P")
    (let ((entries (elfeed-search-selected)))
      (cl-loop for entry in entries
               do (elfeed-untag entry 'unread)
               when (elfeed-entry-link entry)
               do (eww-browse-url it))
      (mapc #'elfeed-search-update-entry entries)
      (unless (use-region-p) (forward-line))))

  (defun elfeed-firefox-open (&optional use-generic-p)
    "open with firefox"
    (interactive "P")
    (let ((entries (elfeed-search-selected)))
      (cl-loop for entry in entries
               do (browse-url-firefox (elfeed-entry-link entry)))
      (mapc #'elfeed-search-update-entry entries)
      (unless (use-region-p) (forward-line))))
  (elfeed-protocol-enable)
  :custom
  (shr-width 80))

(use-package elfeed-goodies
  :config
  (elfeed-goodies/setup))

(use-package pocket-reader)
