#!/usr/bin/env ruby
# https://github.com/JEG2/highline

require 'highline'

# Basic usage

cli = HighLine.new
answer = cli.ask "What do you think?"
puts "You have answered: #{answer}"

# Default answer
asnwer = cli.ask("Company?  ") { |q| q.default = "none" }
puts "You have answered: #{answer}"

# Validation
cli.ask("Age?  ", Integer) { |q| q.in = 0..105 }
cli.ask("Name?  (last, first)  ") { |q| q.validate = /\A\w+, ?\w+\Z/ }

# Type conversion for answers:
cli.ask("Birthday?  ", Date)
cli.ask("Interests?  (comma sep list)  ", lambda { |str| str.split(/,\s*/) })

# Reading passwords:
cli.ask("Enter your password:  ") { |q| q.echo = false }
answer = cli.ask("Enter your password:  ") { |q| q.echo = "x" }
puts "You have answered: #{answer}"

# Menus:

cli.choose do |menu|
  menu.prompt = "Please choose your favorite programming language?  "
  menu.choice(:ruby) { cli.say("Good choice!") }
  menu.choices(:python, :perl) { cli.say("Not from around here, are you?") }
  menu.default = :ruby
end

