#!/usr/bin/env ruby
require_relative "lib/lisp-v1"

# Usamos el método de ayuda 'L' para simular los paréntesis de Lisp
# Ejemplo: (* 10 (+ 5 5))
expresion = L('*', 10, L('+', 5, 5))

Lisp.eval(expresion) # => 100

Lisp.eval L(:println, L('*', 7, 6)) # Imprime 42
