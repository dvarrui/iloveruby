#!/usr/bin/env ruby

# Output "I love Ruby"
say = 'I love Ruby'
puts say

# Output "I *LOVE* RUBY"
say['love'] = 'LOVE'
puts say

# Output "I LOVE RUBY"
puts " #{say.upcase} " * 3
