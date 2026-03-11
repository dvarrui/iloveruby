#!/usr/bin/env ruby

class Settings
  def self.set(value)
    @value = value
  end

  def self.get
    @value
  end
end

Settings.set("hello")
puts Settings.get

