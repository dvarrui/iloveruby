#!/usr/bin/env ruby

require "redis"
redis = Redis.new

puts redis.set("mykey", "hello world")

