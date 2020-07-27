;;; silence.el --- From https://superuser.com/a/1025827.  -*- lexical-binding:t -*-

;; renamed to silence instead of suppress-messages
(defun silence (old-fun &rest args)
  (cl-flet ((silence (&rest args1) (ignore)))
    (advice-add 'message :around #'silence)
    (unwind-protect
         (apply old-fun args)
      (advice-remove 'message #'silence))))

(provide 'silence)
