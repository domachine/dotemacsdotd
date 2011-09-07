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

;; The pretty cool auctex extension.
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
