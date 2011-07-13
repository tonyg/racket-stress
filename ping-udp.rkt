#lang racket

(require racket/udp)

(define sock (udp-open-socket))

(udp-bind! sock #f 0)

(udp-send-to sock "localhost" 8888 #"hello world")

(let ((buffer (make-bytes 65536)))
  (let-values (((packet-length source-hostname source-port) (udp-receive! sock buffer)))
    (write (list source-hostname source-port (subbytes buffer 0 packet-length)))
    (newline)))
