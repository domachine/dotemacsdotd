(require 'ibuffer)

(add-hook 'ibuffer-mode-hook
          '(lambda ()
             (ibuffer-auto-mode 1)
             (ibuffer-switch-to-saved-filter-groups "default")))

(setq ibuffer-expert t)
(setq ibuffer-show-empty-filter-groups nil)

(setq ibuffer-saved-filter-groups
      '(("default"
         ("Emacs" (or
                   (name . "^\\*scratch\\*$")
                   (name . "^\\*Messages\\*$")
                   (name . "^\\*Buffer List\\*$")
                   (name . "^\\*Completions\\*$")))
         ("Compilation" (or
                         (name . "^\\*compilation\\*<?[0-9]*>?$")
                         (name . "^\\*Compile\\-")))
         ("Command Output" (name . "^.* output\\*$"))
         ("W3M" (or
                 (mode . w3m-mode)))
         ("Shell" (or
                   (mode . shell-mode)
                   (mode . eshell-mode)
                   (mode . term-mode)))
         ("Tramp" (or
                   (name . "^\\*tramp\\/")))
         ("Git" (or
                 (name . "^\\*git\\-[a-zA-Z0-9\\-]+\\*<?[0-9]*>?$")
                 (name . "^\\*vc\\*")))
         ("Customize" (or
                       (mode . Custom-mode)))
         ("Help" (or
                  (mode . help-mode)
                  (mode . Info-mode)))
         ("Planner" (or
                     (name . "^\\*Calendar\\*$")
                     (name . "^\\*Fancy Diary Entries\\*$")
                     (mode . diary-mode)
                     (mode . muse-mode)
                     (mode . org-agenda-mode)))
         ("Mail" (or (mode . message-mode)
;;                     (mode . bbdb-mode)
                     (mode . mail-mode)
                     (mode . gnus-group-mode)
                     (mode . gnus-summary-mode)
                     (mode . gnus-article-mode)
                     (mode . rmail-mode)
;;                     (name . "^\\.bbdb$")
                     (name . "^\\.newsrc-dribble")))
         ("ERC" (or
                 (mode . erc-mode)))
         ("BBDB" (or
                  (mode . bbdb-mode)
                  (name . "^\\.bbdb$")))
         ("Calc" (or
                  (mode . calc-mode)
                  (mode . calc-trail-mode)))
         ("Java Project Buffer" (or
                                 (name . "project.el<?[0-9]*>?$")))
         ("Man" (or
                 (mode . Man-mode)))
         ("DocView" (or
                     (mode . doc-view-mode)))
         ("NetworkUtil" (or
                         (mode . net-utils-mode)
                         (name . "^\\*DNS Lookup")))
         ("Org" (or
                 (mode . org-mode)))
         ("CMake" (or
                   (mode . cmake-mode)))
         ("Python" (or
                    (mode . python-mode)))
         ("Shell-script" (or
                   (mode . shell-script-mode)
                   (mode . sh-mode)))
         ("Perl" (or
                  (mode . perl-mode)
                  (mode . cperl-mode)))
         ("PHP" (or
                 (name . "^.*\\.php$")))
         ("HTML" (or
                  (mode . html-mode)))
         ("YAML" (or
                  (mode . yaml-mode)))
         ("C" (or
               (mode . c-mode)))
         ("C++" (or
                 (mode . c++-mode)))
         ("Java" (or
                  (mode . java-mode)))
         ("Javascript" (or
                        (mode . js-mode)))
         ("TeX" (or
                 (mode . latex-mode)))
         ("Lisp" (or
                  (mode . emacs-lisp-mode)
                  (mode . lisp-mode)))
         ("Dired" (mode . dired-mode)))))


;; Install keybinding for ibuffer (Replacing buffer-list)
(global-set-key (kbd "C-x C-b") 'ibuffer)
