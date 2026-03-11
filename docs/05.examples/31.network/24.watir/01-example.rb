#!/usr/bin/env ruby

require 'watir'
require 'webdrivers'
require 'nokogiri'

browser = Watir::Browser.new
browser.goto 'https://blog.eatthismuch.com/latest-articles/'
parsed_page = Nokogiri::HTML(browser.html)

File.open("parsed.txt", "w") { |f| f.write "#{parsed_page}" }

browser.close
