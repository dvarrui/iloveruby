# File: logo.rb
require_relative "turtle"

def logo(&block)
  turtle = Turtle.new
  turtle.instance_eval(&block)
end
