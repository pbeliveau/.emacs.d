(use-package ts
  :disabled
  :load-path "var/lisp/"
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

(defun insdate-insert-current-date (&optional omit-day-of-week-p)
  "Insert today's date using the current locale.
With a prefix argument, the date is inserted without the day of
the week."
  (interactive "P*")
  (insert (calendar-date-string (calendar-current-date) nil
                                omit-day-of-week-p)))

(defun timestamp ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d %H:%M:%S")))

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

(defcustom desktop-powersettings "sh ~/dotfiles/scripts/powersaving"
  "Scripts with custom settings regarding screen and others."
  :type 'string)

(defun call-powersettings ()
  (interactive)
  (shell-command-to-string desktop-powersettings)
  (message "Called powersaving settings."))

(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))
(global-set-key (kbd "C-;") 'toggle-comment-on-line)

;; use 2 spaces for tabs
(defun die-tabs ()
  (interactive)
  (set-variable 'tab-width 2)
  (mark-whole-buffer)
  (untabify (region-beginning) (region-end))
  (keyboard-quit))

;; Enable narrow region and function to
;; make use of it with clone.
(put 'narrow-to-region 'disabled nil)
(defun narrow-to-region-indirect (start end)
  "Restrict editing in this buffer to the current region, indirectly."
  (interactive "r")
  (deactivate-mark)
  (let ((buf (clone-indirect-buffer nil nil)))
    (with-current-buffer buf
      (narrow-to-region start end))
      (switch-to-buffer buf)))
(bind-key "C-x n i" 'narrow-to-region-indirect)
