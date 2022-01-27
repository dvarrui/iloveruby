
class BaseHost
  attr_reader :ip
  attr_accessor :command
  attr_reader :exit_code, :output

  def initialize(ip)
    @ip = ip
    @exit_code = 0
    @success = false
    @output = []
  end

  def success?
    @success
  end

  def info
    raise 'Build method!'
  end

  def run(command=:none)
    raise 'Build method!'
  end

  def run_several(commands=[])
    commands.each { |c| run(c) }
  end

  def show_output
    @output.each do |line|
      puts "- #{line[:command]} => #{Rainbow(line[:result]).green}"
    end
  end
end
