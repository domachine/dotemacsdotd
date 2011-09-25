
(defmacro user-file (file)
  `(concat (expand-file-name user-emacs-directory) ,file))

;; Set load-path.
(add-to-list 'load-path (user-file "elisp"))

;; Load macros to make config more comfortable.
(require 'site-utils)


(setq custom-file (concat user-emacs-directory "site-start.d/custom.el"))

;; Set auto-mode-alist.
(add-to-list 'auto-mode-alist '("\\*message\\*\\-[0-9-]+$" . message-mode))

;; Load Applications and modes.
(load-feature ibuffer
              ;; Install keybinding for ibuffer (Replacing buffer-list)
              (global-set-key (kbd "C-x C-b") #'ibuffer))

(load-feature dired-x)
(load-feature bbdb
              (bbdb-initialize))

(do-if-feature-exists w3m
                      (setq newsticker-html-renderer 'w3m-region)
                      (autoload 'w3m "w3m-load" nil t)
                      (autoload 'w3m-region "w3m")
                      (autoload 'w3m-toggle-inline-image "w3m"))

(do-if-feature-exists auctex
                      ;; Load AucTeX only if needed.
                      (autoload 'TeX-latex-mode "auctex" nil t)
                      (add-to-list 'auto-mode-alist '("\\.\\(tex\\|sty\\|cls\\)$" . TeX-latex-mode)))

(do-if-feature-exists mingus
                      (autoload 'mingus "mingus" nil t)
                      (global-set-key (kbd "<f5>") #'mingus))

;; Load include files.
(site-load-file "custom.el")
(site-load-file "email.el")
(site-load-file "shortcuts.el")
(site-load-file "hooks.el")

;; === Emacs core settings ===
;; Launch emacs editing server.
(server-start)

;; Save me from closing emacs accidentially
(add-to-list 'kill-emacs-query-functions
             (lambda ()
               (y-or-n-p "Do you really want to exit Emacs? ")))

;; Enabled commands.
(put 'dired-find-alternate-file 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'narrow-to-region 'disabled nil)
