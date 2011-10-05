(require 'cl)

(defmacro do-if-feature-exists (feature &rest body)
  "Executes body only if feature file was found in load-path.
In fact a file of the form: <feature>.el or <feature>.elc"
  (let ((feature-test-symbol (intern (format "feature-exists-%s" (symbol-name feature)))))
    (if (or (featurep feature)
            (and (boundp feature-test-symbol)
                 (symbol-value feature-test-symbol)))
        ;; This feature is already loaded or found.
        `(progn ,@body)
      (when (not (boundp feature-test-symbol))
        ;; The feature wasn't searched before, so go and
        ;; try to find it.

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
                   (throw 'break nil))))))))))

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
