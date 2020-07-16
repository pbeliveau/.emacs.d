(use-package ruby-mode
  :ensure nil
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
  :quelpa (ruby-additional
           :fetcher github
           :repo "emacsattic/ruby-additional"))
