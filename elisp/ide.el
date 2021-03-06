;; Turns emacs into an eclipse-like ide.

(defun init-ide ()
  (interactive)
  (compile "make -k")
  (delete-other-windows)
  (split-window-vertically)
  (other-window 1)
  (shrink-window 15)
  (switch-to-buffer "*compilation*")
  (split-window-horizontally)
  (other-window 1)
  (shell)
  (other-window 1)
)
