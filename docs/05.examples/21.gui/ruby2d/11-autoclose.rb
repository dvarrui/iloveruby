#!/usr/bin/env ruby
require 'ruby2d'

start_time = Time.now
tick = 0

update do
  if tick % 60 == 0
    set background: 'random'
  end
  tick += 1

  # Close the window after 5 seconds
  if Time.now - start_time > 5 then close end
end

show
