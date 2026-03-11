require "bundler/setup"
require "bundler/gem_tasks"
require "bump/tasks"

Bundler::GemHelper.install_tasks

task :default => :run

task :run do
  exec "./bin/snake_game"
end