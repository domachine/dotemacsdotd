(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
 '(font-lock-comment-face ((t (:foreground "red"))) nil "Highlight comments in source code correctly")
 '(org-level-1 ((t (:inherit outline-1 :weight bold :height 1.5 :family "arial"))))
 '(org-level-2 ((t (:inherit outline-2 :weight bold :height 1.2 :family "arial")))))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(LaTeX-command "latex -shell-escape")
 '(TeX-auto-save nil)
 '(TeX-command-list (quote (("TeX" "%(PDF)%(tex) %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil (plain-tex-mode texinfo-mode ams-tex-mode) :help "Run plain TeX") ("LaTeX" "%`%l%(mode)%' %t" TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX") ("Makeinfo" "makeinfo %t" TeX-run-compile nil (texinfo-mode) :help "Run Makeinfo with Info output") ("Makeinfo HTML" "makeinfo --html %t" TeX-run-compile nil (texinfo-mode) :help "Run Makeinfo with HTML output") ("AmSTeX" "%(PDF)amstex %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil (ams-tex-mode) :help "Run AMSTeX") ("ConTeXt" "texexec --once --texutil %(execopts)%t" TeX-run-TeX nil (context-mode) :help "Run ConTeXt once") ("ConTeXt Full" "texexec %(execopts)%t" TeX-run-TeX nil (context-mode) :help "Run ConTeXt until completion") ("BibTeX" "bibtex %s" TeX-run-BibTeX nil t :help "Run BibTeX") ("View" "%V" TeX-run-discard-or-function t t :help "Run Viewer") ("Print" "%p" TeX-run-command t t :help "Print the file") ("Queue" "%q" TeX-run-background nil t :help "View the printer queue" :visible TeX-queue-command) ("File" "%(o?)dvips %d -o %f " TeX-run-command t t :help "Generate PostScript file") ("Index" "makeindex %s" TeX-run-command nil t :help "Create index file") ("Check" "lacheck %s" TeX-run-compile nil (latex-mode) :help "Check LaTeX file for correctness") ("Spell" "(TeX-ispell-document \"\")" TeX-run-function nil t :help "Spell-check the document") ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files") ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files") ("Other" "" TeX-run-command t t :help "Run an arbitrary command"))))
 '(TeX-parse-self t)
 '(TeX-view-program-selection (quote (((output-dvi style-pstricks) "dvips and gv") (output-dvi "xdvi") (output-pdf "xpdf") (output-html "xdg-open"))))
 '(battery-mode-line-format "  [%b%p%%, %t]")
 '(browse-url-browser-function (quote w3m-goto-url-new-session))
 '(c-basic-offset 4)
 '(c-default-style (quote ((c-mode . "k&r") (c++-mode . "k&r") (java-mode . "java") (awk-mode . "k&r"))))
 '(cal-tex-diary t)
 '(calendar-mark-diary-entries-flag t)
 '(column-number-mode t)
 '(cperl-hairy t)
 '(diary-display-function (quote diary-fancy-display))
 '(dired-omit-files "^#\\|^\\.[^\\.].+$")
 '(dired-recursive-deletes (quote always))
 '(display-battery-mode t)
 '(display-time-day-and-date t)
 '(display-time-format "%D %l:%M%p")
 '(display-time-mode t)
 '(elim-directory "/home/dominik/.emacs.d/elim")
 '(erc-nick "domachine")
 '(find-file-wildcards t)
 '(garak-hide-offline-buddies t)
 '(ibuffer-expert t)
 '(ibuffer-mode-hook (quote ((lambda nil (ibuffer-auto-mode 1) (ibuffer-switch-to-saved-filter-groups "default")))))
 '(ibuffer-saved-filter-groups (quote (("default" ("Emacs" (or (name . "^\\*scratch\\*$") (name . "^\\*Messages\\*$") (name . "^\\*Buffer List\\*$") (name . "^\\*Completions\\*$"))) ("Compilation" (or (name . "^\\*compilation\\*<?[0-9]*>?$") (name . "^\\*Compile\\-"))) ("Command Output" (name . "^.* output\\*$")) ("W3M" (or (mode . w3m-mode))) ("Shell" (or (mode . shell-mode) (mode . eshell-mode) (mode . term-mode))) ("Tramp" (or (name . "^\\*tramp\\/"))) ("Git" (or (name . "^\\*git\\-[a-zA-Z0-9\\-]+\\*<?[0-9]*>?$") (name . "^\\*vc\\*"))) ("Customize" (or (mode . Custom-mode))) ("Help" (or (mode . help-mode) (mode . Info-mode))) ("Planner" (or (name . "^\\*Calendar\\*$") (name . "^\\*Fancy Diary Entries\\*$") (mode . diary-mode) (mode . muse-mode) (mode . org-agenda-mode))) ("Mail" (or (mode . message-mode) (mode . mail-mode) (mode . gnus-group-mode) (mode . gnus-summary-mode) (mode . gnus-article-mode) (mode . rmail-mode) (name . "^\\.newsrc-dribble"))) ("Newsticker" (or (mode . newsticker-mode) (name . "^\\.newsticker-cache$"))) ("ERC" (or (mode . erc-mode))) ("Garak" (or (mode . garak-mode))) ("BBDB" (or (mode . bbdb-mode) (name . "^\\.bbdb$"))) ("Calc" (or (mode . calc-mode) (mode . calc-trail-mode))) ("Java Project Buffer" (or (name . "project.el<?[0-9]*>?$"))) ("Man" (or (mode . Man-mode))) ("DocView" (or (mode . doc-view-mode))) ("NetworkUtil" (or (mode . net-utils-mode) (name . "^\\*DNS Lookup"))) ("Org" (or (mode . org-mode))) ("CMake" (or (mode . cmake-mode))) ("Python" (or (mode . python-mode))) ("Shell-script" (or (mode . shell-script-mode) (mode . sh-mode))) ("Perl" (or (mode . perl-mode) (mode . cperl-mode))) ("PHP" (or (name . "^.*\\.php$"))) ("HTML" (or (mode . html-mode))) ("YAML" (or (mode . yaml-mode))) ("C" (or (mode . c-mode))) ("C++" (or (mode . c++-mode))) ("Java" (or (mode . java-mode))) ("Javascript" (or (mode . js-mode))) ("TeX" (or (mode . latex-mode))) ("Lisp" (or (mode . emacs-lisp-mode) (mode . lisp-mode))) ("Dired" (mode . dired-mode))))))
 '(ibuffer-saved-filters (quote (("asterisk" ((not name . "^\\*[^\\*]+\\*.*$"))) ("default" ((not name . "^\\.\\(newsticker-cache\\|bbdb\\)$"))) ("gnus" ((or (mode . message-mode) (mode . mail-mode) (mode . gnus-group-mode) (mode . gnus-summary-mode) (mode . gnus-article-mode)))) ("programming" ((or (mode . emacs-lisp-mode) (mode . cperl-mode) (mode . c-mode) (mode . java-mode) (mode . idl-mode) (mode . lisp-mode)))))))
 '(ibuffer-show-empty-filter-groups nil)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(message-send-mail-function (quote smtpmail-send-it))
 '(muse-project-alist (quote (("MyBlog" ("~/Blog" :default "journal") (:base "journal-xhtml" :base-url "" :path "~/Blog/") (:base "journal-rss" :base-url "" :path "~/Blog/")))))
 '(newsticker-url-list (quote (("Tagesschau" "http://www.tagesschau.de/newsticker.rdf" nil nil nil) ("Heise" "http://www.heise.de/newsticker/heise.rdf" nil nil nil))))
 '(newsticker-url-list-defaults nil)
 '(newsticker-wget-arguments (quote ("-q" "-O" "-" "--timeout=20")))
 '(org-agenda-files (quote ("~/Documents/org/notes.org" "~/Documents/org/uni.org" "~/Documents/org/projects.org" "~/Documents/org/sofortholz.org" "~/Documents/org/x-act.org" "~/Documents/org/other.org")))
 '(org-agenda-include-diary t)
 '(org-default-notes-file "~/Documents/org/notes.org")
 '(org-export-latex-classes (quote (("scrartcl" "\\documentclass{scrartcl}
            \\usepackage[ngerman]{babel}" ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}") ("\\paragraph{%s}" . "\\paragraph*{%s}") ("\\subparagraph{%s}" . "\\subparagraph*{%s}")) ("article" "\\documentclass[11pt]{article}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{wrapfig}
\\usepackage{soul}
\\usepackage{amssymb}
\\usepackage{hyperref}" ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}") ("\\subsubsection{%s}" . "\\subsubsection*{%s}") ("\\paragraph{%s}" . "\\paragraph*{%s}") ("\\subparagraph{%s}" . "\\subparagraph*{%s}")) ("report" "\\documentclass[11pt]{report}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{wrapfig}
\\usepackage{soul}
\\usepackage{amssymb}
\\usepackage{hyperref}" ("\\part{%s}" . "\\part*{%s}") ("\\chapter{%s}" . "\\chapter*{%s}") ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}") ("\\subsubsection{%s}" . "\\subsubsection*{%s}")) ("book" "\\documentclass[11pt]{book}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{wrapfig}
\\usepackage{soul}
\\usepackage{amssymb}
\\usepackage{hyperref}" ("\\part{%s}" . "\\part*{%s}") ("\\chapter{%s}" . "\\chapter*{%s}") ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}") ("\\subsubsection{%s}" . "\\subsubsection*{%s}")) ("beamer" "\\documentclass{beamer}"))))
 '(org-startup-with-inline-images t)
 '(rmail-delete-after-output t)
 '(scroll-bar-mode nil)
 '(shell-file-name "bash")
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(w3m-default-display-inline-images t)
 '(warning-suppress-types (quote ((undo discard-info)))))
