#!/usr/bin/env ruby
require 'tty-config'

class App
  attr_reader :config

  def initialize
    @config = TTY::Config.new
    @config.filename = "investments"
    @config.extname = ".toml"
    @config.append_path Dir.pwd
    @config.append_path Dir.home
  end

  def self.config
    @config ||= self.new.config
  end
end

puts App.config

