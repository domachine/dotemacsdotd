;; == C ==
;; All the C and C++ etc. settings.
(setq c-mode-common-hook '((lambda nil (local-set-key (kbd "C-c C-c") 'compile))
                           (lambda nil (c-toggle-auto-state 1))))

(setq c-basic-offset 4)
(setq c-default-style '((c-mode . "k&r")
                        (c++-mode . "k&r")
                        (java-mode . "java")
                        (awk-mode . "k&r")))
