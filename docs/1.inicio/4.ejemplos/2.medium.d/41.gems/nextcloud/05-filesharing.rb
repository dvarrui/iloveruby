#!/usr/bin/env ruby
require_relative "lib"

fs = get_filesharing_object()

puts "Retrieve all shares of an (authenticated) user"
all_shares = fs.all
meta = all_shares.meta

puts all_shares
puts meta

puts "Retrieve a single share"
share = fs.find(11)
meta = share.meta

puts share
puts meta
