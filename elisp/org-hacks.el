(defun my-org-insert-heading (prefix)
  (interactive "P")
  (if prefix
      (org-insert-heading-respect-content)
    (org-insert-heading)))

(define-key org-mode-map (kbd "M-<RET>") #'my-org-insert-heading)
