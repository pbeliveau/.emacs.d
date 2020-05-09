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
  (let ( (dpi (my-dpi)) )
  (cond
    ((< dpi 110) 10)
    ((< dpi 130) 11)
    ((< dpi 160) 12)
    (t 12))))

(defvar my-preferred-font-size (my-preferred-font-size))

(defvar my-regular-font
  (cond
   ((eq window-system 'x) (format "DejaVu Sans Mono-%d:weight=normal" my-preferred-font-size))
   ((eq window-system 'w32) (format "Consolas-%d:weight=normal" my-preferred-font-size))))
(defvar my-symbol-font
  (cond
   ((eq window-system 'x) (format "DejaVu Sans Mono-%d:weight=normal" my-preferred-font-size))
   ((eq window-system 'w32) (format "DejaVu Sans Mono-%d:antialias=none" my-preferred-font-size))))

(cond
 ((eq window-system 'x)
  (if (and (fboundp 'find-font) (find-font (font-spec :name my-regular-font)))
      (set-frame-font my-regular-font)
    (set-frame-font "7x14")))
 ((eq window-system 'w32)
  (set-frame-font my-regular-font)
  (set-fontset-font nil 'cyrillic my-regular-font)
  (set-fontset-font nil 'greek my-regular-font)
  (set-fontset-font nil 'phonetic my-regular-font)
  ;; (set-fontset-font nil 'symbol my-symbol-font)
))
