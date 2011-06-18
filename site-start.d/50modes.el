;; == TeX ==
(add-hook 'LaTeX-mode-hook (lambda () (TeX-PDF-mode)))

(setq TeX-view-program-list (quote (("xpdf-display" "DISPLAY=:0 xpdf %o")
                                    ("xdvi-display" "DISPLAY=:0 xdvi %o"))))
(setq TeX-view-program-selection (cond
                                  ((eq system-type 'windows-nt)
                                   '(((output-dvi style-pstricks)
                                      "dvips and start")
                                     (output-dvi "Yap")
                                     (output-pdf "start")
                                     (output-html "start")))
                                  (t
                                   '(((output-dvi style-pstricks)
                                      "dvips and gv")
                                     (output-dvi "xdvi")
                                     (output-pdf "xpdf-display")
                                     (output-html "xdg-open")))))

(setq TeX-command-list
      `(("TeX" "%(PDF)%(tex) %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil
         (plain-tex-mode ams-tex-mode texinfo-mode)
         :help "Run plain TeX")
        ("LaTeX" "%`%l%(mode)%' %t" TeX-run-TeX nil
         (latex-mode doctex-mode)
         :help "Run LaTeX")
        ("Makeinfo" "makeinfo %t" TeX-run-compile nil
         (texinfo-mode)
         :help "Run Makeinfo with Info output")
        ("Makeinfo HTML" "makeinfo --html %t" TeX-run-compile nil
         (texinfo-mode)
         :help "Run Makeinfo with HTML output")
        ("AmSTeX" "%(PDF)amstex %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil
         (ams-tex-mode)
         :help "Run AMSTeX")
        ("ConTeXt" "texexec --once --texutil %(execopts)%t" TeX-run-TeX nil
         (context-mode)
         :help "Run ConTeXt once")
        ("ConTeXt Full" "texexec %(execopts)%t" TeX-run-TeX nil
         (context-mode)
         :help "Run ConTeXt until completion")
        ("BibTeX" "bibtex %s" TeX-run-BibTeX nil t :help "Run BibTeX")
;        ,(if
;             (or window-system
;                 (getenv "DISPLAY"))
        ("View" "%V" TeX-run-discard-or-function t t :help "Run Viewer")
;           '("View" "dvi2tty -q -w 132 %s" TeX-run-command t t :help "Run Text viewer"))
        ("Print" "%p" TeX-run-command t t :help "Print the file")
        ("Queue" "%q" TeX-run-background nil t :help "View the printer queue" :visible TeX-queue-command)
        ("File" "%(o?)dvips %d -o %f " TeX-run-command t t :help "Generate PostScript file")
        ("Index" "makeindex %s" TeX-run-command nil t :help "Create index file")
        ("Check" "lacheck %s" TeX-run-compile nil
         (latex-mode)
         :help "Check LaTeX file for correctness")
        ("Spell" "(TeX-ispell-document \"\")" TeX-run-function nil t :help "Spell-check the document")
        ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files")
        ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files")
        ("Other" "" TeX-run-command t t :help "Run an arbitrary command")))

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

(add-hook 'dired-mode-hook 'dired-omit-mode)
