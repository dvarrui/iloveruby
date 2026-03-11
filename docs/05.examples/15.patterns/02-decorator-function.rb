#!/usr/bin/env ruby

def title_decorator(func)
  lambda {
    puts "="*40
    func.call
    puts "="*40
  }
end

def starwars
    puts "StarWars"
end

d_starwars = title_decorator(method :starwars)
d_starwars.call
