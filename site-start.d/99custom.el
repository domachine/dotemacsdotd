(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
 '(font-lock-comment-face ((t (:foreground "red"))) nil "Highlight comments in source code correctly"))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(cal-tex-diary t)
 '(calendar-mark-diary-entries-flag t)
 '(diary-display-function (quote diary-fancy-display))
 '(dired-omit-files "^#\\|^\\.[^\\.].+$")
 '(display-time-mode t)
 '(emms-source-file-default-directory "~/Music/")
 '(ibuffer-expert t nil nil "Don't query for confirmation")
 '(ibuffer-show-empty-filter-groups nil)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(ispell-dictionary nil)
 '(ispell-personal-dictionary "/usr/lib/aspell-0.60/de_DE")
 '(menu-bar-mode nil)
 '(message-send-mail-function (quote smtpmail-send-it))
 '(newsticker-url-list (quote (("GitHub" "https://github.com/domachine.atom" nil nil nil))))
 '(newsticker-url-list-defaults nil)
 '(org-agenda-include-diary t)
 '(org-file-apps (quote ((auto-mode . emacs) ("\\.mm\\'" . default) ("\\.x?html?\\'" . default) ("\\.pdf\\'" . "DISPLAY=:0 xpdf %s"))))
 '(org-startup-with-inline-images t)
 '(scroll-bar-mode nil)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(w3m-default-display-inline-images t nil nil "Show images in w3m"))
