#!/usr/bin/env ruby
# https://oxylabs.io/blog/web-scraping-with-ruby

require_relative "lib/selenium-wrapper"
require 'debug'

list = [
  {
    filename: "airbnb.search.html",
    url: "https://www.airbnb.es/s/canaras/homes?tab_id=home_tab&search_type=search_query&refinement_paths%5B%5D=%2Fhomes&query=Canary%20Islands%2C%20Spain&flexible_trip_lengths%5B%5D=one_week&price_filter_input_type=0&price_filter_num_nights=5&pagination_search=true&cursor=eyJzZWN0aW9uX29mZnNldCI6MCwiaXRlbXNfb2Zmc2V0IjowLCJ2ZXJzaW9uIjoxfQ%3D%3D"
  },
  {
    filename: "alcampo.search.html",
    url: "https://www.alcampo.es/empresa/tiendas"
  }
]

list.each do |web|
  browser = SeleniumWrapper.new(web[:url])
  driver = browser.driver

  puts "[Title] #{driver.title}"
  content = driver.page_source

  File.open(web[:filename],"w") do |line|
    line.puts content
  end

  browser.quit
end

exit 0
