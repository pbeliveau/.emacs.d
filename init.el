;; bootstrap package and use-package
(require 'package)
(setq package-user-dir "~/.emacs.d/var/elpa")
(setq package-gnupghome-dir "~/.emacs.d/var/elpa/gnupg")
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")))
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(setq use-package-always-ensure t)
;; async compilation
(use-package async
  :demand t
  :config
  (async-bytecomp-package-mode 1))

;; make use of standard directories
(use-package no-littering
  :demand t
  :config
  (require 'recentf)
  (add-to-list 'recentf-exclude no-littering-var-directory)
  (add-to-list 'recentf-exclude no-littering-etc-directory)
  (setq auto-save-file-name-transforms
        `((".*" ,(no-littering-expand-var-file-name "auto-save/") t))
        custom-file (no-littering-expand-var-file-name "custom.el")))

;; to add advice and suppress messsages
;; of certain functions
(use-package silence
  :load-path "var/lisp")

;; package.el frontend
(use-package paradox
  :init
  (load (concat no-littering-var-directory "private/.github") nil t)
  (setq paradox-github-token paradox-token)
  :config
  (advice-add 'paradox-enable :around #'silence)
  (paradox-enable)
  :config
  (setq paradox-execute-asynchronously t
        paradox-automatically-star "No"))

;; quelpa with quelpa-use-package
;; for packages outside of package archives
(use-package quelpa
  :init
  (setq quelpa-dir "~/.emacs.d/var/quelpa"
        quelpa-update-melpa-p nil)
  (advice-add 'quelpa-build :around #'silence))

(use-package quelpa-use-package
  :after quelpa
  :config
  (quelpa-use-package-activate-advice))

;; benchmarking init.el
(use-package benchmark-init
  :config
  (add-hook 'after-init-hook 'benchmark-init/deactivate))

;; dependencies

(use-package bind-key   :demand t)
(use-package blackout   :demand t)
(use-package dash       :demand t)
(use-package epl        :demand t)
(use-package f          :demand t)
(use-package ht         :demand t)
(use-package pkg-info   :demand t)
(use-package queue      :demand t)
(use-package request    :demand t)
(use-package s          :demand t)

;; add bindings to reach init file
(use-package iqa
  :config
  (iqa-setup-default))

;; variables to remove compile-log warnings
(defvar ido-cur-item nil)
(defvar ido-default-item nil)
(defvar ido-cur-list nil)
(setq delete-old-versions t)

;; packages in etc
(let ((loaded (mapcar #'file-name-sans-extension (delq nil (mapcar #'car load-history)))))
  (dolist (file (directory-files (concat user-emacs-directory "etc") t ".+\\.elc?$"))
    (let ((library (file-name-sans-extension file)))
      (unless (member library loaded)
        (load library nil t)
        (push library loaded)))))
