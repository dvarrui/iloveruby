#!/usr/bin/env ruby
require_relative "lib"

nextcloud = get_nextcloud_object()
ocs = nextcloud.ocs
user = ocs.user.find("dvarrui")

tags = %i(enabled id quota email displayname phone address website twitter groups language meta)

puts "User:"
tags.each do |tag|
  value = user.send(tag)
  puts "#{tag.to_s.rjust(12)} = #{value.to_s}"
end

puts "\nAdmin:"
groups = ocs.group.all
puts "      groups : #{groups}"
# => ["admin", "group1", "group2"]
meta = groups.meta
puts "        meta : #{meta}"
# => {"status"=>"ok", "statuscode"=>"200", "message"=>"OK"}
