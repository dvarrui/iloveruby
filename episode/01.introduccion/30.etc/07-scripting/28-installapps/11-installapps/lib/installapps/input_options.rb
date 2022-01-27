require 'rainbow'
require_relative 'application'
require_relative 'config'

##
# Parse input options
module InputOptions
  def self.parse(input)
    puts "Executing #{Rainbow(Application::NAME).bright} " \
         "(version #{Rainbow(Application::VERSION).bright})\n\n"
    if input.first == '-s'
      Config.debug = true
    elsif input.first == '-r'
      Config.debug = false
    else
      puts "Usage:"
      puts "        #{$0} OPTIONS"
      puts "Options:"
      puts "  -s    => Simulate installation."
      puts "  -r    => Run installation."
      exit 0
    end
  end
end
