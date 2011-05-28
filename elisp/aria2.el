;; -*- compile-command: "emacs -batch -Q --eval '(byte-compile-file \"aria2.el\")'" -*-

(defvar aria2-host "localhost")
(defvar aria2-suffix "/rpc")
(defvar aria2-port 6800)

(defun aria2-generate-http-header (fields)
  (save-excursion
    (insert (format "POST %s HTTP/1.1\nHost: %s\n"
                    (or aria2-suffix "/") aria2-host))
    (dolist (field fields)
      (insert (format "%s: %s\n" (car field) (cdr field))))

    (insert "\n")))

(defun aria2-xmlrpc-marshall-value (value)
  (insert "<value>")
  (cond ((listp value)
         (insert "<array><data>")
         (dolist (v value)
           (aria2-xmlrpc-marshall-value v))
         (insert "</data></array>"))

        ((stringp value)
         (insert (format "<string>%s</string>" value)))

        ((numberp value)
         (if (string-match "^[0-9]+.[0-9]+$" (number-to-string value))
             (insert (format "<double>%f</double>" value))
           (insert (format "<int>%d</int>" value)))))
  (insert "</value>"))

(defun aria2-xmlrpc-encode (method &rest arguments)
  (interactive "sMethod: \nsArg: ")

  (save-excursion
    (let ((beginning (point)))

      (insert "<?xml version=\"1.0\"?><methodCall>")
      (insert (format "<methodName>%s</methodName>" method))
      (insert "<params>")

      (dolist (argument arguments)
        (insert "<param>")
        (aria2-xmlrpc-marshall-value argument)
        (insert "</param>"))

      (insert "</params></methodCall>")

      ;; Return length of the POST block.
      (- (point) beginning))))

(defun aria2-xmlrpc-call-method (method &rest arguments)
  (with-temp-buffer
    (let ((length (apply 'aria2-xmlrpc-encode method arguments)))
      (aria2-generate-http-header `(("Content-Length" . ,length)
                                    ("Transfer-Encoding". "UTF-8"))))

    (let* ((process-connection-type nil)
           (process (open-network-stream "aria2-xmlrpc"
                                         (generate-new-buffer "*aria2 method transaction*")
                                         aria2-host aria2-port)))

      (process-send-region process 1 (point-max))
      (set-window-buffer (selected-window) (process-buffer process)))))

(defun aria2-add-download ())
