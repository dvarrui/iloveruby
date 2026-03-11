#!/usr/bin/env ruby
# https://oxylabs.io/blog/web-scraping-with-ruby

require_relative "lib/selenium-wrapper"
require 'debug'

list = [
  {
    filename: "alcampo.links.txt",
    url: "https://www.alcampo.es/empresa/tiendas"
  },
  {
    filename: "airbnb.links.txt",
    url: "https://www.airbnb.es/s/canaras/homes?tab_id=home_tab&search_type=search_query&refinement_paths%5B%5D=%2Fhomes&query=Canary%20Islands%2C%20Spain&flexible_trip_lengths%5B%5D=one_week&price_filter_input_type=0&price_filter_num_nights=5&pagination_search=true&cursor=eyJzZWN0aW9uX29mZnNldCI6MCwiaXRlbXNfb2Zmc2V0IjowLCJ2ZXJzaW9uIjoxfQ%3D%3D"
  }
]

list.each do |web|
  browser = SeleniumWrapper.new(web[:url])
  driver = browser.driver

  puts "[Title] #{driver.title}"

  file = File.open(web[:filename],"w")
  driver.find_elements(:tag_name, "a").map do |a|
    href = a.attribute("href")
    file.puts href
    $STDOUT.puts href
  end
  file.close

  browser.quit
end

exit 0
