#!/usr/bin/env ruby

def title_decorator(func)
  puts "="*40
  func.call
  puts "="*40
end

def starwars
    puts "StarWars"
end

title_decorator(method :starwars)
