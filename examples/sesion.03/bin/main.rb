#!/usr/bin/env ruby

require 'sinatra'
require 'pp'  # Pretty print
require_relative '../lib/mynet'

# set :bind, '0.0.0.0'
# set :port, 80
set :bind, '192.168.1.42'

get '/' do
  puts '='*40
  puts MyNET.show_mac_list

  ip = request.env['REMOTE_ADDR']
  mac = MyNET.find_mac_for_ip(ip)
  puts " IP  : #{ip}"
  puts " MAC : #{mac}"

  puts '='*40

  "<html>#{Time.now}<br>IP: #{ip}<br>MAC: #{mac}<br></html>"
end
