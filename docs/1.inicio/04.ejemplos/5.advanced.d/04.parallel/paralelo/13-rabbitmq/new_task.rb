#!/usr/bin/env ruby
require_relative 'new_task_lib'

queue_name = 'task_queue'
message = ARGV.empty? ? 'Hello World!' : ARGV.join(' ')

order_task(queue_name: queue_name, message: message)
