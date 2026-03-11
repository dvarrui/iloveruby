#!/usr/bin/env ruby
require "net/https"
require "debug"

agents = [
  {
    device: "Samsung Galaxy S22",
    user_agent: "Mozilla/5.0 (Linux; Android 12; SM-S906N Build/QP1A.190711.020; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/80.0.3987.119 Mobile Safari/537.36"
  }, {
    device: "Samsung Galaxy S21",
    user_agent: "Mozilla/5.0 (Linux; Android 10; SM-G996U Build/QP1A.190711.020; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Mobile Safari/537.36"
  }
]

uri = URI("https://www.google.com")
params = {
  'user-agent' => agents.sample.fetch(:user_agent)
}

res = Net::HTTP.get_response(uri, params)

puts "==> Code           : #{res.code}"
puts "    HTTP version   : #{res.http_version}"
puts "    Content type   : #{res.content_type}"
puts "    Content length : #{res.content_length}"
puts "    Decode content : #{res.decode_content}"
puts "    Body enconding : #{res.body_encoding}"

