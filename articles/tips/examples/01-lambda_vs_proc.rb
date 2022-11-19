#!/usr/bin/env ruby
# https://twitter.com/zilkucinskas/status/1583020211724111875?t=IDK62oB5NGbQvfunXCUwnw&s=35
#
# lambdas vs procs
# * En lambdas, "return" significa "salir del lambda".
# * En los procs, "return" significa "salir del método".

def test
  -> {return 1}.call
  proc {return 2}.call
  return 3
end

puts test
# => 2
