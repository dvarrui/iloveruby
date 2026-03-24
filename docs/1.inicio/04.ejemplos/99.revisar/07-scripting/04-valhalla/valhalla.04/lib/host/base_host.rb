
class BaseHost
  attr_reader :ip
  attr_accessor :command
  attr_reader :exit_code

  def initialize(ip)
    @ip = ip
    @exit_code = 0
    @success = false
  end

  def success?
    @success
  end

  def run(command=:none)
    raise 'Build method!'
  end
end
