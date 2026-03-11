#!/usr/bin/env ruby
require 'bunny'

def run_worker(args)
  queue_name = args[:queue_name]

  connection = Bunny.new(automatically_recover: false)
  connection.start

  channel = connection.create_channel
  queue = channel.queue(queue_name, durable: true)

  channel.prefetch(1)
  puts ' [ INFO ] Waiting for messages. To exit press CTRL+C'

  begin
    # block: true is only used to keep the main thread
    # alive. Please avoid using it in real world applications.
    queue.subscribe(manual_ack: true, block: true) do |delivery_info, _properties, body|
      puts " [Worker] Received '#{body}'"
      # imitate some work
      sleep body.size
      puts ' [Worker] Done'
      channel.ack(delivery_info.delivery_tag)
    end
  rescue Interrupt => _
    connection.close
    puts "\n [Worker] Bye bye!"
  end
end
