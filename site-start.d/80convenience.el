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

(defun movie-play-at-point ()
  (interactive)

  (org-open-at-point)
  (let* ((movie-wildcard (concat (expand-file-name dired-directory) "*.avi"))
         (process (apply 'start-process "mplayer"
                                 ;; (with-current-buffer (get-buffer-create "*Mplayer*")
                                 ;;   (erase-buffer)
                                 ;;   (current-buffer))
                         nil
                         "mplayer"
                         (file-expand-wildcards movie-wildcard))))
    (quit-window)))

(defun org-link-file (start end file)
  (interactive "r\nfThe file to link with the headline: ")

  (let ((link-name (buffer-substring-no-properties start end)))
    (kill-region start end)
    (insert (format "[[file:%s][%s]]"
                    (expand-file-name file) link-name))))

(defun launch-run-command ()
  (interactive)
  (unless (and (boundp 'run-command)
               (stringp run-command))
    (error "Run command not bound"))

  (async-shell-command run-command))

;; == Java utils ==
(require 'java-utils)

(defun shell-command-background (command)
  (interactive "sShell-Command: ")
  (let ((process (start-process-shell-command command nil
                                              command)))
    (set-process-sentinel process
                          (lambda (process string)
                            (message "%s: %s"
                                     (process-name process)
                                     string)))))
