#!/usr/bin/env ruby
require "debug"
class Execute
  def initialize

  end

  def ruby(code)
    system("ruby -e '#{code}'")
  end

  def python(code)
    system("python -c '#{code}'")
  end

  def python3(code)
    system("python3 -c '#{code}'")
  end
end

execute = Execute.new

code = <<~CODE
  for i in 1..3 do
     puts i.to_s + ": Hola " + `whoami`.strip + ", soy Ruby!"
  end
CODE
execute.ruby(code)

code = <<~CODE
  for i in range(3):
    print(i, ": Hola, soy Python!")
CODE
execute.python3(code)
