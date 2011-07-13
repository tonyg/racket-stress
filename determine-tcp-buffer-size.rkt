#lang racket

(require racket/tcp)

(define listener (tcp-listen 8888 4 #t))

(display "Listening\n")
(define-values (i o) (tcp-accept listener))
(file-stream-buffer-mode i 'none)
(display "Accepted, sleeping 10\n")
(sleep 10)
(display "Reading chunk\n")
(let ((chunk (read-bytes (* 128 1024 1024) i)))
  (display (bytes-length chunk)))
