#!/usr/bin/env ruby

require_relative 'worker_lib'

queue_name = 'task_queue'

run_worker queue_name: queue_name
