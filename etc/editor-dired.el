(use-package dired
  :ensure nil
  :bind (("C-c j f" . jump-to-start)
         ("C-c j o" . jump-to-org)
         ("C-c j s" . jump-to-scripts))
  :init
  (use-package dired-x
    :ensure nil)
  (use-package all-the-icons-dired)
  :config
  (setq wdired-create-parent-directories        t
        wdired-allow-to-change-permissions      t
        dired-listing-switches                  "-alh")
  (defun jump-to-start ()
    (interactive)
    (dired "~/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"))
  (defun jump-to-scripts ()
    (interactive)
    (dired "~/.config/scripts"))
  (defun jump-to-org ()
    (interactive)
    (dired "~/.config/org/"))
  (add-hook 'dired-mode-hook
            (lambda ()
              (setq truncate-lines nil)
              (dired-sort-toggle-or-edit))))

(use-package dired-sort-menu
  :defer t
  :quelpa (dired-sort-menu
           :fetcher github
           :repo "emacsmirror/dired-sort-menu"))

(use-package dired-sort-menu+
  :defer t
  :quelpa (dired-sort-menu+
           :fetcher github
           :repo "emacsmirror/dired-sort-menu-plus"))

(use-package dired-async
  :ensure nil
  :after (dired)
  :hook (dired-mode . dired-async-mode))

(use-package dired-avfs :quelpa t)

(use-package dired-collapse
  :hook (dired-mode . dired-collapse-mode)
  :quelpa t
  :bind (:map dired-mode-map
              ("," . dired-collapse-mode)))

(use-package dired-filter
  :quelpa t
  :bind (:map dired-mode-map
              ("f" . dired-filter-mode))
  :init
  (add-hook 'dired-mode-hook 'dired-filter-mode))

(use-package dired-hacks-utils :ensure nil)

(use-package dired-k
  :after dired
  :bind (:map dired-mode-map
              ("M-k" . dired-k))
  :hook ((dired-initial-position-hook . dired-k)
         (dired-after-readin-hook . dired-k-no-revert))
  :config
  (setq dired-k-style 'git))

(use-package dired-narrow :quelpa t)

(use-package dired-ranger
  :quelpa t
  :bind (:map dired-mode-map
              ("W" . dired-ranger-copy)
              ("X" . dired-ranger-move)
              ("Y" . dired-ranger-paste)))

(use-package dired-subtree
  :quelpa t
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


(use-package counsel-fd)
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

(use-package w32-browser
  :bind
  ("C-c w e" . w32explore)
  ("C-c w b" . w32-browser)
  (:map dired-mode-map
        ("M-RET" . dired-w32-browser)
        ("<C-return>" . dired-w32explore)))

(use-package w32-symlinks
  :quelpa (w32-symlinks
           :fetcher github
           :repo "emacsmirror/w32-symlinks"))

;; Function from http://xenodium.com/enrich-your-dired-batching-toolbox/index.html
;;; -*- lexical-binding: t; -*-
(defun ar/dired-convert-image (&optional arg)
  "Convert image files to other formats."
  (interactive "P")
  (assert (or (executable-find "convert") (executable-find "magick.exe")) nil "Install imagemagick")
  (let* ((dst-fpath)
         (src-fpath)
         (src-ext)
         (last-ext)
         (dst-ext))
    (mapc
     (lambda (fpath)
       (setq src-fpath fpath)
       (setq src-ext (downcase (file-name-extension src-fpath)))
       (when (or (null dst-ext)
                 (not (string-equal dst-ext last-ext)))
         (setq dst-ext (completing-read "to format: "
                                        (seq-remove (lambda (format)
                                                      (string-equal format src-ext))
                                                    '("jpg" "png")))))
       (setq last-ext dst-ext)
       (setq dst-fpath (format "%s.%s" (file-name-sans-extension src-fpath) dst-ext))
       (message "convert %s to %s ..." (file-name-nondirectory dst-fpath) dst-ext)
       (set-process-sentinel
        (if (string-equal system-type "windows-nt")
            (start-process "convert"
                           (generate-new-buffer (format "*convert %s*" (file-name-nondirectory src-fpath)))
                           "magick.exe" "convert" src-fpath dst-fpath)
          (start-process "convert"
                         (generate-new-buffer (format "*convert %s*" (file-name-nondirectory src-fpath)))
                         "convert" src-fpath dst-fpath))
        (lambda (process state)
          (if (= (process-exit-status process) 0)
              (message "converted ✔")
            (message "converted ❌")
            (message (with-current-buffer (process-buffer process)
                       (buffer-string))))
          (kill-buffer (process-buffer process)))))
     (dired-map-over-marks (dired-get-filename) arg))))
