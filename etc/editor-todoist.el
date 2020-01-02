(use-package todoist
  :if (not (memq window-system '(w32)))
  :init
  (if (eq (file-exists-p (concat no-littering-var-directory "todoist/.todoist")) nil)
      (progn
        (make-directory (concat no-littering-var-directory "todoist"))
        (make-empty-file (concat no-littering-var-directory "todoist/.todoist"))))
  (load (concat no-littering-var-directory "todoist/.todoist"))
  :config
  (setq todoist-token todoist_api))
