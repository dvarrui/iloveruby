#!/usr/bin/env ruby

require "selenium-webdriver"

options = Selenium::WebDriver::Firefox::Options.new
options.add_argument("-headless")
driver = Selenium::WebDriver.for :firefox, options: options

url = "https://cooperativa.unidesupermercados.es/establecimientos/"
driver.manage.timeouts.implicit_wait = 30
driver.get url

puts "[Title] #{driver.title}"
index = 0

places = driver.find_elements(xpath: '//div[@class="sl-addr-sec"]')
places.each do |div|
  index += 1
  h = div.find_element(xpath: 'descendant::h3')

  addr = div.find_element(xpath: 'descendant::li[@class="sl-addr"]/span').text
  addrs = addr.split("\n")
  cod_postal = addrs[1].split(",").last.strip
  puts "#{format("%3d", index)} #{h.text} (#{cod_postal})"
  next unless cod_postal.start_with?("35", "38") && cod_postal.size == 5

  phone = div.find_element(xpath: 'descendant::li[@class="sl-phone"]/a').text
  email = div.find_element(xpath: 'descendant::li[@class="sl-email"]/a').text
  begin
    days = div.find_element(xpath: 'descendant::span[@class="asl-day-lbl"]').text
    hours = div.find_element(xpath: 'descendant::span[@class="asl-time-hrs"]').text
    days2 = div.find_element(xpath: 'descendant::span[@class="txt-hours"]').text
  rescue
    days = ""
    hours = ""
    days2 = ""
  end
  category = div.find_element(xpath: 'descendant::li[@class="sl-categories"]/ul/li/span').text

  puts "          addr0: #{addrs[0]}"
  puts "          addr1: #{addrs[1]}"
  puts "     cod_postal: #{cod_postal}"
  puts "          phone: #{phone}"
  puts "          email: #{email}"
  puts "           days: #{days}"
  puts "          hours: #{hours.gsub("\n", ", ")}"
  puts "          days2: #{days2.gsub("\n", ", ")}"
  puts "       category: #{category}"

  # h.find_elements(xpath: "descendant::a").each do |a|
  #   puts "      #{a.text}"
  # end
end

# driver.find_elements(:tag_name, "h3").each do |e|

driver.quit
exit 0
