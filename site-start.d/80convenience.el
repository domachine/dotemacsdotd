(require 'sgml-mode)
(require 'xmltok)

;; Make it more efficient to navigate between windows.
(defun other-window-backward (n)
  (interactive "p")
  (other-window (- n)))

(global-set-key (kbd "\C-x p") 'other-window-backward)
(global-set-key (kbd "C-c C-f") 'ffap)
(global-set-key (kbd "C-c C-c") 'compile)

(defun delete-process-i (p)
  "Delete process interactively"

  (interactive `(,(completing-read "Kill proc: "
				  (mapcar 'process-name
					  (process-list)) () t)))
  (delete-process p))

(defun movie-fink-play-at-point ()
  (interactive)

  (let ((movie-files (org-entry-get-multivalued-property nil "Files")))
    (dolist (movie movie-files)
      (message "Playing: %s" movie)
      (call-process-shell-command (concat "mplayer "
                                          (shell-quote-argument (file-truename movie)))))))

(defun org-link-file (start end file)
  (interactive "r\nfThe file to link with the headline: ")

  (let ((link-name (buffer-substring-no-properties start end)))
    (kill-region start end)
    (insert (format "[[file:%s][%s]]"
                    (expand-file-name file) link-name))))

(defvar run-command)

(defun launch-run-command ()
  (interactive)
  (unless (and (boundp 'run-command)
               (stringp run-command))
    (error "Run command not bound"))

  (async-shell-command run-command))

;; == Java utils ==
(require 'java-utils)

(defun shell-command-background (command &optional file)
  "Fire up a command without associating a buffer with it."
  (interactive `(,(read-shell-command "Shell-Command: ")
                 ,(if current-prefix-arg
                      (if (dired-get-filename t)
                          (dired-get-filename t)
                        (error "No file marked"))
                    nil)))
  (message file)
  (let* ((command (if file
                      (concat command " "
                              (shell-quote-argument file))
                    command))
         (process (start-process-shell-command command nil command)))

    (set-process-sentinel process
                          (lambda (process string)
                            (message "%s: %s"
                                     (process-name process)
                                     string)))))

(define-key dired-mode-map
  (kbd "*") #'(lambda ()
                (interactive)
                (let ((current-prefix-arg t))
                  (call-interactively #'shell-command-background))))

(defun startx ()
  (interactive)
  (shell-command-background "startx"))

(defun kill-buffer-other-window ()
  "Kills the buffer in the next window."
  (interactive)
  (let ((buffer (window-buffer (next-window))))
    (kill-buffer buffer)))

(global-set-key (kbd "C-x 4 k") 'kill-buffer-other-window)

(add-to-list 'kill-emacs-query-functions
             (lambda ()
               (y-or-n-p "Do you really want to exit Emacs? ")))

(defun insert-file-path (path)
  (interactive "fFile-Path: ")
  (insert path))

(defun xml-strip-tags ()
  (interactive)
  (while (char-after)
    (message "char-after: %s" (char-to-string (char-after)))
    (if (equal (char-to-string (char-after)) "<")
        (condition-case ex
            (sgml-delete-tag 1)
          nil)
      (condition-case ex
          (xmltok-forward)
        nil))))
