#!/usr/bin/env ruby

require "singleton"

class Settings
  include Singleton

  def set(value)
    @value = value
  end

  def get
    @value
  end
end

Settings.instance.set("hello")
puts Settings.instance.get

