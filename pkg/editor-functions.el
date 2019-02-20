(use-package ts
  :load-path "lisp/"
  :config
  (defun insert-today (&optional arg)
  "Insert today's date.
  A prefix ARG specifies how many days to move;
  negative means previous day.
  If region selected, parse region as today's date pivot."
    (interactive "P")
    (let ((date (if (use-region-p)
                    (ts-parse (buffer-substring-no-properties (region-beginning) (region-end)))
                  (ts-now)))
          (arg (or arg 0)))
      (if (use-region-p)
          (delete-region (region-beginning) (region-end)))
      (insert (ts-format "%A, %B %e, %Y" (ts-adjust 'day arg date))))))

(defun kill-other-buffers ()
  "Kill all buffers but current buffer and special buffers.
(Buffer that start with '*' and white space ignored)"
  (interactive)
  (when (y-or-n-p "Really kill all other buffers ? ")
    (let ((killed-bufs 0))
      (dolist (buffer (delq (current-buffer) (buffer-list)))
        (let ((name (buffer-name buffer)))
          (when (and name (not (string-equal name ""))
                     (/= (aref name 0) ?\s)
                     (string-match "^[^\*]" name))
            (cl-incf killed-bufs)
            (funcall 'kill-buffer buffer))))
      (message "Killed %d buffer(s)" killed-bufs))))

(defun insert-filename-as-heading ()
  "Take current filename (word separated by dash) as heading."
  (interactive)
  (insert
   (capitalize
    (s-join " " (s-split-words (file-name-sans-extension (buffer-name)))))))

(eval-after-load "tramp"
  '(progn
     (defvar sudo-tramp-prefix
       "/sudo::"
       (concat "Prefix to be used by sudo commands when building tramp path "))

     (defun sudo-file-name (filename) (concat sudo-tramp-prefix filename))
     (defun sudo-reopen-file ()
       "Reopen file as root by prefixing its name with sudo-tramp-prefix and by
        clearing buffer-read-only"
       (interactive)
       (let*
           ((file-name (expand-file-name buffer-file-name))
            (sudo-name (sudo-file-name file-name)))
         (progn
           (setq buffer-file-name sudo-name)
           (rename-buffer sudo-name)
           (setq buffer-read-only nil)
           (message (concat "Set file name to " sudo-name)))))

     (global-set-key (kbd "M-g s") 'sudo-reopen-file)))
