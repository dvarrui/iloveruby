#!/usr/bin/env ruby
# frozen_string_literal: true

require 'tty-spinner'
require "pastel"

spinner = TTY::Spinner.new("Loading :spinner ... ", format: :classic)
20.times do
  spinner.spin
  sleep(0.1)
end
spinner.stop("done")

spinner = TTY::Spinner.new("[:spinner] Task name", format: :bouncing_ball)
20.times do
  spinner.spin
  sleep(0.1)
end
spinner.success

pastel = Pastel.new
format = "[#{pastel.yellow(':spinner')}] " + pastel.yellow("Task name")
spinner = TTY::Spinner.new(format, format: :spin, success_mark: pastel.green("+"))
20.times do
  spinner.spin
  sleep(0.1)
end
spinner.success(pastel.green("(successful)"))

spinner = TTY::Spinner.new("[:spinner] Task name")
20.times do
  spinner.spin
  sleep(0.1)
end
spinner.error("(error)")

TTY::Formats::FORMATS.each_key do |token|
  options = {format: token, hide_cursor: true}
  spinner = TTY::Spinner.new("#{token}: :spinner", options)
  20.times do
    spinner.spin
    sleep(0.1)
  end
  spinner.stop
end

