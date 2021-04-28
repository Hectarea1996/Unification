#lang racket


; var?
(define var? memq)

; atom?
(define (atom? v)
  (and (not (null? v))
       (not (pair? v))))

; bound?
(define (bound? v subst)
  (assq v subst))

; lookup
(define (lookup var subst)
  (cdr (assq var subst)))

; extend-subst
(define (extend-subst var val subst)
  (cons (cons var val) subst))

; occurs-in?
(define (occurs-in? var x subst)
  (cond
    [(equal? var x) #t]
    [(bound? x subst) (occurs-in? var (lookup x subst) subst)]
    [(pair? x) (or (occurs-in? var (car x) subst)
                   (occurs-in? var (cdr x) subst))]
    [else #f]))

; unify-variable
(define (unify-variable var val vars subst fail)
  (cond
    [(equal? var val) subst]
    [(bound? var subst) (unify vars (lookup var subst) val subst)]
    [(and (var? val vars) (bound? val subst)) (unify vars var (lookup val subst) subst)]
    [(occurs-in? var val subst) fail]
    [else (extend-subst var val subst)]))


; unify
(define (unify vars expr1 expr2 [subst null])

  (define-values (fail fail?) (values #f false?))
  
  (cond
    [(equal? expr1 expr2) subst]
    [(fail? subst) fail]
    [(var? expr1 vars) (unify-variable expr1 expr2 vars subst fail)]
    [(var? expr2 vars) (unify-variable expr2 expr1 vars subst fail)]
    [(or (atom? expr1) (atom? expr2)) fail]
    [else (unify vars (cdr expr1) (cdr expr2) (unify vars (car expr1) (car expr2) subst))]))


; Examples
(unify '(X) 'X 'a)

(unify '(X Y) 'X 'Y)

(unify '(X Y) '(p X Y) '(p Y X))

(unify '(X Y) '(p X Y a) '(p Y X X))

(unify '(X Y Z) '(q (p X Y) (p Y X)) '(q Z Z)) 