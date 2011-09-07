;; == IDE ==
(load-library "ide")

;; == Fstab ==
(require 'fstab)

(setq fstab-short-cuts
      '(usb "/dev/sdb"
        cd "/dev/scd0"))

(require 'burn)

;; == Dired x ==
(require 'dired-x)

;; == Remember ==
(org-remember-insinuate)

;; == Ftputils ==
(autoload 'ftp-upload-file-list "ftputils" "Ftp-Utils" "sBookmark: ")

;; == YouTube ==
(autoload 'youtube-video-url "youtube" "Youtube-Hack" "sUrl: ")
(autoload 'youtube-search "youtube" "YouTube search" "sSearch query: ")

;; == Webutils ==
(autoload 'find-remote-file "webutils"
  "Useful function for opening remote files." "sUrl: ")
(autoload 'url-decode "webutils"
  "Decode urls easily." "sUrl: ")

;; == War driving ==
;; (autoload 'launch-war-drive-mode "war-drive"
;; "Turn emacs into a real war-driving tool to sniff all surrounding
;; http requests in order to parse out the cookies they carry." t)

;; == Eclipse exporter ==
(setq eclipse-exporter-program
      (expand-file-name "~/Workspace/eclipse-fake/eclipse-fake.sh"))

;; == W3M ==
(require 'w3m)

;; == Blog tools ==
(setq website-blogs '((news "~/Workspace/homepage"
                            "news_blog_index.m4"
                            "blog")
                      (emacs "~/Workspace/homepage"
                             "emacs_blog_index.m4"
                             "emacs-blog")))

(require 'website-utils)

(require 'git)

;; == Games ==
(setq tetris-score-file "/home/dominik/.emacs.d/tetris-score")

(add-hook 'dired-mode-hook 'dired-omit-mode)

;; == Newsticker ==
(require 'newsticker)

(setq newsticker-url-list '(("Thomas Activity" "https://github.com/lordmalak.atom" nil nil nil)
                            ("Tagesschau" "http://www.tagesschau.de/newsticker.rdf" nil nil nil)))
(setq newsticker-url-list-defaults nil)
(setq newsticker-html-renderer 'w3m-region)
