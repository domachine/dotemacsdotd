;; == Elisp ==
(add-hook 'after-save-hook
          (lambda ()
            (if (eq major-mode 'emacs-lisp-mode)
                (byte-compile-file (buffer-file-name)))))
