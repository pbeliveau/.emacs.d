(defun indent-by-10 ()
  (interactive)
  (dotimes (i 3000)
    (move-beginning-of-line 1)
    (move-to-column 53)
    (insert "      ")
    (move-beginning-of-line 1)
    (next-line 1 1)))
