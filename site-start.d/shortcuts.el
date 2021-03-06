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
                      (global-set-key (kbd "<f6>") #'rmail))

(defun garak-toggle ()
  (interactive)
  (if (or (equal (buffer-name) "*garak*")
          (equal (buffer-name) "*Garak*"))
      (progn
        (delete-other-windows)
        (dotimes (v 2)
          (when (or (equal (buffer-name) "*Garak*")
                    (equal (buffer-name) "*garak*"))
            (bury-buffer))))
    (if (get-buffer "*Garak*")
        (progn
          (delete-other-windows)
          (switch-to-buffer "*garak*")
          (display-buffer "*Garak*"))
      (garak))))

(do-if-feature-exists garak
                      (global-set-key (kbd "<f5>")
                                      #'garak-toggle)
                      (defun garak-quit ()
                        (interactive)
                        (dolist (var '("*Garak*" "*garak*"))
                          (kill-buffer var))
                        (kill-process "*elim*")
                        (kill-buffer "*elim-debug*")))

(do-if-feature-exists bbdb
                      (global-set-key (kbd "<f7>") #'bbdb))

(global-set-key (kbd "<f8>") #'man-follow)

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

(defun screen ()
  (interactive)
  (if (equal (buffer-name) "*ansi-term*")
      (bury-buffer)
    (if (get-buffer "*ansi-term*")
        (switch-to-buffer "*ansi-term*")
      (ansi-term "/usr/bin/screen")

      ;; Make it easy to yank in terminal mode.
      (local-set-key (kbd "C-x y")
                     (lambda ()
                       (interactive)
                       (term-line-mode)
                       (yank)
                       (term-char-mode))))))

(defun couchapp-compile ()
  (interactive)
  (let ((compile-command "couchapp push"))
    (call-interactively #'compile)))

(add-hook 'html-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-c")
                           #'couchapp-compile)))

(global-set-key (kbd "C-x c") #'bury-buffer)

(do-if-feature-exists auto-complete
                      (define-key ac-mode-map (kbd "M-TAB") 'auto-complete))

;; Unset annoying C-z key. It confuses my XMonad.
(global-set-key (kbd "C-z") nil)
(global-set-key (kbd "C-M-^")
                (lambda ()
                  (interactive)
                  (scroll-other-window '-)))

(global-set-key (kbd "C-x y")
                (lambda ()
                  (interactive)
                  (with-temp-buffer
                    (call-process-shell-command "xclip -o" nil t)
                    (kill-region (point-min) (point-max)))
                  (yank)))

(defun kill-ring-save-export (start end)
  (interactive "r")
  (kill-ring-save start end)
  (let ((text (buffer-substring start end)))
    (with-current-buffer (find-file-noselect "/tmp/screen-exchange")
      (erase-buffer)
      (insert text)
      (save-buffer)
      (call-process-shell-command "screen -X readbuf")
      (let ((process-environment
             (cons "DISPLAY=:0" process-environment)))
        (call-process-region (point-min) (point-max) "xsel"
                             nil nil nil "-i" "--clipboard"))
      (kill-buffer))))

;; Little hack to integrate emacs kill ring with
;; screen and X.
(global-set-key (kbd "M-w") #'kill-ring-save-export)

(global-set-key (kbd "C-x C-c") #'delete-frame)

(load-feature vc-dir
              (defvar server-vc-dir nil)
              (define-key vc-dir-mode-map (kbd "q") (lambda ()
                                                      (interactive)
                                                      (quit-window t)
                                                      (when server-vc-dir
                                                        (delete-frame)
                                                        (setq server-vc-dir nil)))))

(global-set-key (kbd "C-<f5>") #'revert-buffer)
(global-set-key (kbd "C-x f") #'auto-fill-mode)
