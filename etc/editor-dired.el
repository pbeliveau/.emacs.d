(use-package dired
  :straight (dired :type built-in)
  :init
  (use-package dired-x
    :straight (dired :type built-in))
  :config
  (setq wdired-create-parent-directories   t
        wdired-allow-to-change-permissions t)
  (add-hook 'dired-mode-hook
            (lambda ()
                   (setq truncate-lines nil))))

(use-package dired-avfs
  :straight (dired-avfs :type git
                        :host github
                        :repo "Fuco1/dired-hacks"
                        :files ("dired-avfs.el")))

(use-package dired-collapse
  :hook (dired-mode . dired-collapse-mode)
  :straight (dired-collapse :type git
                            :host github
                            :repo "Fuco1/dired-hacks"
                            :files ("dired-collapse.el"))
  :bind (:map dired-mode-map
              ("," . dired-collapse-mode)))

(use-package dired-open
  :straight (dired-open :type git
                        :host github
                        :repo "Fuco1/dired-hacks"
                        :files ("dired-open.el"))
  :bind (:map dired-mode-map
        ("M-RET" . dired-open-xdg))
  :init
  (if (memq window-system '(w32))
      (setq open-extensions
            '(("webm"  . "mpv")
              ("avi"   . "mpv")
              ("mp4"   . "mpv")
              ("mkv"   . "mpv")
              ("ogv"   . "mpv")
              ("mp3"   . "mpv")
              ("png"   . "nomacs")
              ("jpeg"  . "nomacs")
              ("jpg"   . "nomacs")
              ("pdf"   . "sumatrapdf")
              ("xlsx"  . "Microsoft Excel")
              ("xlsm"  . "Microsoft Excel")
              ("xlsb"  . "Microsoft Excel")
              ("xls"   . "Microsoft Excel")
              ("docx"  . "Microsoft Word")
              ("doc"   . "Microsoft Word")))
    (setq open-extensions
            '(("docx" . "libreoffice")
              ("doc"  . "libreoffice")
              ("xlsx" . "libreoffice")
              ("xls"  . "libreoffice"))))
  :config
  (setq dired-open-extensions open-extensions))

(use-package dired-hacks-utils
  :straight t)

(use-package dired-filter
  :straight (dired-filter :type git
                          :host github
                          :repo "Fuco1/dired-hacks"
                          :files ("dired-filter.el"))
  :bind (:map dired-mode-map
              ("f" . dired-filter-mode))
  :init
  (add-hook 'dired-mode-hook 'dired-filter-mode))

(use-package dired-narrow
  :straight (dired-narrow :type git
                          :host github
                          :repo "Fuco1/dired-hacks"
                          :files ("dired-narrow.el")))

(use-package dired-ranger
  :straight (dired-ranger :type git
                          :host github
                          :repo "Fuco1/dired-hacks"
                          :files ("dired-ranger.el"))
  :bind (:map dired-mode-map
              ("W" . dired-ranger-copy)
              ("X" . dired-ranger-move)
              ("Y" . dired-ranger-paste)))

(use-package dired-subtree
  :straight (dired-subtree :type git
                           :host github
                           :repo "Fuco1/dired-hacks"
                           :files ("dired-subtree.el"))
  :bind (:map dired-mode-map
              ("TAB" . dired-subtree-cycle)
              ("i" . dired-subtree-insert)
              ("C-x n n" . dired-subtree-narrow)))

(use-package dired-narrow
  :bind (:map dired-mode-map
              ("/" . dired-narrow)))

(use-package dired-rmjunk)
(use-package date2name
  :bind (:map dired-mode-map
              ("z" . date2name-dired-add-date-to-name)
              ("b" . date2name-dired-add-datetime-to-name)))


(use-package fd-dired)
(use-package helm-fd
  :bind (:map helm-command-map
              ("/" . helm-fd)))

(use-package pack
  :after dired
  :bind (:map dired-mode-map
        ("P" . pack-dired-dwim)))

(use-package speedbar
  :config
  (setq speedbar-use-images         nil
        speedbar-show-unknown-files t))

(use-package sr-speedbar
  :after speedbar
  :bind ("M-g b" . sr-speedbar-toggle)
  :config
  (setq sr-speedbar-right-side           nil
        sr-speedbar-max-width            40
        sr-speedbar-width                30
        sr-speedbar-default-width        30
        sr-speedbar-skip-other-window-p  t))

(use-package treemacs
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs              (if (executable-find "python") 3 0)
          treemacs-deferred-git-apply-delay   0.5
          treemacs-display-in-side-window     t
          treemacs-file-event-delay           5000
          treemacs-file-follow-delay          0.2
          treemacs-follow-after-init          t
          treemacs-follow-recenter-distance   0.1
          treemacs-goto-tag-strategy          'refetch-index
          treemacs-indentation                2
          treemacs-indentation-string         " "
          treemacs-is-never-other-window      nil
          treemacs-max-git-entries            5000
          treemacs-no-png-images              nil
          treemacs-project-follow-cleanup     nil
          treemacs-recenter-after-file-follow nil
          treemacs-recenter-after-tag-follow  nil
          treemacs-show-cursor                nil
          treemacs-show-hidden-files          t
          treemacs-silent-filewatch           nil
          treemacs-silent-refresh             nil
          treemacs-sorting                    'alphabetic-desc
          treemacs-space-between-root-nodes   t
          treemacs-tag-follow-cleanup         t
          treemacs-tag-follow-delay           1.5
          treemacs-width                      25)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null (executable-find "python3"))))
      (`(t . t)
       (treemacs-git-mode 'extended))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-projectile
  :after treemacs projectile)

(defun copy-file-path (&optional @dir-path-only-p)
  "Copy the current buffer's file path or dired path to `kill-ring'."
  (interactive "P")
  (let (($fpath
         (if (string-equal major-mode 'dired-mode)
             (progn
               (let (($result (mapconcat 'identity (dired-get-marked-files) "\n")))
                 (if (equal (length $result) 0)
                     (progn default-directory )
                   (progn $result))))
           (if (buffer-file-name)
               (buffer-file-name)
             (expand-file-name default-directory)))))
    (kill-new
     (if @dir-path-only-p
         (progn
           (message "Directory path copied: 「%s」" (file-name-directory $fpath))
           (file-name-directory $fpath))
       (progn
         (message "File path copied: 「%s」" $fpath)
         $fpath )))))
