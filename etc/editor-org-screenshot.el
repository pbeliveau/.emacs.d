(defun portable-org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  (setq filename
        (concat
         (make-temp-name
          (concat (buffer-file-name)
                  "_"
                  (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  (if (eq system-type 'windows-nt)
      (progn
        (shell-command "snippingtool /clip")
        (shell-command (concat
                        "powershell -command \"Add-Type
                        -AssemblyName
                        System.Windows.Forms;if ($([System.Windows.Forms.Clipboard]::ContainsImage()))
                        {$image =
                        [System.Windows.Forms.Clipboard]::GetImage();[System.Drawing.Bitmap]$image.Save('"
                        filename "',[System.Drawing.Imaging.ImageFormat]::Png);
                        Write-Output 'clipboard content saved
                        as file'} else {Write-Output
                        'clipboard does not contain image
                        data'}\""))))

  (if (eq system-type 'gnu/linux)
      (progn
        (setq region (concat "'" (shell-command-to-string "printf %s \"$(slurp)\"") "'"))
        (shell-command (concat "grim -g " region " " filename))))

  (insert (concat "[[file:" filename "]]"))
  (org-display-inline-images))
