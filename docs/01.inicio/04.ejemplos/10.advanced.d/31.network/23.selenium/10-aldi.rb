#!/usr/bin/env ruby

require "debug"
require "colorize"
require "selenium-webdriver"

# https://www.aldi.es/supermercados/encuentra-tu-supermercado.html
# url = "https://www.aldi.es/supermercados/encuentra-tu-supermercado.html/s?q=Canarias%2C%20Espa%C3%B1a"
url = "https://www.aldi.es/supermercados/encuentra-tu-supermercado.html"

def pause
  puts "(Push enter to continue)".colorize(:light_yellow)
  gets
end

def get_driver
  options = Selenium::WebDriver::Firefox::Options.new
  # options.add_argument("-headless")
  driver = Selenium::WebDriver.for :firefox, options: options
  driver.manage.timeouts.implicit_wait = 30
  driver
end

driver = get_driver
driver.get url
puts "[Title] #{driver.title}"

sleep 4
puts "DEBUG Cerrar la ventana de cookies!"
pause

# Localizar el input
input = driver.find_element(xpath: '//input[@data-testid="autocomplete-input"]')
input.send_keys "Canarias, España\n", :return

# Localizar el button buscar
sleep 1
button = driver.find_element(xpath: '//button[@class="ubsf_store-finder-button"]')
button.click

# base = driver.find_element(xpath: '//div[@class="ubsf_locations-list"]')
# places = base.find_elements(xpath: 'descendant::div[@class="ubsf_locations-list-item-main-content"]')

base = driver.find_element(xpath: '//div[@data-testid="location-list"]')
places = base.find_elements(xpath: 'descendant::div[@data-testid="location-list-item"]')

puts "NRO;NAME;STREET;ZIP;PHONE;HOURS"
places.each_with_index do |place, index|
  name = place.find_element(xpath: 'descendant::div[@class="ubsf_locations-list-item-name"]').text
  street = place.find_element(xpath: 'descendant::div[@class="ubsf_locations-list-item-street"]').text
  zip = place.find_element(xpath: 'descendant::div[@class="ubsf_locations-list-item-zip-city"]').text
  a = place.find_element(xpath: 'descendant::a[starts-with(@href,"tel:")]')
  phone = a.attribute("href")
  hours = place.find_element(xpath: 'descendant::span[@class="ubsf_opening-hours-message"]').text

  puts "#{index};#{name};#{street};#{zip};#{phone};#{hours}"
end

driver.quit
exit 0
