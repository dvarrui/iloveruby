#!/usr/bin/env ruby
require 'bunny'

def order_task(args)
  queue_name = args[:queue_name]
  message = args[:message]

  connection = Bunny.new(automatically_recover: false)
  connection.start

  channel = connection.create_channel
  queue = channel.queue(queue_name, durable: true)

  messages = message.split(" ")
  messages.each do |m|
    queue.publish(m, persistent: true)
    puts " [ INFO ] Sent '#{m}'"
    sleep m.size
  end
  connection.close
  puts " [ INFO ] Exit program!"
end
