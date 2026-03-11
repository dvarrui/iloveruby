#!/usr/bin/env ruby

require 'tty-config'

config = TTY::Config.new
config.filename = "investments"

# Then configure values for different nested keys with set and append:
config.set(:settings, :base, value: "USD")
config.set(:settings, :color, value: true)
config.set(:coins, value: ["BTC"])

config.append("ETH", "TRX", "DASH", to: :coins)

# You can get any value by using fetch:
puts config.fetch(:settings, :base)
# => "USD"

puts config.fetch(:coins)
# => ["BTC", "ETH", "TRX", "DASH"]

# And call write to persist the configuration to investments.yml file:
config.write
# =>
# ---
# settings:
#   base: USD
#   color: true
# coins:
#  - BTC
#  - ETH
#  - TRX
#  - DASH

