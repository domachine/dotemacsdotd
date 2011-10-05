;; Keybindings for org-mode.
(global-set-key "\C-cl" #'org-store-link)
(global-set-key "\C-ca" #'org-agenda)
(global-set-key "\C-cb" #'org-iswitchb)

(global-set-key (kbd "C-c C-r") #'org-remember)

(global-set-key (kbd "<f2>") (lambda ()
                               (interactive)
                               (unless (newsticker-running-p)
                                 (newsticker-start))
                               (newsticker-plainview)))

(do-if-feature-exists mingus
                      (global-set-key (kbd "<f5>")
                                      (lambda ()
                                        (interactive)
                                        (unless (get-process "mpd")
                                          (mingus-start-daemon))
                                        (mingus))))

(do-if-feature-exists w3m
                      (global-set-key (kbd "<f6>") #'w3m))

(do-if-feature-exists garak
                      (global-set-key (kbd "<f7>")
                                      (lambda ()
                                        (interactive)
                                        (if (or (equal (buffer-name) "*garak*")
                                                (equal (buffer-name) "*Garak*"))
                                            (progn
                                              (delete-other-windows)
                                              (bury-buffer))
                                          (if (get-buffer "*Garak*")
                                              (progn
                                                (delete-other-windows)
                                                (switch-to-buffer "*garak*")
                                                (display-buffer "*Garak*"))
                                            (garak)))))

                      (defun garak-quit ()
                        (interactive)
                        (dolist (var '("*Garak*" "*garak*" "*elim-debug*"))
                          (kill-buffer var))
                        (kill-process "*elim*")))

(global-set-key (kbd "<f9>") #'rmail)

(do-if-feature-exists passhash
                      (global-set-key (kbd "C-<f6>")
                                      #'passhash))

(global-set-key (kbd "C-x p")
                (lambda (n)
                  (interactive "p")
                  (other-window (- n))))

(global-set-key (kbd "C-x 4 k")
                (lambda nil
                  "Kills the buffer in the next window."
                  (interactive)
                  (let ((buffer (window-buffer (next-window))))
                    (kill-buffer buffer))))

(global-set-key (kbd "C-c C-f") 'ffap)

(global-set-key (kbd "C-x \"")
                (lambda (prefix)
                  (interactive "P")
                  (if prefix
                      (ucs-insert "201D")
                    (ucs-insert "201E"))))

(global-set-key (kbd "<f8>")
                (lambda ()
                  (interactive)
                  (if (equal (buffer-name) "*terminal*")
                      (bury-buffer)
                    (term "/usr/bin/screen"))))

(defun couchapp-compile ()
  (interactive)
  (let ((compile-command "couchapp push"))
    (call-interactively #'compile)))

(add-hook 'html-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-c")
                           #'couchapp-compile)))
