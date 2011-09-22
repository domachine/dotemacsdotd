;; Keybindings for org-mode.
(global-set-key "\C-cl" #'org-store-link)
(global-set-key "\C-ca" #'org-agenda)
(global-set-key "\C-cb" #'org-iswitchb)

(global-set-key (kbd "C-c C-r") #'org-remember)

(global-set-key (kbd "<f2>") #'newsticker-plainview)

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
