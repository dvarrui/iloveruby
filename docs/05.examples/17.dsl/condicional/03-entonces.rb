#!/usr/bin/env ruby
require_relative "lib/03-entonces"


number = 10
si { number > 3 }
entonces { puts "Number > 3" }

si { number ==  4 }
entonces { puts "Number == 4" }
