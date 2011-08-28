;; == Load path ==
(add-to-list 'load-path (concat user-emacs-directory "elisp"))
(add-to-list 'load-path "/usr/share/emacs/site-lisp/bbdb")
(add-to-list 'load-path (concat user-emacs-directory "elisp/org-mode"))

(require 'color-theme)
(color-theme-initialize)
(color-theme-matrix)

;; Load CEDET.
;; See cedet/common/cedet.info for configuration details.
;;(load-file (concat user-emacs-directory "elisp/cedet/common/cedet.el"))


;; Enable EDE (Project Management) features
;;(global-ede-mode 1)

;; Enable EDE for a pre-existing C++ project
;; (ede-cpp-root-project "NAME" :file "~/myproject/Makefile")


;; Enabling Semantic (code-parsing, smart completion) features
;; Select one of the following:

;; * This enables the database and idle reparse engines
;;(semantic-load-enable-minimum-features)
