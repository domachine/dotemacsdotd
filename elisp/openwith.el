;;; openwith.el --- Open files with external programs

;; Copyright (C) 2007  Markus Triska

;; Author: Markus Triska <markus.triska@gmx.at>
;; Keywords: files, processes

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; This lets you associate external applications with files so that
;; you can open them via C-x C-f, with RET in dired, etc.

;; Copy openwith.el to your load-path and add to your .emacs:

;;    (require 'openwith)
;;    (openwith-mode t)

;; To customize associations etc., use:

;;    M-x customize-group RET openwith RET

;;; Code:

(defconst openwith-version "0.8f")

(defgroup openwith nil
  "Associate external applications with file name patterns."
  :group 'files
  :group 'processes)

(defcustom openwith-associations
  '(("\\.pdf\\'" . "acroread")
    ("\\.mp3\\'" . "xmms")
    ("\\.\\(?:mpe?g\\|avi\\|wmv\\)\\'" . "mplayer")
    ("\\.\\(?:jp?g\\|png\\)\\'" . "display"))
  "Associations of file patterns to external programs.
File pattern is a regular expression describing the files to
associate with a program. The program arguments are a list of
strings and symbols and are passed to the program on invocation,
where the symbol 'file' is replaced by the file to be opened."
  :group 'openwith)

(defcustom openwith-confirm-invocation nil
  "Ask for confirmation before invoking external programs."
  :group 'openwith
  :type 'boolean)

(defun openwith-file-handler (operation &rest args)
  "Open file with external program, if an association is configured."
  (try 'break
       (when (and openwith-mode (not (buffer-modified-p)) (zerop (buffer-size)))
         (let ((assocs openwith-associations)
               (file (car args))
               oa)
           ;; do not use `dolist' here, since some packages (like cl)
           ;; temporarily unbind it
           (while assocs
             (setq oa (car assocs)
                   assocs (cdr assocs))
             (when (save-match-data (string-match (car oa) file))
               (when (or (not openwith-confirm-invocation)
                         (y-or-n-p (format "%s %s? " (cadr oa)
                                           (mapconcat #'identity params " "))))
                 (message "%s" (replace-regexp-in-string (cdr oa) "%s"
                                                         (shell-quote-argument file) t t))
                 (start-process-shell-command
                  "openwith-process" nil
                  (replace-regexp-in-string "%s"
                                            (shell-quote-argument file)
                                            (cdr oa) t t))
                 (kill-buffer nil)
                 ;; inhibit further actions
                 (throw 'break))))))
       ;; when no association was found, relay the operation to other handlers
       (let ((inhibit-file-name-handlers
              (cons 'openwith-file-handler
                    (and (eq inhibit-file-name-operation operation)
                         inhibit-file-name-handlers)))
             (inhibit-file-name-operation operation))
         (apply operation args))))

;;;###autoload
(define-minor-mode openwith-mode
  "Automatically open files with external programs."
  :lighter ""
  :global t
  (if openwith-mode
      (progn
        ;; register `openwith-file-handler' for all files
        (put 'openwith-file-handler 'safe-magic t)
        (put 'openwith-file-handler 'operations '(insert-file-contents))
        (add-to-list 'file-name-handler-alist '("" . openwith-file-handler)))
    (setq file-name-handler-alist
          (delete '("" . openwith-file-handler) file-name-handler-alist))))

(provide 'openwith)

;;; openwith.el ends here
