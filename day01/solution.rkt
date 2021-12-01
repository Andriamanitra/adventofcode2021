#lang racket

(define input (map string->number (file->lines "input.txt")))

(define part1-answer
  (for/sum ([a input]
            [b (cdr input)]
            #:when (> b a))
    1))

(define part2-answer
  (for/sum ([a input]
            [b (cdddr input)]
            #:when (> b a))
    1))

(println part1-answer)
(println part2-answer)
