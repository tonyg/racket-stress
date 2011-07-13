#lang racket

(require racket/udp)

(define sock (udp-open-socket))

(udp-bind! sock #f 8888)

(display "Will start receiving in 10 seconds\n")
(sleep 9)
(display "One second left!\n")
(sleep 1)
(let ((buffer (make-bytes 65536)))
  (let loop ((total-packets 0) (total-bytes 0))
    (let-values (((packet-length source-hostname source-port) (udp-receive! sock buffer)))
      (display (list total-packets total-bytes))
      (newline)
      (loop (+ total-packets 1) (+ total-bytes packet-length)))))
