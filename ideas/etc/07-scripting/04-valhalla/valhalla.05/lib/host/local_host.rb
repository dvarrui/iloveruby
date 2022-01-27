
require_relative 'base_host'

class LocalHost < BaseHost

  def initialize
    super('127.0.0.1')
  end

  def info
    title = Rainbow("[EXEC] LocalHost  : #{@ip}").aqua
    puts ("=" * 50)
    puts title
  end

  def run(command=:none)
    @command = command unless command == :none
    @success = system("#{@command}")
  end
end
