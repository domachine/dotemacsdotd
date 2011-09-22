(add-hook 'ibuffer-mode-hook
          (lambda nil (ibuffer-auto-mode 1) (ibuffer-switch-to-saved-filter-groups "default")))

(add-hook 'LaTeX-mode-hook #'TeX-PDF-mode)

(setq c-mode-common-hook '((lambda nil (local-set-key (kbd "C-c C-c") 'compile))
                           (lambda nil (c-toggle-auto-state 1))))

(add-hook 'dired-mode-hook 'dired-omit-mode)
