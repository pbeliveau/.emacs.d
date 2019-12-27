(use-package ruby-mode
  :straight (ruby-mode :type built-in)
  :hook my-ruby-mode-hook
  :mode (("\\.rb$" . ruby-mode)
         ("Gemfile" . ruby-mode)
         ("Rakefile" . ruby-mode)
         ("\\.rake$" . ruby-mode))
  :interpreter "ruby"
  :config
  (defun my-ruby-mode-hook ()
    (set-fill-column 80)))

(use-package ruby-additional
  :ensure t)
