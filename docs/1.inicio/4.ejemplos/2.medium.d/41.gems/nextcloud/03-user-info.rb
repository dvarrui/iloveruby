#!/usr/bin/env ruby
require "debug"
require "dotenv"
require "nextcloud"

settings = Dotenv.load

nextcloud = Nextcloud.new(
  url: settings["URL"],
  username: settings["USERNAME"],
  password: settings["PASSWORD"]
)

ocs = nextcloud.ocs
user = ocs.user.find("dvarrui")

tags = %i(enabled id quota email displayname phone address website twitter groups language meta)

tags.each do |tag|
  label = "user.#{tag}"
  puts "#{label.rjust(16)} = #{user.send(tag)}"
end
