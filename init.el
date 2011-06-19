(autoload 'my-site-start (concat user-emacs-directory "my-site-start") nil t)
(my-site-start (concat user-emacs-directory "site-start.d"))

(setq custom-file (concat user-emacs-directory "site-start.d/99custom.el"))

;; Launch emacs editing server.
(server-start)

(put 'dired-find-alternate-file 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)
(put 'scroll-left 'disabled nil)
