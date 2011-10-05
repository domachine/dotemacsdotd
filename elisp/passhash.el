
;; Emacs bindings for the passhash tool, provided as firefox plugin.
;; -- I need this tool for more things I do outside of the browser.


(defcustom passhash-wrapper-script-path "passhash.sh"
  "The path to the passhash wrapper script.")

(defun passhash (site-tag masterkey)
  "Generates password using standard settings and kills it."

  (interactive
   `(,(read-string "Site-tag: ") ,(read-passwd "Masterkey: ")))

  (let ((args (if current-prefix-arg
                  `(,site-tag "-s" ,(number-to-string
                                     (prefix-numeric-value current-prefix-arg)))
                `(,site-tag)))
        (process-environment (append process-environment
                                     `(,(format "MASTERKEY=%s" masterkey)))))
    (with-temp-buffer
      (save-excursion
        (apply #'call-process "~/Workspace/passhash/src/passhash.sh"
               nil (current-buffer) nil
               args))

      (next-line)
      (kill-line))))

(provide 'passhash)
