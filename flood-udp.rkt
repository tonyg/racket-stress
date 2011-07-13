#lang racket

(require racket/udp)

(require (planet tonyg/bitsyntax))

(define outbound-length (string->number (vector-ref (current-command-line-arguments) 0)))
(define packet (bit-string->bytes
		(do ((i 0 (+ i 1))
		     (acc (bytes) (bit-string-append acc (bit-string (i : bytes 4)))))
		    ((= i (/ outbound-length 4)) acc))))

(define sock (udp-open-socket))

(udp-bind! sock #f 0)

(printf "Flooding now with ~v-byte packets...\n" outbound-length)
(let loop ()
  (udp-send-to sock "localhost" 8888 packet)
  (loop))
