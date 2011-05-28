(require 'xmltok)
(require 'xml)
(require 'shell)

(defvar youtube-stream-handler 'browse-url
  "The function to call with the discovered video-url.")

(defun youtube-clear-cache ()
  (interactive)
  (dolist (file (file-expand-wildcards "/tmp/youtube*"))
    (delete-file file)))

(defun youtube-nuke-aria-buffers ()
  (interactive)
  (dolist (buffer (buffer-list))
    (when (string-match "^\\*aria2\\*\\: \\/tmp\\/youtube.*$" (buffer-name buffer))
      (kill-buffer buffer))))

(defun youtube-nuke-and-clear ()
  (interactive)
  (youtube-nuke-aria-buffers)
  (youtube-clear-cache))

(defun download-video (url)
  (let ((temp-file (make-temp-file "youtube")))
    (let ((buffer (generate-new-buffer (concat "*aria2*: " temp-file)))
          (out-dir (file-name-directory temp-file))
          (out-file (file-name-nondirectory temp-file)))

      (with-current-buffer buffer
        (erase-buffer))

      (let ((process (start-process "aria2" buffer
                                    "aria2c" "-s" "15" "-j" "15" "-x" "15"
                                    "--allow-overwrite=true"
                                    "-d" out-dir "-o" out-file url)))
        (with-current-buffer buffer
          (shell-mode)))

      (run-at-time "5 sec" nil 'async-shell-command
                   (format "mplayer -fs %s"
                           (shell-quote-argument temp-file))))))

(setq youtube-stream-handler 'download-video)

;;;###autoload
(defun youtube-video-url (addr)
  (interactive "sUrl: ")
  (message "Retrieving url ...")
  (let (video-url)
    (with-temp-buffer
      (call-process-shell-command (format "wget -O - %s 2>/dev/null"
                                          (shell-quote-argument addr))
                    nil (current-buffer) nil)

      (beginning-of-buffer)
      (search-forward-regexp "|\\(http:[^|]+id=[^,|]+\\)|")
      (setq video-url (replace-regexp-in-string (match-string 1) "\\\\/" "/"))
      (setq video-url (replace-regexp-in-string video-url "\\\\u0026" "&"))

      (funcall youtube-stream-handler video-url))))

(defun youtube-watch-video-at-point ()
  "Watch the video with the url the cursor points at."

  (interactive)
  (let ((video-url (thing-at-point 'url)))
    (unless (and video-url
                (string-match "^http:\\/\\/www\\.youtube\\.com\\/watch" video-url))
      (error "No video url at point"))
    (youtube-video-url video-url)))

(defun kill-current-buffer ()
  "Little hack to quit youtube search."

  (interactive)
  (kill-buffer (current-buffer)))

(define-derived-mode youtube-mode org-mode "YouTube search results"
  "YouTube mode\n\n\\{youtube-mode-map}"

  (setq buffer-read-only t)
  (setq truncate-lines nil)

  (make-local-variable 'youtube-feed)
  (setq youtube-feed nil)

  (define-key youtube-mode-map (kbd "RET") 'youtube-watch-video-at-point)
  (define-key youtube-mode-map (kbd "n") 'youtube-next-page)
  (define-key youtube-mode-map (kbd "p") 'youtube-previous-page)
  (define-key youtube-mode-map (kbd "s") 'youtube-search)
  (define-key youtube-mode-map (kbd "s") 'youtube-search)
  (define-key youtube-mode-map (kbd "q") 'kill-current-buffer))

(defun xml-node-first-child (node)
  (car (xml-node-children node)))

(defun youtube-render-results (url)
  (let ((buffer (url-retrieve-synchronously url)))
    (unless buffer
      (error "Download failed."))

    (with-current-buffer buffer
      (beginning-of-buffer)
      (while (search-forward "'" nil t)
        (replace-match "\""))

      (beginning-of-buffer)
      (unless (xmltok-forward)
        (error "Empty response received"))
      (let ((output-buffer (get-buffer-create "*Youtube*"))
            (feed-node (xml-parse-tag))
            (feed-object (make-hash-table)))

        (with-current-buffer output-buffer
          (setq buffer-read-only nil)
          (erase-buffer))

        (dolist (node (xml-node-children feed-node))
          (cond ((eq (xml-node-name node) 'link)
                 (cond ((equal (xml-get-attribute-or-nil node 'rel) "self")
                        ;; Put self reference into feed-object.
                        (puthash 'self (xml-get-attribute-or-nil node 'href) feed-object))

                       ((equal (xml-get-attribute-or-nil node 'rel) "next")
                        ;; Put next reference into feed-object.
                        (puthash 'next (xml-get-attribute-or-nil node 'href) feed-object))

                       ((equal (xml-get-attribute-or-nil node 'rel) "previous")
                        ;; Put previous reference into feed-object.
                        (puthash 'previous
                                 (xml-get-attribute-or-nil node 'href) feed-object))))

                ((eq (xml-node-name node) 'openSearch:startIndex)
                 (puthash 'start-index (xml-node-first-child node) feed-object))

                ((eq (xml-node-name node) 'openSearch:itemsPerPage)
                 (puthash 'items-per-page (xml-node-first-child node) feed-object))

                ((eq (xml-node-name node) 'openSearch:totalResults)
                 (puthash 'total-results (xml-node-first-child node) feed-object))

                ((eq (xml-node-name node) 'entry)
                 (let ((entry (make-hash-table))
                       (children (xml-node-children node))
                       (title "")
                       (id "")
                       (content "")
                       (href ""))

                   (dolist (child children)
                     (cond ((eq (xml-node-name child) 'title)
                            (puthash 'title (xml-node-first-child child) entry))

                           ((eq (xml-node-name child) 'id)
                            (puthash 'id (xml-node-first-child child) entry))

                           ((eq (xml-node-name child) 'content)
                            (puthash 'content (xml-node-first-child child) entry))

                           ((eq (xml-node-name child) 'link)
                            (let ((rel-attr (xml-get-attribute-or-nil child 'rel)))
                              (when (and rel-attr (equal rel-attr "alternate"))
                                (puthash 'href
                                         (xml-get-attribute-or-nil child 'href) entry)))))

                     ;; Add entry to feed-object
                     (puthash 'entries
                              (append (gethash 'entries feed-object) (list entry))
                              feed-object))

                   (with-current-buffer output-buffer
                     (insert (format "* %s\n[[%s]]\n** Description\n%s\n\n"
                                     (gethash 'title entry) (gethash 'href entry)
                                     (gethash 'content entry))))))))

        (with-current-buffer output-buffer
          (insert (format "\n* *Total*: %s, *Index*: %s"
                          (gethash 'total-results feed-object)
                          (gethash 'start-index feed-object)))
          (beginning-of-buffer)
          (youtube-mode)
          (setq youtube-feed feed-object))
        (set-window-buffer (selected-window) output-buffer)
        output-buffer))))

(defun youtube-next-page ()
  (interactive)
  (when youtube-feed
    (let ((next-ref (gethash 'next youtube-feed)))
      (unless next-ref
        (error "No next reference available"))
      (youtube-render-results next-ref))))

(defun youtube-previous-page ()
  (interactive)
  (unless youtube-feed
    (error "No feed loaded"))
  (let ((prev-ref (gethash 'previous youtube-feed)))
    (unless prev-ref
      (error "No previous reference available"))

    (youtube-render-results prev-ref)))

;;;###autoload
(defun youtube-search (query)
  (interactive "sSearch query: ")
  (message "Retrieving search results ...")
  (youtube-render-results (format
                           "http://gdata.youtube.com/feeds/api/videos?q=%s&strict=true"
                           (w3m-url-encode-string query))))
