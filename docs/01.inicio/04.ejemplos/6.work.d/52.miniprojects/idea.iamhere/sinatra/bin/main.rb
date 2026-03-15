#!/usr/bin/env ruby

require 'sinatra'
require 'pp'  # Pretty print
require_relative '../lib/mac'

# set :bind, '0.0.0.0'
# set :port, 80
set :bind, '192.168.1.42'

get '/' do
  puts '='*40
  puts MAC.show_list

  ip = request.env['REMOTE_ADDR']
  show_host_info(ip)

  "<html>#{Time.now}<br>IP: #{ip}<br>"
end

def show_host_info(ip)
  data = MAC.find_for_ip(ip)
  puts " Rol : #{data[:rol]}"
  puts " IP  : #{ip}"
  puts " MAC : #{data[:mac]}"

  puts '='*40
end
