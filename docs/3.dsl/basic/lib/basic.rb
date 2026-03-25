# File: basic.rb
require_relative "dsl"

def basic(content)
  dsl = BasicDSL.new
  dsl.instance_eval(content)
end
