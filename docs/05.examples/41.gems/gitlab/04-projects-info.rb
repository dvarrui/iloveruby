#!/usr/bin/env ruby
require_relative "lib/gitlab"

data = gitlab.group(ENV['GITLAB_GROUP_ID']).to_h
projects = data['projects']
labels = %w(id name http_url_to_repo web_url visibility empty_repo last_activity_at creator_id)

projects.each do |project|
  labels.each do |label|
    puts "#{label.rjust(18)}: #{project[label]}"
  end
  puts ""
end
