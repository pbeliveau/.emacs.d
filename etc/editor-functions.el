(use-package ts
  :demand
  :quelpa t
  :bind (("C-c 7" . insert-timestamp)
         ("C-c 8" . insert-today))
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
      (insert (ts-format "%A, %B %e, %Y" (ts-adjust 'day arg date)))))

  (defun insert-timestamp ()
    (interactive)
    (insert (ts-format (ts-now)))))

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

(defun xah-run-current-file ()
  "Execute the current file.
For example, if the current buffer is x.py, then it'll call 「python x.py」 in a shell.
Output is printed to buffer “*xah-run output*”.

The file can be Emacs Lisp, PHP, Perl, Python, Ruby, JavaScript, TypeScript, golang, Bash, Ocaml, Visual Basic, TeX, Java, Clojure.
File suffix is used to determine what program to run.

If the file is modified or not saved, save it automatically before run.

URL `http://ergoemacs.org/emacs/elisp_run_current_file.html'
Version 2018-10-12"
  (interactive)
  (let (
        ($outputb "*xah-run output*")
        (resize-mini-windows nil)
        ($suffix-map
         ;; (‹extension› . ‹shell program name›)
         `(
           ("clj"   . "java -cp ~/apps/clojure-1.6.0/clojure-1.6.0.jar clojure.main")
           ("go"    . "go run")
           ("hs"    . "runhaskell")
           ("java"  . "javac")
           ("js"    . "node")
           ("latex" . "pdflatex")
           ("mjs"   . "node --experimental-modules ")
           ("ml"    . "ocaml")
           ("php"   . "php")
           ("pl"    . "perl")
           ("ps1"   . "pwsh.exe")
           ("py"    . "python")
           ("py3"   . ,(if (string-equal system-type "windows-nt") "c:/Python32/python.exe" "python3"))
           ("rb"    . "ruby")
           ("rkt"   . "racket")
           ("sh"    . "bash")
           ("tex"   . "pdflatex")
           ("ts"    . "tsc") ; TypeScript
           ("tsx"   . "tsc")
           ("vbs"   . "cscript")
           ))
        $fname
        $fSuffix
        $prog-name
        $cmd-str)
    (when (not (buffer-file-name)) (save-buffer))
    (when (buffer-modified-p) (save-buffer))
    (setq $fname (buffer-file-name))
    (setq $fSuffix (file-name-extension $fname))
    (setq $prog-name (cdr (assoc $fSuffix $suffix-map)))
    (setq $cmd-str (concat $prog-name " \""   $fname "\" &"))
    (run-hooks 'xah-run-current-file-before-hook)
    (cond
     ((string-equal $fSuffix "el")
      (load $fname))
     ((or (string-equal $fSuffix "ts") (string-equal $fSuffix "tsx"))
      (if (fboundp 'xah-ts-compile-file)
          (progn
            (xah-ts-compile-file current-prefix-arg))
        (if $prog-name
            (progn
              (message "Running")
              (shell-command $cmd-str $outputb ))
          (error "No recognized program file suffix for this file."))))
     ((string-equal $fSuffix "go")
      (xah-run-current-go-file))
     ((string-equal $fSuffix "java")
      (progn
        (shell-command (format "java %s" (file-name-sans-extension (file-name-nondirectory $fname))) $outputb )))
     (t (if $prog-name
            (progn
              (message "Running")
              (shell-command $cmd-str $outputb ))
          (error "No recognized program file suffix for this file."))))
    (run-hooks 'xah-run-current-file-after-hook)))

(defun img-to-clipboard (filename)
  (interactive "sFile path:")
  (shell-command (concat "nircmdc.exe clipboard copyimage " "'" filename "'")))
