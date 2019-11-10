(use-package dired
  :ensure nil
  :bind (:map dired-mode-map
        ("M-RET" . dired-do-xdg-open))
  :init
  (use-package dired-x
    :ensure nil)
  :config
  (defun dired-do-xdg-open (&optional arg file-list)
  (interactive)
    (save-window-excursion
      (dired-do-async-shell-command
      "xdg-open" current-prefix-arg
      (dired-get-marked-files t current-prefix-arg))))
  (setq wdired-create-parent-directories   t
        wdired-allow-to-change-permissions t))

(use-package dired-narrow
  :ensure t
  :bind (:map dired-mode-map
              ("/" . dired-narrow)))

(use-package dired-rmjunk
  :ensure t
  :defer t)

(use-package date2name
  :ensure t)

(use-package pack
  :after dired
  :ensure t
  :bind (:map dired-mode-map
        ("P" . pack-dired-dwim)))

(use-package speedbar
  :ensure nil
  :config
  (setq speedbar-use-images         nil
        speedbar-show-unknown-files t))

(use-package sr-speedbar
  :ensure t
  :after speedbar
  :bind ("M-g b" . sr-speedbar-toggle)
  :config
  (setq sr-speedbar-right-side           nil
        sr-speedbar-max-width            40
        sr-speedbar-width                30
        sr-speedbar-default-width        30
        sr-speedbar-skip-other-window-p  t))

(use-package treemacs
  :pin melpa
  :ensure t
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
  :after treemacs projectile
  :pin melpa
  :ensure t)

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
