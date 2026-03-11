#!/usr/bin/env ruby
# https://www.tutorialspoint.com/how-do-i-use-selenium-with-ruby

require "selenium-webdriver" # set webdriver gem for Selenium
require "rubygems"

puts "Step 1/3: Create session"
options = Selenium::WebDriver::Firefox::Options.new
dirpath = 'C:\Users\dvarrui\AppData\Local\Mozilla Firefox' # change as necessary
options.binary = File.join(dirpath, 'firefox.exe')
driver = Selenium::WebDriver.for :firefox, options: options
# driver = Selenium::WebDriver.for :firefox # driver object creation

puts "Step 2/3: Get URL"
driver.get "https://www.tutorialspoint.com/index.htm"

puts "Step 3/3: Show something"
puts driver.title
puts "(Push enter)"
gets
driver.close # close browser
