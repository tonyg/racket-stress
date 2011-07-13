#lang racket

(require racket/tcp)

(define listener (tcp-listen 8888 4 #t))

(define (connection-main i o)
  (lambda ()
    (let loop ()
      (let ((chunk (read-bytes 4096 i)))
	(if (eof-object? chunk)
	    (begin (close-input-port i)
		   (close-output-port o)
		   'done)
	    (begin (write-bytes chunk o)
		   (loop)))))))

(let loop ()
  (let-values (((i o) (tcp-accept listener)))
    (thread (connection-main i o))
    (loop)))
