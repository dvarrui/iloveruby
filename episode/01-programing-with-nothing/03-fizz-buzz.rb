#!/usr/bin/env ruby

(1..100).each do |n|
  if (n % 15).zero?
    puts 'FizzBuzz'
  elsif (n % 3).zero?
    puts 'Fizz'
  elsif (n % 5).zero?
    puts 'Buzz'
  else
    puts n.to_s
  end
end
