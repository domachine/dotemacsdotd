(require 'mpc)

(define-key mpc-songs-mode-map (kbd "<RET>") 'mpc-play-at-point)
(define-key mpc-songs-mode-map (kbd "a") 'mpc-playlist-add)
