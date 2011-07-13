#lang racket

(require (planet tonyg/bitsyntax))

(do ((i 0 (+ i 1)))
    (#f)
  (write-bytes (bit-string (i : bits 32))))
