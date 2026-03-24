
require_relative 'base_host'

class LocalHost < BaseHost

  def initialize
    super('127.0.0.1')
  end

  def run(command=:none)
    title = "[EXEC] LocalHost  : #{@ip}"
    puts ("=" * title.size)
    puts title

    @command = command unless command == :none
    @success = system("#{@command}")
  end
end
