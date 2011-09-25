(require 'cl)

(defmacro do-if-feature-exists (feature &rest body)
  "Executes body only if feature file was found in load-path.
In fact a file of the form: <feature>.el or <feature>.elc"
  (let ((feature-test-symbol (intern (format "feature-exists-%s" (symbol-name feature)))))
    (if (boundp feature-test-symbol)
        (if (not (symbol-value feature-test-symbol))
            nil
          `(progn ,@body))
      (let ((dir (gensym))
            (src-file (gensym))
            (c-file (gensym)))
        `(catch 'break
           (dolist (,dir load-path)
             (let* ((,src-file (concat ,dir "/" (symbol-name ',feature) ".el"))
                    (,c-file (concat ,src-file "c")))
               (when (or (file-exists-p ,src-file) (file-exists-p ,c-file))
                 (setf ,feature-test-symbol t)
                 ,@body
                 (throw 'break nil)))))))))

(defmacro load-feature (feature &rest initialization)
  "Loads the given feature and executes the initialization code
if the feature is existent."

  `(condition-case nil
       (progn
         (require ',feature)
         ,@initialization)
     (error)
     nil))

(provide 'site-utils)
