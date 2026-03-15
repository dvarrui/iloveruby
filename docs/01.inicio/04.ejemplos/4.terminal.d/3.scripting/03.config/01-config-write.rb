#!/usr/bin/env ruby

require "tty-config"

config = TTY::Config.new
config.filename = "investments"

config.set(:settings, :base, value: "USD")
config.set(:settings, :color, value: true)
config.set(:coins, value: ["BTC"])

config.append("ETH", "TRX", "DASH", to: :coins)
config.write
