(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(global-set-key (kbd "C-c C-r") 'org-remember)

(global-set-key (kbd "<XF86AudioPlay>") 'emms-start)
(global-set-key (kbd "<XF86AudioStop>") 'emms-pause)
(global-set-key (kbd "<XF86AudioNext>") 'emms-next)
(global-set-key (kbd "<XF86AudioPrev>") 'emms-previous)

(global-set-key (kbd "C-c C-S-q") 'quit-window)
(global-set-key (kbd "C-c C-v") 'quit-window)

(global-set-key [(f9)] 'gnuplot-make-buffer)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(global-set-key (kbd "C-c C-x") 'list-processes)

(global-set-key (kbd "C-x \"")
                (lambda (prefix)
                  (interactive "P")
                  (if prefix
                      (ucs-insert "201F")
                    (ucs-insert "201D"))))

(global-set-key (kbd "C-M-^") 'scroll-other-window-down)
