#!/usr/bin/env ruby

require "pastel"

pastel = Pastel.new

puts "=> Some examples:"
puts pastel.red("Unicorns!")
puts pastel.white.on_green.bold("Unicorns!")
puts pastel.red("Unicorns") + " will rule " + pastel.green("the World!")
puts pastel.red("Unicorns ", pastel.on_green("everywhere!"))
puts pastel.red("Unicorns " + pastel.green("everywhere") + pastel.on_yellow("!"))

puts "\n=> You can also predefine needed styles and reuse them:"

pastel = Pastel.new(eachline: "\n")
error    = pastel.red.bold.detach
warning  = pastel.yellow.detach

puts error.("Error!")
puts warning.("Warning")

puts "\n=> Decorate and undecorate:"
puts pastel.decorate("Unicorn", :green, :on_blue, :bold)
puts pastel.undecorate("\e[32mfoo\e[0m \e[31mbar\e[0m")

puts "\n=> Detach"
notice = pastel.blue.bold.detach

puts notice.call("Unicorns running 1")
puts notice.("Unicorns running 2")
puts notice["Unicorns running 3"]

puts "\n=> Strip\nhiden line\n"
puts pastel.strip("\e[1A\e[1m\e[34mbold blue text\e[0m")

puts "\n=> Styles:"
puts pastel.styles

puts "\n=> Eachline"
pastel = Pastel.new(eachline: "\n")
puts pastel.red("foo\nbar")

puts "\n=> Disable"
pastel = Pastel.new(enabled: false)
puts pastel.blue.bold("enable?=#{pastel.enabled?}")
