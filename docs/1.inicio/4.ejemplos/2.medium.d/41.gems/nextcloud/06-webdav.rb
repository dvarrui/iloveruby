#!/usr/bin/env ruby
require_relative "lib"

nextcloud = get_nextcloud_object()
webdav = nextcloud.webdav

ocs = nextcloud.ocs
puts "* ocs.webdav.directory: #{ocs.webdav.directory}"
webdav = nextcloud.webdav
path = webdav.directory.instance_variable_get(:@path)
puts "* webdav.directory(@path): #{path}"

dir = "files_from_git"
result = webdav.directory.create(dir)
puts result

dir = webdav.directory.find
puts dir.contents
