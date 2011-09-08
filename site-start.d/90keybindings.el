(global-set-key (kbd "C-c C-S-q") 'quit-window)
(global-set-key (kbd "C-c C-v") 'quit-window)

(global-set-key (kbd "C-c C-x") 'list-processes)

;; Keymapping to insert „ and ” easily
(global-set-key (kbd "C-x \"")
                (lambda (prefix)
                  (interactive "P")
                  (if prefix
                      (ucs-insert "201D")
                    (ucs-insert "201E"))))
(global-set-key (kbd "<f2>") #'newsticker-plainview)
(global-set-key (kbd "<f3>") #'newsticker-treeview)

(global-set-key (kbd "C-M-^") 'scroll-other-window-down)
