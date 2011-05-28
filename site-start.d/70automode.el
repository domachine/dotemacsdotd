(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))

(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))

(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                ("\\.cmake\\'" . cmake-mode))
              auto-mode-alist))

(add-to-list 'auto-mode-alist '("\\.gp$" . gnuplot-mode))
