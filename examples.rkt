#lang racket/base

(require "unification.rkt")



(unify '(X) 'X 'a)

(unify '(X Y) 'X 'Y)

(unify '(X Y) '(p X Y) '(p Y X))

(unify '(X Y) '(p X Y a) '(p Y X X))

(unify '(X Y Z) '(q (p X Y) (p Y X)) '(q Z Z)) 


