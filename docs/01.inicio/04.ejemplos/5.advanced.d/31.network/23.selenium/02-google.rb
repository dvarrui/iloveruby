#!/usr/bin/env ruby

require 'selenium-webdriver'

def pause
  puts "(Push enter to continue)"
  gets
end

driver = Selenium::WebDriver.for :firefox
begin
  # Navigate to URL
  driver.get 'https://google.com'
  pause

  driver.find_element(id: 'L2AGLb').click
  # Enter "webdriver" text and perform "ENTER" keyboard action
  driver.find_element(name: 'q').send_keys 'webdriver', :return
  pause
ensure
  driver.quit
end
