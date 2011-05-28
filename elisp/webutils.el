(require 'url)

(defun find-remote-file (addr)
  (interactive "sUrl: ")
  (message "Retrieving url ...")
  (let ((buffer (url-retrieve-synchronously addr)))
    (if buffer
        (progn
          (message "Download successfully finished")
          (with-current-buffer buffer
            (buffer-enable-undo)
            (fundamental-mode)
            (font-lock-fontify-buffer))
          (set-window-buffer (selected-window) buffer))
      (message "Download failed"))))

(require 'w3m)

(defun url-decode (addr)
  (interactive "sUrl: ")
  (with-current-buffer (get-buffer-create "*scratch*")
    (insert (w3m-url-decode-string addr))))

(provide 'webutils)