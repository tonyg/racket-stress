#lang racket

(require racket/tcp)

(define listener (tcp-listen 8888 4 #t))

(define counter
  (let ((v 0))
    (lambda ()
      (let ((n v))
	(set! v (+ v 1))
	n))))

(define (connection-main i o)
  (let ((id (counter)))
    (define (w f . vs)
      (apply printf (string-append "~v: " f) id vs))
    (w "Waiting 10 before starting thread and accepting again~n")
    (sleep 10)
    (lambda ()
      (let loop ()
	(sleep 1)
	(let ((ch (read-byte i)))
	  (if (eof-object? ch)
	      (begin (w "Goodbye!~n")
		     (close-input-port i)
		     (close-output-port o)
		     'done)
	      (begin (w "Got byte ~v~n" ch)
		     (loop))))))))

(let loop ()
  (let-values (((i o) (tcp-accept listener)))
    (thread (connection-main i o))
    (loop)))
