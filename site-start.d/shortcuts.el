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

(do-if-feature-exists w3m
                      (global-set-key (kbd "<f6>") #'w3m))

(do-if-feature-exists garak
                      (global-set-key (kbd "<f7>")
                                      (lambda ()
                                        (interactive)
                                        (if (get-buffer "*Garak*")
                                            (progn
                                              (delete-other-windows)
                                              (switch-to-buffer "*garak*")
                                              (display-buffer "*Garak*"))
                                          (garak))))

                      (defun garak-quit ()
                        (interactive)
                        (dolist (var '("*Garak*" "*garak*" "*elim-debug*"))
                          (kill-buffer var))
                        (kill-process "*elim*")))

(global-set-key (kbd "\C-x p")
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

(defun screen ()
  "Launches terminal with screen."

  (interactive)
  (term "/usr/bin/screen"))

(defun couchapp-compile ()
  (interactive)
  (let ((compile-command "couchapp push"))
    (call-interactively #'compile)))

(add-hook 'html-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-c")
                           #'couchapp-compile)))
