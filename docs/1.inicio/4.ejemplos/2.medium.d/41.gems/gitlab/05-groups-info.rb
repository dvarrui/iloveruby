#!/usr/bin/env ruby
require "colorize"
require_relative "lib/gitlab"

def show(label, text)
  if label == :separator
    puts ""
    puts "#{" ".rjust(18)}  #{text.colorize(:green)}"
  else
    puts "#{label.rjust(18).colorize(:green)}: #{text}"
  end
end

data = gitlab

labels = %w(id name web_url full_path parent_id)
data.groups.each do |group|
  show :separator, "Group"
  labels.each do |label|
    show(label, group[label])
  end
  key = "projects"
  projects = data.group(group["id"])[key]
  names = projects.map { _1["name"]}
  show(key, names.sort.join(", "))
end
