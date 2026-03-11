#!/usr/bin/env ruby
require_relative "lib/gitlab"

data = gitlab.group(ENV['GITLAB_GROUP_ID'])

if data.is_a? Gitlab::ObjectifiedHash
  list = [ data ]
else
  list = data.to_a
end

labels = %w(id web_url visibility)
list.each do |item|
  data = item.to_h
  labels.each do |label|
    puts "#{label.rjust(15)} #{data[label]}"
  end

  unless data['projects'].nil?
    puts "projects".rjust(15)
    data['projects'].each do |project|
      puts "#{project['id'].to_s.rjust(15)} #{project['name']}"
    end
  end
end
