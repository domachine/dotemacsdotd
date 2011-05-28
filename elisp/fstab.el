;; Helper functions for mounting fstab-registered devices.


;; Reads all available devices from fstab and puts them
;; into a hash.
(defun get-device-hash ()
  (let ((devices (make-hash-table :test 'equal)))
    (with-temp-buffer
      (insert-file "/etc/fstab")
      (while (re-search-forward "^ *\\([0-9a-zA-Z\\/\\.]+\\) *\\([a-zA-Z\\/]+\\).*$"
                                nil t)
        (puthash (match-string 1) (match-string 2) devices)))
    devices))

(defun mount-device (device)
  (interactive "sDevice to mount: ")
  (let ((devices (get-device-hash))  ; Get device from fstab
        selected-device
        command-result)

    (setq selected-device (gethash device devices))

    (unless selected-device
      ;; Unable to find device through normal fstab lookup.
      ;; Maybe it's a user defined short-cut.

      (when (boundp 'fstab-short-cuts)
        (let ((short-cut (plist-get fstab-short-cuts (intern device))))
          (when short-cut
            ;; Short-cut found.
            (setq device short-cut)
            (setq selected-device (gethash short-cut devices))))))

    (unless selected-device
      (error "Device not in fstab found!"))

    ;; Mount device and grab return code.
    (setq command-result
          (shell-command (concat "mount " device)))

    (when (eq command-result 0)
      ;; Show the device content.
      (dired selected-device))))

;; Makes sure, that a directory doesn't end with `/'.
(defun normalize-file-path (path)
  (if (string= (substring path -1) "/")
      (substring path 0 -1)
    path))

(defun umount-device (device)
  (interactive "FThe device or mount-point to umount: ")
  (let ((dired-path "")
        command-result)

    (when (string= major-mode "dired-mode")
      ;; Get filename of current dired buffer
      (save-excursion
        (beginning-of-buffer)
        (when (re-search-forward "^ *\\([a-zA-Z0-9\\/\\.\\-]+\\):$" nil t)
          (setq dired-path (normalize-file-path (match-string 1))))))

    ;; Expand device path
    (setq device (normalize-file-path (expand-file-name device)))

    (if (and (not (string= dired-path "")) (string= dired-path device))
        (kill-buffer))

    ;; Umount device
    (shell-command (concat "umount " device))))

(provide 'fstab)
