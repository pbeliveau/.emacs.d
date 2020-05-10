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
    ((< dpi 110) 10)
    ((< dpi 130) 11)
    ((< dpi 160) 12)
    (t 13))))

(defun triplicate-preferred-font ()
  (let ((font-point (my-preferred-font-size)))
  (cond
    ((< font-point 15) "Triplicate T3c")
    (t "Triplicate T4c"))))

(defvar my-preferred-font-size (my-preferred-font-size))
(defvar my-regular-font (format "%s-%d:weight=normal" (triplicate-preferred-font) my-preferred-font-size))

;; Function to force font settings when using emacsclient
(defun setup-fonts (&rest frame)
  (if window-system
      (let ((f (if (car frame)
		   (car frame)
		 (selected-frame))))
	(progn
          ;; Code and writing
          (set-frame-font my-regular-font t t)
          (set-fontset-font t 'cyrillic my-regular-font nil)
          (set-fontset-font t 'greek my-regular-font nil)
          (set-fontset-font t 'phonetic my-regular-font nil)

          ;; Emoji and icons: 😄, 🤦, 🏴󠁧󠁢󠁳󠁣󠁴󠁿
          (set-fontset-font t 'symbol "Apple Color Emoji" nil)
          (set-fontset-font t 'symbol "Noto Emoji" nil 'append)
          (set-fontset-font t 'symbol "Segoe UI Emoji" nil 'append)
          (set-fontset-font t 'symbol "Symbola" nil 'append)
          (set-fontset-font t 'unicode "FontAwesome" nil 'append)
          (set-fontset-font t 'unicode "Material Icons" nil 'append)
          (set-fontset-font t 'unicode "Weather Icons" nil 'append)
          (set-fontset-font t 'unicode "all-the-icons" nil 'append)
          (set-fontset-font t 'unicode "file-icons" nil 'append)
          (set-fontset-font t 'unicode "github-octicons" nil 'append)))))

;; Hooks
(defadvice server-create-window-system-frame
  (after set-window-system-frame-colours ())
  "Set custom frame colours when creating the first frame on a display"
  (message "Running after frame-initialize")
  (setup-fonts))
(ad-activate 'server-create-window-system-frame)
(add-hook 'after-make-frame-functions 'setup-fonts t)

;; Run at start
(setup-fonts)
