;; == Org ==
(require 'org-latex)
(require 'org-install)

(setq org-agenda-files '("~/Documents/org/notes.org"
                         "~/Documents/org/uni.org"
                         "~/Documents/org/projects.org"
                         "~/Documents/org/sofortholz.org"
                         "~/Documents/org/x-act.org"
                         "~/Documents/org/other.org"))

(setq org-default-notes-file "~/Documents/org/notes.org")
(org-agenda-to-appt)

(setq org-export-latex-classes '(("scrartcl" "\\documentclass{scrartcl}
\\usepackage[ngerman]{babel}"
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

(defun my-org-insert-heading (prefix)
  (interactive "P")
  (if prefix
      (org-insert-heading-respect-content)
    (org-insert-heading)))

;; Keybindings
(define-key org-mode-map (kbd "M-<RET>") 'my-org-insert-heading)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(global-set-key (kbd "C-c C-r") 'org-remember)

;; Autoload entries
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
