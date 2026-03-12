
require 'singleton'
require_relative 'local_host'
require_relative 'remote_host'

class HostFactory
  include Singleton

  def create(ip)
    locals = [ '127.0.0.1', 'localhost']
    h = RemoteHost.new(ip)
    h = LocalHost.new if locals.include? ip
    return h
  end
end
