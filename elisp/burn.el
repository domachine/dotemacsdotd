
(defun mkisofs-callback (process string)
  (lexical-let ((temp-file (process-get process 'temp-file)))
    (when (string-equal (process-status process) "exit")
      (message "Created iso: %s" temp-file)
      (if (not (yes-or-no-p "Burn cd? "))
          (delete-file temp-file)
        (let* ((wodim-buffer (with-current-buffer (get-buffer-create "*wodim*")
                               (erase-buffer)    ;; Create empty buffer
                               (current-buffer)))
               (wodim-process (start-process "wodim"
                                            wodim-buffer
                                            "wodim" "-dummy" temp-file)))

          (set-window-buffer (selected-window) (process-buffer wodim-process))

          (set-process-sentinel wodim-process
                                (lambda (p s)
                                  (message "wodim returned: %s" s)
                                  (when (yes-or-no-p (format "Delete iso file: `%s'? "
                                                             temp-file))
                                    (delete-file temp-file)))))))))

(defun burn-data-cd ()
  (interactive)

  (let* ((files (dired-get-marked-files))
         (temp-file (make-temp-file "emacs_burn_"))
         (process
          (if files
              (apply 'start-process "mkisofs"
                     (with-current-buffer (get-buffer-create "*mkisofs*")
                        (erase-buffer)
                        (current-buffer))
                     "mkisofs" "-o" temp-file files)
            (error "No files marked"))))

    (set-process-sentinel process 'mkisofs-callback)
    (process-put process 'temp-file temp-file)
    (set-window-buffer (selected-window) (process-buffer process))))

(defun burn-create-toc (cd-type track-type file-type)
  (interactive `(,(completing-read "CD type: " '("CD_DA" "CD_ROM") nil t)
                 ,(completing-read "Track type: " '("TRACK AUDIO" "TRACK MODE1") nil t)
                 ,(completing-read "File type: " '("FILE \"%s\" 0" "DATAFILE \"%s\"") nil t)))

  (let ((files (dired-get-marked-files)))
    (unless files
      (error "No files marked"))
    (with-current-buffer (find-file-noselect "toc")
      (insert (concat cd-type "\n"))
      (dolist (file files)
        (insert (concat track-type "\n"))
        (insert (format (concat file-type "\n") file)))
      (save-buffer))))

(defun burn-call-ffmpeg (output-dir suffix)
  (interactive (if (not (dired-get-marked-files))
		   (error "No files marked")
		 (list (read-directory-name "Output-Directory: "
					    nil nil t)
		       (completing-read "Target-Format Suffix: "
					'(".wav" ".avi" ".mp3")))))

  (let ((files (dired-get-marked-files)))
    (dolist (file files)
      (let ((file (file-name-nondirectory file)))
	(shell-command (format "ffmpeg -i %s %s/%s%s"
			       (shell-quote-argument file)
			       output-dir
			       (shell-quote-argument file)
			       suffix))))))

(provide 'burn)
