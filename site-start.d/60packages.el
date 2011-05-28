;; == IDE ==
(load-library "ide")

;; == Fstab ==
(require 'fstab)

(setq fstab-short-cuts
      '(usb "/dev/sdb"
        cd  "/dev/scd0"))

(require 'burn)

;; == Dired x ==
(require 'dired-x)

;; == Remember ==
(org-remember-insinuate)

;; == BBDB ==
(require 'bbdb)
(bbdb-initialize)
;;(add-hook 'rmail-mode-hook 'bbdb-insinuate-rmail)

;; == Diary / Calendar ==
(add-hook 'today-visible-calendar-hook 'calendar-mark-today)
(add-hook 'diary-list-entries-hook 'diary-sort-entries t)

;; == Ftputils ==
(autoload 'ftp-upload-file-list "ftputils" "Ftp-Utils" "sBookmark: ")

;; == YouTube ==
(autoload 'youtube-video-url "youtube" "Youtube-Hack" "sUrl: ")
(autoload 'youtube-search "youtube" "YouTube search" "sSearch query: ")

;; == Webutils ==
(require 'webutils)

;; == War driving ==
;; (autoload 'launch-war-drive-mode "war-drive"
;;   "Turn emacs into a real war-driving tool to sniff all surrounding
;; http requests in order to parse out the cookies they carry." t)

;; == Eclipse exporter ==
(setq eclipse-exporter-program
      (expand-file-name "~/Workspace/eclipse-fake/eclipse-fake.sh"))

;; == W3M ==
(require 'w3m)

;; == MPD ==
;;(require 'mpc)
(require 'emms-setup)
(emms-standard)
(emms-default-players)

(add-hook 'emms-player-started-hook 'emms-show)


;; == Blog tools ==
(setq website-blogs '((news "~/Workspace/homepage"
                            "news_blog_index.m4"
                            "blog")
                      (emacs "~/Workspace/homepage"
                             "emacs_blog_index.m4"
                             "emacs-blog")))

(require 'website-utils)

;; == GNUPlot ==
(autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)
(autoload 'gnuplot-make-buffer "gnuplot" "open a buffer in gnuplot mode" t)

;; == IBuffer ==
;; Replace Buffer list with Ibuffer
(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (ibuffer-switch-to-saved-filter-groups "default")))
(add-hook 'ibuffer-mode-hook
	  '(lambda ()
	     (ibuffer-auto-mode 1)
	     (ibuffer-switch-to-saved-filter-groups "default")))

(require 'git)
