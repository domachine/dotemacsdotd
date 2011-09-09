(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
 '(font-lock-comment-face ((t (:foreground "red"))) nil "Highlight comments in source code correctly"))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(battery-mode-line-format "  [%b%p%%, %t]")
 '(cal-tex-diary t)
 '(calendar-mark-diary-entries-flag t)
 '(diary-display-function (quote diary-fancy-display))
 '(dired-omit-files "^#\\|^\\.[^\\.].+$")
 '(display-battery-mode t)
 '(display-time-day-and-date t)
 '(display-time-format "%D %l:%M%p")
 '(display-time-mode t)
 '(emms-source-file-default-directory "~/Music/")
 '(ibuffer-saved-filter-groups (quote (("default" ("Emacs" (or (name . "^\\*scratch\\*$") (name . "^\\*Messages\\*$") (name . "^\\*Buffer List\\*$") (name . "^\\*Completions\\*$"))) ("Compilation" (or (name . "^\\*compilation\\*<?[0-9]*>?$") (name . "^\\*Compile\\-"))) ("Command Output" (name . "^.* output\\*$")) ("W3M" (or (mode . w3m-mode))) ("Shell" (or (mode . shell-mode) (mode . eshell-mode) (mode . term-mode))) ("Tramp" (or (name . "^\\*tramp\\/"))) ("Git" (or (name . "^\\*git\\-[a-zA-Z0-9\\-]+\\*<?[0-9]*>?$") (name . "^\\*vc\\*"))) ("Customize" (or (mode . Custom-mode))) ("Help" (or (mode . help-mode) (mode . Info-mode))) ("Planner" (or (name . "^\\*Calendar\\*$") (name . "^\\*Fancy Diary Entries\\*$") (mode . diary-mode) (mode . muse-mode) (mode . org-agenda-mode))) ("Mail" (or (mode . message-mode) (mode . mail-mode) (mode . gnus-group-mode) (mode . gnus-summary-mode) (mode . gnus-article-mode) (mode . rmail-mode) (name . "^\\.newsrc-dribble"))) ("Newsticker" (or (mode . newsticker-mode) (name . "^\\.newsticker-cache$"))) ("ERC" (or (mode . erc-mode))) ("BBDB" (or (mode . bbdb-mode) (name . "^\\.bbdb$"))) ("Calc" (or (mode . calc-mode) (mode . calc-trail-mode))) ("Java Project Buffer" (or (name . "project.el<?[0-9]*>?$"))) ("Man" (or (mode . Man-mode))) ("DocView" (or (mode . doc-view-mode))) ("NetworkUtil" (or (mode . net-utils-mode) (name . "^\\*DNS Lookup"))) ("Org" (or (mode . org-mode))) ("CMake" (or (mode . cmake-mode))) ("Python" (or (mode . python-mode))) ("Shell-script" (or (mode . shell-script-mode) (mode . sh-mode))) ("Perl" (or (mode . perl-mode) (mode . cperl-mode))) ("PHP" (or (name . "^.*\\.php$"))) ("HTML" (or (mode . html-mode))) ("YAML" (or (mode . yaml-mode))) ("C" (or (mode . c-mode))) ("C++" (or (mode . c++-mode))) ("Java" (or (mode . java-mode))) ("Javascript" (or (mode . js-mode))) ("TeX" (or (mode . latex-mode))) ("Lisp" (or (mode . emacs-lisp-mode) (mode . lisp-mode))) ("Dired" (mode . dired-mode))))))
 '(ibuffer-saved-filters (quote (("asterisk" ((not name . "^\\*[^\\*]+\\*$"))) ("default" ((not name . "^\\.newsticker-cache$"))) ("gnus" ((or (mode . message-mode) (mode . mail-mode) (mode . gnus-group-mode) (mode . gnus-summary-mode) (mode . gnus-article-mode)))) ("programming" ((or (mode . emacs-lisp-mode) (mode . cperl-mode) (mode . c-mode) (mode . java-mode) (mode . idl-mode) (mode . lisp-mode)))))))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(message-send-mail-function (quote smtpmail-send-it))
 '(newsticker-url-list (quote (("Tagesschau" "http://www.tagesschau.de/newsticker.rdf" nil nil nil) ("Thomas Activity" "https://github.com/lordmalak.atom" nil nil nil))))
 '(newsticker-url-list-defaults nil)
 '(org-agenda-include-diary t)
 '(org-startup-with-inline-images t)
 '(scroll-bar-mode nil)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(w3m-default-display-inline-images t nil nil "Show images in w3m"))
