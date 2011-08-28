;; -*- compile-command: "emacs -batch -Q --eval '(byte-compile-file \"aria2.el\")'" -*-

(require 'xml-rpc)

(defvar aria2-url "http://localhost:6800/rpc")

(defsubst aria2-call (callback method &rest params)
  (apply (function xml-rpc-method-call-async) callback aria2-url
         (intern (concat "aria2." (symbol-name method))) params))

(defun aria2-add-uri (uris &optional options position)
  (aria2-call (lambda (x)
                (message "res: %s" x))
              'bad))
              ;;'addDownload uris options position))

(aria2-add-uri '("http://google.de"))
