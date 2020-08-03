(use-package ledger-mode
  :mode (("\\.ledger\\'" . ledger-mode)
         ("\\.dat\\'"    . ledger-mode))
  :bind ("C-c L" . my-ledger-start-entry)
  :init
  (defun my-ledger-start-entry (&optional arg)
    (interactive "p")
    (find-file-other-window (concat no-littering-var-directory "/org/system/me.ledger"))
    (goto-char (point-max))
    (skip-syntax-backward " ")
    (if (looking-at "\n\n")
        (goto-char (point-max))
      (delete-region (point) (point-max))
      (insert ?\n)
      (insert ?\n))
    (insert (format-time-string "%Y/%m/%d ")))
  :config
  (setq ledger-use-iso-dates                   t
        ledger-post-amount-alignment-column    70
        ledger-clear-whole-transactions        t
        ledger-post-auto-adjust-amounts        t
        ledger-default-acct-transaction-indent 2))

(use-package company-ledger
  :after ledger-mode
  :init
  (with-eval-after-load 'company
    (add-to-list 'company-backends 'company-ledger)))
