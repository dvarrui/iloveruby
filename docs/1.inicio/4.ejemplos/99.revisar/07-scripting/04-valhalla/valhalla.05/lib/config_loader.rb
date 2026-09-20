
require_relative 'host/local_host'
require_relative 'host/remote_host'

class ConfigLoader
  attr_reader :commands_file, :commands
  attr_reader :hosts_file, :hosts

  def initialize(commands_file, hosts_file)
    load_commands(commands_file)
    load_hosts(hosts_file)
  end

  def load_commands(commands_file)
    @commands_file = commands_file
    file = File.join('command', @commands_file)
    @commands = `cat #{file}`.split("\n")
  end

  def load_hosts(hosts_file)
    @hosts_file = hosts_file
    file = File.join('host', @hosts_file)
    ips = `cat #{file}`.split("\n")
    @hosts = []
    ips.each do |ip|
      h = RemoteHost.new(ip)
      h = LocalHost.new if ip == '127.0.0.1'
      @hosts << h
    end
  end
end
