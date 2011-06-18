(setq ibuffer-saved-filter-groups
      '(("default"
         ("Planner" (or
                     (name . "^\\*Calendar\\*$")
                     (name . "^\\*Fancy Diary Entries\\*$")
                     (mode . diary-mode)
                     (mode . muse-mode)))
         ("Mail" (or (mode . message-mode)
                     (mode . bbdb-mode)
                     (mode . mail-mode)
                     (mode . gnus-group-mode)
                     (mode . gnus-summary-mode)
                     (mode . gnus-article-mode)
                     (mode . rmail-mode)
                     (name . "^\\.bbdb$")
                     (name . "^\\.newsrc-dribble")))
         ("Java Project Buffer" (or
                                 (name . "project.el<?[0-9]*>?$")))
         ("Command Output" (name . "^.* output\\*$"))
         ("Shell" (or
                   (mode . shell-mode)
                   (mode . term-mode)))
         ("Man" (or
                 (mode . Man-mode)))
         ("NetworkUtil" (or
                         (mode . net-utils-mode)
                         (name . "^\\*DNS Lookup")))
         ("W3M" (or
                 (mode . w3m-mode)))
         ("Git" (or
                 (name . "^\\*git\\-[a-zA-Z0-9\\-]+\\*<?[0-9]*>?$")
                 (name . "^\\*vc\\*")))
         ("Customize" (or
                       (mode . Custom-mode)))
         ("Help" (or
                  (mode . help-mode)
                  (mode . Info-mode)))
         ("*Compilation*" (or
                           (name . "^\\*compilation\\*<?[0-9]*>?$")
                           (name . "^\\*Compile\\-")))
         ("*Emacs*" (or
                     (name . "^\\*scratch\\*$")
                     (name . "^\\*Messages\\*$")
                     (name . "^\\*Buffer List\\*$")
                     (name . "^\\*Completions\\*$")))
         ("Organizer" (or
                       (mode . org-mode)))
         ("Python" (or
                    (mode . python-mode)))
         ("PHP" (or
                 (name . "^.*\\.php$")))
         ("C" (or
               (mode . c-mode)))
         ("C++" (or
                 (mode . c++-mode)))
         ("Java" (or
                  (mode . java-mode)))
         ("TeX" (or
                 (mode . latex-mode)))
         ("Lisp" (or
                  (mode . emacs-lisp-mode)
                  (mode . lisp-mode)))
         ("dired" (mode . dired-mode)))))
