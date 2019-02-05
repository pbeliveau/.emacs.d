;; package repositories
(require 'package)
(setq package-enable-at-startup nil
      package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/"))
      package-pinned-packages
            '((bind-key    . "melpa")
              (diminish    . "melpa")
              (use-package . "melpa")))
(package-initialize)

;; use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package)
  (setq use-package-expand-minimally byte-compile-current-file))

(setq use-package-always-ensure t)

;; dependencies
(use-package async                             :pin melpa)
(use-package dash                              :pin melpa)
(use-package ht                                :pin melpa)
(use-package s                                 :pin melpa)
(use-package f                                 :pin melpa)
(use-package queue                             :pin gnu)
(use-package epl                               :pin melpa)
(use-package pkg-info                          :pin melpa)
(use-package use-package-ensure-system-package
  :pin melpa
  :if (not (memq window-system '(w32))))

;; variables to remove compile-log warnings
(defvar ido-cur-item nil)
(defvar ido-default-item nil)
(defvar ido-cur-list nil)

;; packages
(async-bytecomp-package-mode 1)
(let ((loaded (mapcar #'file-name-sans-extension (delq nil (mapcar #'car load-history)))))
  (dolist (file (directory-files "~/.emacs.d/pkg" t ".+\\.elc?$"))
    (let ((library (file-name-sans-extension file)))
      (unless (member library loaded)
        (load library nil t)
        (push library loaded)))))

;; custom
(setq custom-file (make-temp-file "emacs-custom"))
(if (file-exists-p custom-file)
    (load (file-name-sans-extension custom-file)))
