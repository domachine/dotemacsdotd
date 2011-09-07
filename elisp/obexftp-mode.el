(defun obex-test-callback (queue, answer)
  (let ((args (split-string answer "\n")))
    (dolist (arg args)
      (message arg "\n"))))

(defun obex-exit-callback (queue, answer)
  (let ((args (split-string answer "\n")))
    (message (car args) "\n")))

(defun obex-directory-listing (queue, answer)
  (let ((args (split-string answer "\n"))
        status
        directories)

    ;; Parse arguments.
    (setq status (car args))
    (setq directories (cdr args))
    (message status)

    (let ((output-buffer (generate-new-buffer "*Directory listing*")))
      (dolist (dir directories)
        (with-current-buffer output-buffer
          (insert dir "\n")))
      (set-window-buffer (selected-window) output-buffer))))

(defun test-emacs-obex-server ()
  (interactive)
  (let ((command (expand-file-name "~/Workspace/obexftpc/src/a.out"))
        process
        (process-connection-type nil)
        queue)
    (setq process (start-process "emacs-obexftp" nil command))
    (setq queue (tq-create process))
    (tq-enqueue queue "TEST\n\n" "\n\n" queue (function obex-test-callback))
    (tq-enqueue queue "DIRLIST\n/Pictures\n\n" "\n\n" queue (function obex-directory-listing))
    (tq-enqueue queue "EXIT\n\n" "\n\n" queue (function obex-exit-callback))))

(define-derived-mode obexftp-mode fundamental-mode
  (setq mode-name "obexftp mode"))

(defun bt-call-bluez (path interface method &rest args)
  (apply 'dbus-call-method :session
         "org.bluez"
         path interface method args))

(defun bt-device-found (address, class, rssi)
  (message "Device found: %s, class: %d, rssi: %d" class rssi))

(defun bt-discover-devices ()
  (interactive)
  (let ((sig (dbus-register-signal :session
                                   "org.bluez"
                                   "/org/bluez/hci0"
                                   "org.bluez.Adapter"
                                   "RemoteDeviceFound" 'bt-device-found)))

    (bt-call-bluez "/org/bluez/hci0"
                   "org.bluez.Adapter"
                   "DiscoverDevices")

    (dbus-unregister-signal sig)))

(provide 'obexftp-mode)
