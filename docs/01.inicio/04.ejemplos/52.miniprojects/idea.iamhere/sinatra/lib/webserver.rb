
require 'sinatra'
require 'pp'  # Pretty print

get '/' do
  puts '='*40
  puts 'Request headers:'
  pp request.env
  puts '='*40
  #{}"REMOTE_HOST"=>"127.0.0.1"
  'User agent: ' + request.env['REMOTE_ADDR']
end
