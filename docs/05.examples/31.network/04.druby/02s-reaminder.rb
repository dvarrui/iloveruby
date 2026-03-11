#!/usr/bin/env ruby
require 'drb/drb'

class Reminder
  def initialize
    @item = {}
    @serial = 0
  end

  def [](key)
    @item[key]
  end

  def add(str)
    @serial += 1
    @item[@serial] = str
    @serial
  end

  def delete(key)
    @item.delete(key)
  end

  def to_a
    @item.keys.sort.collect do |k|
      [k, @item[k]]
    end
  end
end

uri = "druby://localhost:12345"
DRb.start_service(uri, Reminder.new)
puts "[INFO] Listen => #{DRb.uri}"
DRb.thread.join()
