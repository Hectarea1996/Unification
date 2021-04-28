#lang scribble/manual

#lang scribble/manual
@(require (for-label racket))

@title{Unification}

Unification is an algorithm for solving symbolic equations problems. Given two expressions and some variables,
the unification looks for values that can match the given variables to satisfy the equation.