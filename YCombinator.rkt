#lang racket


(define (rec f)
  (lambda (x) (f (lambda () (x x)))))

(define (Y f)
  ((rec f) (rec f)))

(define (fact-step supply-f)
  (lambda (n)
    (if (zero? n)
        1
        (* n ((supply-f) (sub1 n))))))


((Y fact-step) 5)