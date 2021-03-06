(require 'shell)

(defun insert-into-buffer (buffer &rest args)
  "Simply saves current buffer and writes ARGS to target buffer."

  (with-current-buffer buffer
    (apply 'insert args)))

;;;###autoload
(defun ftp-upload-file-list (bookmark &optional buffer)
  "Uploads a file list in the current buffer (Generated by `find' for example)
   to a ftp-server."

  (interactive `(,(completing-read "Bookmark: "
                                   (when (and (file-regular-p "~/.ncftp/bookmarks")
                                              (file-readable-p "~/.ncftp/bookmarks"))
                                     (with-temp-buffer
                                       (insert-file-contents "~/.ncftp/bookmarks")
                                       (let ((results nil))
                                         (while (search-forward-regexp
                                                 "^\\([^,\n]+\\),\\([^,\n]*,\\)\\{20\\}$" nil t)
                                           (add-to-list 'results (match-string 1)))
                                         results))))))
  (unless buffer
    (setq buffer (current-buffer)))

  (with-current-buffer buffer
    (save-excursion
      (let ((output-buffer (generate-new-buffer "upload-script.sh")))
        (goto-char (point-min))

        (insert-into-buffer output-buffer "open "
                            (shell-quote-argument bookmark) "\n")

        ;; Loop through all lines that look like files.
        (while (search-forward-regexp "^\\([^;\n].+\\)$" nil t)
          ;; Parse filepath.
          (let ((filepath (match-string 1))
                (directory (file-name-directory (match-string 1))))

            (save-excursion
              (let ((end-point (point))
                    next-mkdir)
                (beginning-of-line)

                ;; Loop through all directory parts and make sure that they exist
                ;; on the target-host.
                (while (search-forward-regexp "\\([^\\/\n]+\\)/" end-point t)
                  (setq next-mkdir (concat next-mkdir
                                           "/"
                                           (shell-quote-argument (match-string 1))))

                  ;; Generate the mkdir command
                  (insert-into-buffer output-buffer "mkdir " next-mkdir "\n"))))

            (with-current-buffer output-buffer
              ;; Generate the put command with directory-change.
              (insert "cd " (shell-quote-argument directory) "\n")
              (insert "put -f " (shell-quote-argument filepath) "\n")
              (insert "cd /\n"))))

        ;; Finalize with exit
        (insert-into-buffer output-buffer "exit\n")

        ;; Run the command
        (let ((process-connection-type nil) ; Use pipe
              (process-buffer (generate-new-buffer "*Ftp output*"))
              process)

          ;; Launch process
          (setq process
                (start-process "ncftp" process-buffer "ncftp"))

          (with-current-buffer process-buffer
            (shell-mode))
          
          ;; Send ftp commands.
          (with-current-buffer output-buffer
            (goto-char (point-max))
            (process-send-region process 1 (point)))

          ;; Show the result.
          (display-buffer process-buffer))

        ;; Clean up.
        (kill-buffer output-buffer)))))

(provide 'ftputils)
