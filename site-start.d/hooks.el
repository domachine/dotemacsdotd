(do-if-feature-exists ibuffer
                      (add-hook 'ibuffer-mode-hook
                                (lambda nil
                                  (ibuffer-auto-mode 1)
                                  (ibuffer-switch-to-saved-filter-groups "default")
                                  (ibuffer-add-saved-filters "default")
                                  (ibuffer-add-saved-filters "asterisk"))))

(do-if-feature-exists auctex
                      (add-hook 'LaTeX-mode-hook #'TeX-PDF-mode))

(setq c-mode-common-hook '((lambda nil (local-set-key (kbd "C-c C-c") 'compile))
                           (lambda nil (c-toggle-auto-state 1))))

(add-hook 'dired-mode-hook 'dired-omit-mode)

(add-hook 'css-mode-hook
          (lambda ()
            (font-lock-add-keywords
             nil
             '(("#[abcdef[:digit:]]\\{6\\}"
                (0 (put-text-property
                    (match-beginning 0)
                    (match-end 0)
                    'face (list :background
                                (match-string-no-properties 0)))))))))
(do-if-feature-exists ac-slime
                      (add-hook 'slime-mode-hook #'set-up-slime-ac))

(add-hook 'before-save-hook (lambda ()
                              (unless buffer-read-only
                                (delete-trailing-whitespace))))

(add-hook 'message-mode-hook #'flyspell-mode)

(do-if-feature-exists ajc-java-complete-config
                      (add-hook 'java-mode-hook #'ajc-java-complete-mode))

;; Solve yasnippet vs. org-mode issue.
(do-if-feature-exists yasnippet
                      (defun yas/org-very-safe-expand ()
                        (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))

                      (add-hook 'org-mode-hook
                                (lambda ()
                                  (make-variable-buffer-local 'yas/trigger-key)
                                  (setq yas/trigger-key [tab])
                                  (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
                                  (define-key yas/keymap [tab] 'yas/next-field))))

(add-hook 'kill-emacs-hook
          (lambda ()
            (condition-case excep
                (tramp-cleanup-all-connections)
              (error nil))))

(do-if-feature-exists haskell-mode/haskell-indent
                      (autoload 'haskell-indent-mode "haskell-mode/haskell-indent" nil t)
                      (add-hook 'haskell-mode-hook #'haskell-indent-mode))

(add-hook 'LaTeX-mode-hook #'flyspell-mode)
(add-hook 'LaTeX-mode-hook #'outline-minor-mode)
(add-hook 'LaTeX-mode-hook #'reftex-mode)
