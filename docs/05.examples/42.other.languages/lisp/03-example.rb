#!/usr/bin/env ruby

require "lisp"

puts Lisp.eval(<<-eos
  (begin
    (define fact
      (lambda (n)
        (if (<= n 1)
          1
          (* n (fact (- n 1))))))
    (fact 10))
  eos
)

# => 3628800
