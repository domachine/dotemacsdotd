;; == Org ==
(require 'org-latex)
(require 'org-install)

(setq org-agenda-files '("/home/dominik/Documents/org/notes.org"
                         "/home/dominik/Documents/org/uni.org"
                         "/home/dominik/Documents/org/projects.org"
                         "/home/dominik/Documents/org/sofortholz.org"
                         "~/Documents/org/other.org"))

(setq org-default-notes-file "~/Documents/org/notes.org")
(org-agenda-to-appt)

(setq org-export-latex-classes '(("scrartcl" "\\documentclass{scrartcl}
\\usepackage[utf8]{inputenc}
\\usepackage[ngerman]{babel}
\\usepackage[T1]{fontenc}
\\usepackage{graphicx}"
                                  ("\\section{%s}" . "\\section*{%s}")
                                  ("\\subsection{%s}" . "\\subsection*{%s}")
                                  ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                                  ("\\paragraph{%s}" . "\\paragraph*{%s}")
                                  ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))

                                 ("article" "\\documentclass[11pt]{article}"
                                  ("\\section{%s}" . "\\section*{%s}")
                                  ("\\subsection{%s}" . "\\subsection*{%s}")
                                  ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                                  ("\\paragraph{%s}" . "\\paragraph*{%s}")
                                  ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))

                                 ("report" "\\documentclass[11pt]{report}"
                                  ("\\part{%s}" . "\\part*{%s}")
                                  ("\\chapter{%s}" . "\\chapter*{%s}")
                                  ("\\section{%s}" . "\\section*{%s}")
                                  ("\\subsection{%s}" . "\\subsection*{%s}")
                                  ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))

                                 ("book" "\\documentclass[11pt]{book}"
                                  ("\\part{%s}" . "\\part*{%s}")
                                  ("\\chapter{%s}" . "\\chapter*{%s}")
                                  ("\\section{%s}" . "\\section*{%s}")
                                  ("\\subsection{%s}" . "\\subsection*{%s}")
                                  ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))

                                 ("beamer" "\\documentclass{beamer}" org-beamer-sectioning)))

(setq org-publish-project-alist '(("desktop"
                                   :base-directory "~/Documents/org"
                                   :publishing-directory "~/Documents/org")))

(setq org-file-apps '((auto-mode . emacs)
                      ("\\.mm\\'" . default)
                      ("\\.x?html?\\'" . default)
                      ("\\.pdf\\'" . "DISPLAY=:0 xpdf %s")))
