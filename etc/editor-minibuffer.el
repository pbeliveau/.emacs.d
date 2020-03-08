(use-package counsel
  :diminish
  :demand t
  :bind (("C-*"     . counsel-org-agenda-headlines)
         ("C-x C-f" . counsel-find-file)
         ("M-x"     . counsel-M-x)
         ("C-c e d" . counsel-describe-function)
         ("C-c e f" . counsel-file-jump)
         ("C-c e j" . counsel-dired-jump)
         ("C-c e l" . counsel-find-library)
         ("C-c e q" . counsel-set-variable)
         ("C-c e u" . counsel-unicode-char)
         ("C-x r b" . counsel-bookmark)))

(use-package counsel-web
  :straight (counsel-web :type git
                         :host github
                         :repo "mnewt/counsel-web")
  :config
  (setq counsel-web-search-action #'browse-url))

(use-package ivy
  :diminish
  :demand t
  :bind (("C-x b"   . ivy-switch-buffer)
         ("C-x B"   . ivy-switch-buffer-other-window)
         ("M-H"     . ivy-resume)
         ("C-x C-b" . ibuffer))
  :bind (:map ivy-minibuffer-map
              ("<tab>" . ivy-alt-done)
              ("SPC"   . ivy-alt-done-or-space)
              ("C-d"   . ivy-done-or-delete-char)
              ("C-i"   . ivy-partial-or-done)
              ("C-r"   . ivy-previous-line-or-history)
              ("M-r"   . ivy-reverse-i-search))
  :custom
  (ivy-dynamic-exhibit-delay-ms 200)
  (ivy-height 10)
  (ivy-initial-inputs-alist nil t)
  (ivy-magic-tilde nil)
  (ivy-re-builders-alist '((t . ivy--regex-ignore-order)))
  (ivy-use-virtual-buffers t)
  (ivy-wrap t)

  :preface
  (defun ivy-done-or-delete-char ()
    (interactive)
    (call-interactively
     (if (eolp)
         #'ivy-immediate-done
       #'ivy-delete-char)))

  (defun ivy-alt-done-or-space ()
    (interactive)
    (call-interactively
     (if (= ivy--length 1)
         #'ivy-alt-done
       #'self-insert-command)))

  ;; This is the value of `magit-completing-read-function', so that we see
  ;; Magit's own sorting choices.
  (defun my-ivy-completing-read (&rest args)
    (let ((ivy-sort-functions-alist '((t . nil))))
      (apply 'ivy-completing-read args)))

  :config
  (ivy-mode 1)
  (ivy-set-occur 'ivy-switch-buffer 'ivy-switch-buffer-occur))

(use-package ivy-rich
  :config
  (ivy-rich-mode 1)
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line))

(use-package all-the-icons-ivy-rich
  :straight (all-the-icons-ivy-rich :type git
                                    :host github
                                    :repo "seagle0128/all-the-icons-ivy-rich")
  :init (all-the-icons-ivy-rich-mode 1))

(use-package all-the-icons-ibuffer
  :straight (all-the-icons-ibuffer :type git
                                   :host github
                                   :repo "seagle0128/all-the-icons-ibuffer")
  :init (all-the-icons-ibuffer-mode 1))

  (use-package ivy-prescient
    :after ivy
    :config
    (progn
      (ivy-prescient-mode t)))

(use-package swiper
  :after ivy
  :bind (("C-s"   . swiper)
         ("C-S-s" . swiper-isearch)
         ("M-s"   . swiper-all)
         :map swiper-map
              ("M-y"    . yank)))
