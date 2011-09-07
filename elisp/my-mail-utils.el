
(defun facebook--convert-date (date)
  (unless (string-match (concat "\\([A-Z][a-z]+\\), *\\([0-9]+\\)\\. *"
                                "\\([A-Z][a-z]\\{2\\}\\)[a-z]* "
                                "*\\(um\\)? \\([0-9]+\\):\\([0-9]+\\)") date)
    (error "Invalid date string"))

  (let ((day (match-string 1 date))
        (day-n (match-string 2 date))
        (month (match-string 3 date))
        (time-hour (string-to-number (match-string 5 date)))
        (time-mins (match-string 6 date))
        time)

    (cond ((equal time-hour 12)
           (setq time (format "%d:%spm" time-hour time-mins)))
          ((> time-hour 12)
           (setq time (format "%d:%spm" (- time-hour 12) time-mins)))
          ((< time-hour 12)
           (setq time (format "%d:%sam" time-hour time-mins))))

    ;; Translate month.
    (cond ((equal month "Mär")
           (setq month "Mar"))
          ((equal month "Mai")
           (setq month "May"))
          ((equal month "Okt")
           (setq month "Oct"))
          ((equal month "Dez")
           (setq month "Dec")))

    (format "%s %s, 2011 %s" month day-n time)))

(defun facebook-scan-event ()
  (interactive)
  (save-excursion
    (goto-char 1)
    (let (event raw-start raw-end location)
      (when (search-forward-regexp "^Veranstaltung: \\([^\n]+\\)$" nil t)
        (setq event (match-string 1)))
      (when (search-forward-regexp "^Beginn: \\([^\n]+\\)$" nil t)
        (setq raw-start (match-string 1)))
      (when (search-forward-regexp "^Ende: \\([^\n]+\\)$" nil t)
        (setq raw-end (match-string 1)))
      (when (search-forward-regexp "^Ort: \\([^\n]+\\)$" nil t)
        (setq location (match-string 1)))

      (if event
          (with-current-buffer (find-file-noselect diary-file)
            (open-line 1)
            (insert (format "%s %s: %s\n"
                            (facebook--convert-date raw-start)
                            location
                            event))
            (display-buffer (current-buffer)))
        (error "No event found")))))

(defun bbdb-rmail-scan-from ()
  (interactive)
  (save-excursion
    (goto-char 0)
    (unless (search-forward-regexp
             "^From: \"?\\([^\"]+\\)\"? +[<\"]\\(.*\\)[>\"][ \t]*$" nil t)
      (error "Couldn't match from field"))
    (let ((name (match-string 1))
          (email (match-string 2)))
      (if (y-or-n-p (format "Add (\"%s\" \"%s\") to bbdb? " name email))
          (bbdb-create-internal (match-string 1) "" (match-string 2) "" "" "")))))

(provide 'my-mail-utils)
