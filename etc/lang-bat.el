(use-package bat-mode
  :straight nil
  :config
  (defun pb/bat-template ()
  (interactive)
  (goto-char (point-min)) (insert "@echo off\nsetlocal enableextensions enabledelayedexpansion\n\n")
  (goto-char (point-max)) (insert "\nendlocal")))
