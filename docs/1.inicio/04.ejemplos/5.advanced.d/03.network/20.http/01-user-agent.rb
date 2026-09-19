#!/usr/bin/env ruby
require "net/http"

urls = []
urls << "https://pokemongolive.com/events/community-day/"
urls << "https://www.nba.com"

urls.each do |url|
  uri = URI(url)
  request = Net::HTTP::Get.new(uri)
  request["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36"

  response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => (uri.scheme == 'https')) {|http|
    http.request(request)
  }

  puts "=" * 50
  puts response.code
  puts response.body if response.body.size < 1000
end

