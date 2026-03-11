#!/usr/bin/env ruby

require "open-uri"
require "net/http"
require "nokogiri"

def htmlpage(url)
  uri = URI.parse(url)
  response = Net::HTTP.get_response(uri)
  response.body
end

def parse(html)
  Nokogiri::HTML(html)
end

url = "https://en.wikipedia.org/wiki/Douglas_Adams"
doc =parse(htmlpage(url))
nodes = doc.css("p")

nodes.each_with_index do |node, index|
  puts "[#{index}] #{node.text[0,80]}"
end

puts "\n" + "#" * 30 + " desc2"
desc2 = doc.css("p").text.split("\n").find{|e| e.length > 0}
puts desc2
