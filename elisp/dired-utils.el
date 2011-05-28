
(defun dired-map-files (function counter-start command)
  (let ((files (dired-get-marked-files))
	(counter counter-start))

    (unless files
      (error "No files marked"))

    (dolist (file files)
      (let* ((command (replace-regexp-in-string " \\? ?"
						(concat " " (shell-quote-argument file) " ") command t t))
	     (command (replace-regexp-in-string " ! ?"
						(concat " " (number-to-string counter) " ") command t t)))

	(funcall function command)
	(setq counter (1+ counter))))))

(defun dired-do-shell-command-counter (counter-start command)
  (interactive "p\nsShell-command: ")
  (dired-map-files 'shell-command counter-start command))
