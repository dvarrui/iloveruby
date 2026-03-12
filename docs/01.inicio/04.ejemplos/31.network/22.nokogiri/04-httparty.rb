#!/usr/bin/env ruby
require 'httparty'
require 'nokogiri'

books = []
50.times do |i|
  url = "https://books.toscrape.com/catalogue/page-#{i + 1}.html"
  response = HTTParty.get(url)
  if response.code == 200
    puts "==> httparty: OK"
  else
    puts "==> httparty: [Error] #{response.code}"
    exit 1
  end

  document = Nokogiri::HTML(response.body)
  all_book_containers = document.css('article.product_pod')

  all_book_containers.each do |container|
    title = container.css('.image_container > a > img').first['alt']
    price = container.css('.price_color').text.delete('^0-9.')
    availability = container.css('.availability').text.strip
    book = [title, price, availability]
    books << book
  end
end

books.each do |book|
  puts "#{book[1]} | #{book[0]} "
end
