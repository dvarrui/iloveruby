#!/usr/bin/env ruby 

require 'tty-table'

table = TTY::Table.new(%w[header1 header2],
                       [%w[a1 a2], %w[b1 b2], %w[c1 c2]])

puts table.render(:basic)
puts table.render(:ascii)
