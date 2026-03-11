#!/usr/bin/env ruby

require_relative '01-split_text_with_dict'

def debug(dict, text)
  solutions = split_text_with_dict(text, dict)
  if solutions.size.zero?
    puts "#{text} => No solution"
  elsif solutions.size == 1
    puts "#{text} => #{solutions.first.join(" ")}"
  else
    puts "#{text} "
    solutions.each { |solution| puts " => #{solution.join(" ")}" }
  end
end

dict = [ "a", "abc", "b", "bc", "cd" ]

puts "dict : #{dict.to_s}\n\n"

debug dict, "abcd"
debug dict, "abbc"
debug dict, "abcbcd"
debug dict, "acdbc"
debug dict, "abcdd"

