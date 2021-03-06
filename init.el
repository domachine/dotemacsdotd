
(defmacro user-file (file)
  `(concat (expand-file-name user-emacs-directory) ,file))

(defmacro site-load-file (file)
  `(load-file ,(concat (expand-file-name user-emacs-directory) "site-start.d/" file)))

(defmacro add-to-path (file)
  "Adds a file to the load-path"
  `(add-to-list 'load-path ,(user-file file)))


;; Set load-path.
(add-to-path "elisp")
(add-to-path "elisp/ajc-java-complete")
(add-to-path "elisp/org-mode")

;; Load macros to make config more comfortable.
(require 'site-utils)


(setq custom-file (concat user-emacs-directory "site-start.d/custom.el"))

;; Set auto-mode-alist.
(add-to-list 'auto-mode-alist '("\\*message\\*\\-[0-9-]+$" . message-mode))

;; Load color theme.
;;(when window-system
;;  (do-if-feature-exists solarized-dark-theme
;;                        (load-theme 'solarized-dark) ;;))

;; Load Applications and modes.
(load-feature ibuffer
              ;; Install keybinding for ibuffer (Replacing buffer-list)
              (global-set-key (kbd "C-x C-b") #'ibuffer))

(load-feature dired-x)
(load-feature bbdb
              (bbdb-initialize))

(load-feature auto-complete-config
              (ac-config-default)
              (ac-flyspell-workaround)
              ;; Fix xref bug.
              (require 'help-mode))

(load-feature ac-slime)
(load-feature yasnippet
              (yas/initialize)
              (yas/load-directory "~/.emacs.d/snippets"))

(do-if-feature-exists w3m
                      (setq newsticker-html-renderer 'w3m-region)
                      (autoload 'w3m "w3m" nil t)
                      (autoload 'w3m-region "w3m")
                      (autoload 'w3m-toggle-inline-image "w3m")
                      (autoload 'w3m-goto-url-new-session "w3m"))

(load-feature org-install
              (load-feature ob-tangle))

;;(load-feature openwith)

(do-if-feature-exists auctex
                      ;; Load AucTeX only if needed.
                      (autoload 'TeX-latex-mode "auctex" nil t)
                      (add-to-list 'auto-mode-alist '("\\.\\(tex\\|sty\\|cls\\)$" . TeX-latex-mode)))

(do-if-feature-exists garak
                      (autoload 'garak "garak" nil t))

(do-if-feature-exists passhash
                      (autoload 'passhash "passhash" nil t))

(do-if-feature-exists ajc-java-complete-config
                      (autoload 'ajc-java-complete-mode "ajc-java-complete-config"))

(do-if-feature-exists haskell-mode/haskell-mode
                      (autoload 'haskell-mode "haskell-mode/haskell-mode" nil t)
                      (add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode)))

;; Load include files.
(site-load-file "custom.el")
(site-load-file "email.el")
(site-load-file "shortcuts.el")
(site-load-file "hooks.el")

;; === Emacs core settings ===
;; Launch emacs editing server.
(server-start)

;; Save me from closing emacs accidentially
;;(add-to-list 'kill-emacs-query-functions
;;             (lambda ()
;;               (y-or-n-p "Do you really want to exit Emacs? ")))

;; Enabled commands.
(put 'dired-find-alternate-file 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'narrow-to-region 'disabled nil)
