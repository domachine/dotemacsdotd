;; == TeX ==
(add-hook 'LaTeX-mode-hook (lambda () (TeX-PDF-mode)))

(setq TeX-view-program-list (quote (("xpdf-display" "DISPLAY=:0 xpdf %o")
                                    ("xdvi-display" "DISPLAY=:0 xdvi %o"))))
(setq TeX-view-program-selection '(((output-dvi style-pstricks) "dvips and gv")
                                   (output-dvi "xdvi-display")
                                   (output-pdf "xpdf-display")
                                   (output-html "xdg-open")))

;; The pretty cool auctex extension.
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

;; == C ==
;; All the C and C++ etc. settings.
(setq c-mode-common-hook '((lambda nil (local-set-key (kbd "C-c C-c") 'compile))
                           (lambda nil (c-toggle-auto-state 1))))

(setq c-basic-offset 4)
(setq c-default-style '((c-mode . "k&r")
                        (c++-mode . "k&r")
                        (java-mode . "java")
                        (awk-mode . "k&r")))

;; == Lua ==
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)

;; == CMake ==
(require 'cmake-mode)

;; == PHP ==
(require 'php-mode)

;; == Haskell ==
(load "haskell-mode/haskell-site-file")

;; == Elisp ==
(add-hook 'after-save-hook
          (lambda ()
            (if (eq major-mode 'emacs-lisp-mode)
                (byte-compile-file (buffer-file-name)))))
