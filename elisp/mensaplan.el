(require 'xml)
(require 'xmltok)

(defvar mensaplan-url
  "http://www.uni-ulm.de/mensaplan/mensaplan.xml")

(defun mensaplan--download-xml ()
  "Downloads the xml file and returns the containing buffer."

  (with-current-buffer (generate-new-buffer "wget-output")
    (let* ((process-connection-type nil))
      (save-excursion
        (call-process-shell-command (format "wget %s -O - 2>/dev/null"
                                            (shell-quote-argument mensaplan-url))
                                    nil (current-buffer))))
    (current-buffer)))

(defun mensaplan ()
  (interactive)
  (let ((buffer (mensaplan--download-xml))
        (output (with-current-buffer (get-buffer-create "*Mensaplan*")
                  (erase-buffer)
                  (org-mode)
                  (current-buffer))))
    (let (mensaplan-data)
      (with-current-buffer buffer
        ;;(xmltok-forward)

        (setq mensaplan-data (xml-parse-tag)))

      (with-current-buffer output
        (insert "#+TODO: HEUTE | MORGEN")
        (org-ctrl-c-ctrl-c)
        (move-beginning-of-line nil)
        (org-kill-line nil))

      (dolist (week (xml-get-children mensaplan-data 'week))
        (when (listp week)
          (with-current-buffer output
            (org-insert-heading-respect-content)
            (insert (concat "Woche: " (xml-get-attribute week 'weekOfYear)))
            (newline)

            (dolist (day (xml-get-children week 'day))
              (when (listp day)
                (let ((date (xml-get-attribute day 'date))
                      (open (if (string-equal (xml-get-attribute day 'open) "1")
                                "offen"
                              "geschlossen"))
                      (today (string-equal (xml-get-attribute day 'today) "today")))

                  (if today
                      (insert (format "** HEUTE %s: %s" date open))
                    (insert (format "** %s: %s" date open)))

                  (save-excursion
                    (dolist (meal (xml-get-children day 'meal))
                      (when (listp meal)
                        (newline)
                        (insert (format "*** %s" (xml-get-attribute meal 'type)))
                        (dolist (item (xml-get-children meal 'item))
                          (newline)
                          (insert (format "    - %s" (nth 2 item)))))))

                  (move-beginning-of-line nil)
                  (unless today
                    (org-cycle))
                  (open-line 1))))))))
    (with-current-buffer output
      (setq buffer-read-only t))

    (kill-buffer buffer)
    (display-buffer output)))

(provide 'mensaplan)
