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
