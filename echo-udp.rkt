#lang racket

(require racket/udp)

(define sock (udp-open-socket))

(udp-bind! sock #f 8888)

(let ((buffer (make-bytes 65536)))
  (let loop ()
    (let-values (((packet-length source-hostname source-port) (udp-receive! sock buffer)))
      (udp-send-to sock source-hostname source-port buffer 0 packet-length)
      (loop))))
