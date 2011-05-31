(defvar website-directory "~/Workspace/homepage")
(defvar website-blog-directory "blog")
(defvar website-config-file-name "config.m4")

(defvar website-blogs nil
  "A list with blog settings.")

(defvar website-module-path nil)
(defvar website-projects
  '((website-one (asdasd . hjkh))
    (website-two (werzx . sadfw))))

(defun website-blog-new-entry ()
  (interactive)

  (let* ((blog-list (let ((tmp-list nil))
                      (message "Generating blog list ...")
                      (dolist (b website-blogs)
                        (message "> %s" b)
                        (setq tmp-list (cons (symbol-name (car b)) tmp-list)))
                      tmp-list))

         (blog-name (completing-read "Blog-name: " blog-list nil t))
         (blog-data (cdr (assoc (intern blog-name) website-blogs)))
         (title (read-string "Title: "))
         (file-name (read-string "Filename (without .m4 extension): "))
         (entry-file (concat (nth 0 blog-data) "/"
                             (nth 2 blog-data) "/"
                             file-name ".m4")))

    (with-current-buffer (find-file-noselect (concat (nth 0 blog-data) "/"
                                                     (nth 1 blog-data)))
      (if (search-forward-regexp "[^ \n\t]" nil t)
          (progn
            (goto-char (point-min))
            (open-line 1)
            (insert (format "[%s]," (concat (nth 2 blog-data) "/" file-name))))
        (goto-char (point-min))
        (insert (format "[%s]," (concat (nth 2 blog-data) "/" file-name)))))

    (with-current-buffer (find-file-noselect entry-file)
      (insert (format "m4_include([post.m4])\npost([%s],\n[" title))
      (set-window-buffer (selected-window) (current-buffer)))))

(defun website-render-template ()
  (interactive)

  (save-excursion
    (goto-char (point-min))
    (while (search-forward "$$" nil t)
      (backward-delete-char 2)
      (let ((start (point))
	    end)
	(forward-sexp 1)
	(setq end (point))
	(save-excursion
	  (let ((value (eval-last-sexp nil)))
	    (when (and value (stringp value))
	      (insert value))))
	(delete-region start end)))))

(defun website-list ()
  (let ((list nil))
    (dolist (project website-projects)
      (setq list (append list (cons (car project) nil))))
    list))

(defun website-get-property (website property)
  (unless (symbolp property)
    (signal 'wrong-type-argument '(symbolp property)))
  (unless (symbolp website)
    (signal 'wrong-type-argument '(symbolp website)))

  (let ((website (assoc website website-projects)))
    (if (not website)
	website
      (assoc property website))))

(provide 'website-utils)
