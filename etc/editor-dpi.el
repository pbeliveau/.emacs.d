;; From https://emacs.stackexchange.com/questions/28390/quickly-adjusting-text-to-dpi-changes
;; Original author: @gavenkoa

(defun my-dpi ()
  (let* ((attrs (car (display-monitor-attributes-list)))
         (size (assoc 'mm-size attrs))
         (sizex (cadr size))
         (res (cdr (assoc 'geometry attrs)))
         (resx (- (caddr res) (car res)))
         dpi)
    (catch 'exit
      ;; in terminal
      (unless sizex
        (throw 'exit 10))
      ;; on big screen
      (when (> sizex 1000)
        (throw 'exit 10))
      ;; DPI
      (* (/ (float resx) sizex) 25.4))))

(defun my-preferred-font-size ()
  (let ((dpi (my-dpi)))
  (cond
    ((< dpi 110) 11)
    ((< dpi 130) 12)
    ((< dpi 160) 13)
    (t 13))))

(defun triplicate-preferred-font ()
  (let ((font-point (my-preferred-font-size)))
  (cond
    ((< font-point 15) "Triplicate T3c")
    (t "Triplicate T4c"))))

(defvar my-preferred-font-size (my-preferred-font-size))
(defvar my-regular-font (format "%s-%d:weight=normal" (triplicate-preferred-font) my-preferred-font-size))

;; Code and writing
(set-frame-font my-regular-font)
(set-fontset-font nil 'cyrillic my-regular-font)
(set-fontset-font nil 'greek my-regular-font)
(set-fontset-font nil 'phonetic my-regular-font)

;; Emoji: 😄, 🤦, 🏴󠁧󠁢󠁳󠁣󠁴󠁿
(set-fontset-font t 'symbol "Apple Color Emoji")
(set-fontset-font t 'symbol "Noto Emoji" nil 'append)
(set-fontset-font t 'symbol "Segoe UI Emoji" nil 'append)
(set-fontset-font t 'symbol "Symbola" nil 'append)
