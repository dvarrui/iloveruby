#!/usr/bin/env ruby
require 'drb/drb'

remote = DRbObject.new_with_uri('druby://localhost:12345')
remote.to_a.each { puts _1.to_s }
remote.add('13:00 Meeting')
remote.add('17:00 Status report')
remote.add('Return DVD on Saturday')

remote.to_a.each { puts _1.to_s }
