(require 'cl)

(defmacro user-file (file)
  `(concat (expand-file-name user-emacs-directory) ,file))

(defmacro site-load-file (file)
  `(load-file ,(concat (expand-file-name user-emacs-directory) "site-start.d/" file)))

(defmacro do-if-feature-exists (feature &rest body)
  "Executes body only if feature file was found in load-path.
In fact a file of the form: <feature>.el or <feature>.elc"
  (let ((dir (gensym))
        (src-file (gensym))
        (c-file (gensym)))
    `(catch 'break
       (dolist (,dir load-path)
         (let* ((,src-file (concat ,dir "/" (symbol-name ,feature) ".el"))
                (,c-file (concat ,src-file "c")))
           (when (or (file-exists-p ,src-file) (file-exists-p ,c-file))
             ,@body
             (throw 'break nil)))))))

(defmacro load-feature (feature &rest initialization)
  "Loads the given feature and executes the initialization code
if the feature is existent."

  `(condition-case nil
       (progn
         (require ,feature)
         ,@initialization)
     (error)
     nil))


(setq custom-file (concat user-emacs-directory "site-start.d/custom.el"))

;; Set load-path.
(add-to-list 'load-path (user-file "elisp"))

;; Set auto-mode-alist.
(add-to-list 'auto-mode-alist '("\\*message\\*\\-[0-9-]+$" . message-mode))

;; Load Applications and modes.
(load-feature 'ibuffer
              ;; Install keybinding for ibuffer (Replacing buffer-list)
              (global-set-key (kbd "C-x C-b") #'ibuffer))

(load-feature 'dired-x)
(load-feature 'bbdb
              (bbdb-initialize))

(do-if-feature-exists 'w3m
                      (setq newsticker-html-renderer 'w3m-region)
                      (autoload 'w3m "w3m" nil t)
                      (autoload 'w3m-region "w3m")
                      (autoload 'w3m-toggle-inline-image "w3m"))

(do-if-feature-exists 'auctex
                      ;; Load AucTeX only if needed.
                      (autoload 'TeX-latex-mode "auctex" nil t)
                      (add-to-list 'auto-mode-alist '("\\.\\(tex\\|sty\\|cls\\)$" . TeX-latex-mode)))

;; Load include files.
(site-load-file "custom.el")
(site-load-file "email.el")
(site-load-file "keybindings.el")
(site-load-file "hooks.el")

;; Use color theme if existent.
(load-feature 'color-theme
              (color-theme-initialize)
              (color-theme-matrix))


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
