#!/usr/bin/env ruby

require 'tty-progressbar'

bar = TTY::ProgressBar.new("downloading [:bar]", total: 30)

# Once initialized, use advance method to indicated progress:

30.times do
  sleep(0.1)
  bar.advance  # by default increases by 1
end

bars = TTY::ProgressBar::Multi.new("main [:bar] :percent")

bar1 = bars.register("one [:bar] :percent", total: 15, bar_format: :arrow)
bar2 = bars.register("two [:bar] :percent", total: 15, bar_format: :block)

bars.start  # starts all registered bars timers

th1 = Thread.new { 15.times { sleep(0.2); bar1.advance } }
th2 = Thread.new { 15.times { sleep(0.1); bar2.advance } }

[th1, th2].each { |t| t.join }
