(require 'rmail)

(setq user-mail-address "dominik.burgdoerfer@googlemail.com")
(setq smtpmail-auth-credentials "~/.authinfo")
(setq smtpmail-default-smtp-server "smtp.gmail.com")
(setq smtpmail-local-domain "gmail.com")
(setq smtpmail-smtp-service 587)
(setq smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil)))

(setq display-time-mail-file "/var/spool/mail/dominik")

(setq rmail-delete-after-output t)
(setq rmail-file-name "~/Mail/RMAIL")

(setq rmail-output-file-alist
      '(("<\\(update\\|notification\\)\\+[^@]+@facebookmail.com>" .
         "~/Mail/FACEBOOK")
        ("^To: .?studierende@uni-ulm.de" . "~/Mail/UNI")
        ("[xX][\\-_][aA][cC][tT]" . "~/Mail/X_ACT")
        ("^From: Campact <info@campact.de>$" . "~/Mail/CAMPACT")))

;; Little hack to get a summary on every rmail-call.
(defadvice rmail-quit (around rmail-kill-on-exit activate)
  (let ((my-rmail-buffer (current-buffer)))
    ad-do-it
    (kill-buffer my-rmail-buffer)))

(add-hook 'rmail-mode-hook
          'rmail-summary)

;; == BBDB ==
(require 'bbdb)
(bbdb-initialize)

;; == Diary / Calendar ==
(add-hook 'today-visible-calendar-hook 'calendar-mark-today)
(add-hook 'diary-list-entries-hook 'diary-sort-entries t)

(add-to-list 'auto-mode-alist '("\\*message\\*\\-[0-9-]+$" . message-mode))
