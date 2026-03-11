# File: basic.rb
require_relative "dsl"

def basic(&block)
  dsl = DSL.new
  dsl.instance_eval(&block)
end

alias echo print

def PRINT(*args)
  puts args.join(" ")
end
