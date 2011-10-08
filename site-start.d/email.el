
;; E-Mail settings.

(setq user-mail-address "dominik.burgdoerfer@googlemail.com")
(setq smtpmail-auth-credentials "~/.authinfo")
(setq smtpmail-default-smtp-server "smtp.gmail.com")
(setq smtpmail-local-domain "gmail.com")
(setq smtpmail-smtp-service 587)
(setq smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil)))

(setq display-time-mail-file "/var/spool/mail/dominik")
(setq rmail-file-name "~/Mail/RMAIL")

(setq rmail-output-file-alist
      '(("<\\(update\\|notification\\)\\+[^@]+@facebookmail.com>" .
         "~/Mail/FACEBOOK")
        ("@uni-ulm.de" . "~/Mail/UNI")
        ("[xX][\\-_][aA][cC][tT]" . "~/Mail/X_ACT")
        ("info@campact.de" . "~/Mail/CAMPACT")))
