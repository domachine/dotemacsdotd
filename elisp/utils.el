
;; The counter-part of basename behaves exactly like
;; the unix tool dirname.
(defun dir-name (file)
  (let ((file-split (split-string file "\/"))
        (output ""))

    ;; Parse filename
    (while (> (length file-split) 1)
      (if (string-equal "" output)

          ;; Check if filename has trailing slashes.
          (if (string= (substring file 0 1) "/")
              (setq output (concat output "/" (car file-split)))
            (setq output (concat output (car file-split))))
        (setq output (concat output "/" (car file-split))))

      (setq file-split (cdr file-split)))

    (if (string-equal (substring output 0 2) "//")
        (substring output 1)
      output)))

;; Cuts the basename from a file-path and returns it.
(defun base-name (file)
  (let
      ;; Local variables
      ((file-split (split-string file "\/")))

    ;; Parse filename
    (while (> (length file-split) 1)
      (setq file-split (cdr file-split)))
    (car file-split)))
