#!/usr/bin/env ruby
require_relative "lib/lisp-v1"

sum = L '+', 5, 5
mul = L '*', 10, sum

Lisp.eval mul

mul = L '*', 7, 6
Lisp.eval L :println, mul # Imprime 42
