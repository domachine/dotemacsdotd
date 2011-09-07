(require 'ibuffer)

(add-hook 'ibuffer-mode-hook
          '(lambda ()
             (ibuffer-auto-mode 1)
             (ibuffer-switch-to-saved-filter-groups "default")))

(setq ibuffer-expert t)
(setq ibuffer-show-empty-filter-groups nil)

;; Install keybinding for ibuffer (Replacing buffer-list)
(global-set-key (kbd "C-x C-b") 'ibuffer)
