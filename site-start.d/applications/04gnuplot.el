(require 'gnuplot)

(global-set-key [(f9)] 'gnuplot-make-buffer)
(add-hook 'gnuplot-mode-hook
          (lambda ()
            (define-key gnuplot-mode-map
              (kbd "C-c C-c") 'gnuplot-buffer-fn)))

(autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)
(autoload 'gnuplot-make-buffer "gnuplot" "open a buffer in gnuplot mode" t)

;; Automode entries
(add-to-list 'auto-mode-alist '("\\.gp$" . gnuplot-mode))
