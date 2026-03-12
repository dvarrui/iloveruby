# encoding: utf-8

require 'net/ssh'

class LocalHost
  attr_reader :ip
  attr_accessor :command
  attr_reader :exit_code

  def initialize()
    @ip = '127.0.0.1'
    @exit_code = 0
    @success = false
  end

  def success?
    @success
  end

  def run(command=:none)
    @command = command unless command == :none
    @success = system("#{@command}")
  end

  def debug(command=:none)
    run command
    puts "[MACHINE #{@ip}]"
    puts "* Running... #{@command}"
    puts "* Result = #{@success}"
  end
end
