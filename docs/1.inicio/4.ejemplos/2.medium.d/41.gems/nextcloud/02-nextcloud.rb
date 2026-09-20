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
puts "* ocs.webdav.directory: #{ocs.webdav.directory}"
webdav = nextcloud.webdav
puts "* webdav.directory(@path): #{webdav.directory.instance_variable_get(:@path)}"
