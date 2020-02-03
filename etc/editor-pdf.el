(use-package pdf-tools
  :bind (:map pdf-view-mode-map
              ("h"   . pdf-annot-add-highlight-markup-annotation)
              ("t"   . pdf-annot-add-text-annotation)
              ("D"   . pdf-annot-delete)
              ("C-s" . isearch-forward)
              ("s"   . save-some-buffers))
  :config
  (pdf-tools-install)
  (add-hook 'pdf-view-mode-hook (lambda() (linum-mode -1)))
  (add-hook 'pdf-view-mode-hook (lambda() (cua-mode 0)))
  (setq pdf-view-resize-factor 1.1
        pdf-view-display-size  1.0
        pdf-annot-activate-created-annotations t)

  ;; add function to rotate 90 degrees files
  (defun pdf-view--rotate (&optional counterclockwise-p page-p)
    "Rotate PDF 90 degrees.  Requires pdftk to work.\n
        Clockwise rotation is the default; set COUNTERCLOCKWISE-P to
        non-nil for the other direction.  Rotate the whole document by
        default; set PAGE-P to non-nil to rotate only the current page.
        \nWARNING: overwrites the original file, so be careful!"
    ;; error out when pdftk is not installed
    (if (null (executable-find "pdftk"))
        (error "Rotation requires pdftk")
      ;; only rotate in pdf-view-mode
      (when (eq major-mode 'pdf-view-mode)
        (let* ((rotate (if counterclockwise-p "left" "right"))
               (file   (format "\"%s\"" (pdf-view-buffer-file-name)))
               (page   (pdf-view-current-page))
               (pages  (cond ((not page-p) ; whole doc?
                              (format "1-end%s" rotate))
                             ((= page 1) ; first page?
                              (format "%d%s %d-end"
                                      page rotate (1+ page)))
                             ((= page (pdf-info-number-of-pages)) ; last page?
                              (format "1-%d %d%s"
                                      (1- page) page rotate))
                             (t         ; interior page?
                              (format "1-%d %d%s %d-end"
                                      (1- page) page rotate (1+ page))))))
          ;; empty string if it worked
          (if (string= "" (shell-command-to-string
                           (format (concat "pdftk %s cat %s "
                                           "output %s.NEW "
                                           "&& mv %s.NEW %s")
                                   file pages file file file)))
              (pdf-view-revert-buffer nil t)
            (error "Rotation error!"))))))

  (defun pdf-view-rotate-clockwise (&optional arg)
    "Rotate PDF page 90 degrees clockwise.  With prefix ARG, rotate
     entire document."
    (interactive "P")
    (pdf-view--rotate nil (not arg)))

  (defun pdf-view-rotate-counterclockwise (&optional arg)
    "Rotate PDF page 90 degrees counterclockwise.  With prefix ARG,
     rotate entire document."
    (interactive "P")
    (pdf-view--rotate :counterclockwise (not arg))))
