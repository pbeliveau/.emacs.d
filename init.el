;; straight.el + use-package

(setq load-prefer-newer t
      straight-base-dir (concat user-emacs-directory "var/")
      straight-repository-branch "develop"
      straight-check-for-modifications '(find-when-checking)
      straight-use-package-by-default t
      straight-cache-autoloads t
      straight-treat-as-init t
      ;; use-package-always-defer t
      use-package-expand-minimally t
      use-package-verbose nil)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" (concat user-emacs-directory "var/")))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

(use-package benchmark-init
  :config
  (add-hook 'after-init-hook 'benchmark-init/deactivate))

;; dependencies
(use-package diminish   :demand t)
(use-package async      :demand t)
(use-package dash       :demand t)
(use-package ht         :demand t)
(use-package s          :demand t)
(use-package f          :demand t)
(use-package queue      :demand t)
(use-package epl        :demand t)
(use-package pkg-info   :demand t)

;; make use of standard directories
(use-package no-littering
  :demand t)

; Package management, unix systems only.
(use-package use-package-ensure-system-package
  :if (not (memq window-system '(w32)))
  :demand t)

;; variables to remove compile-log warnings
(defvar ido-cur-item nil)
(defvar ido-default-item nil)
(defvar ido-cur-list nil)

;; packages in etc
(async-bytecomp-package-mode 1)
(let ((loaded (mapcar #'file-name-sans-extension (delq nil (mapcar #'car load-history)))))
  (dolist (file (directory-files (concat user-emacs-directory "etc") t ".+\\.elc?$"))
    (let ((library (file-name-sans-extension file)))
      (unless (member library loaded)
        (load library nil t)
        (push library loaded)))))

;; custom
(setq custom-file (make-temp-file "emacs-custom"))
(if (file-exists-p custom-file)
    (load (file-name-sans-extension custom-file)))

;; Started
(if (string-equal system-type "gnu/linux")
    (shell-command "notify-send 'Emacs Loaded'"))
