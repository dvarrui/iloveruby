#!/usr/bin/env ruby

module Example01
  def self.hello
    puts "Hello people! (It's public method)"
    secret
  end

  def self.secret
    puts "Say a secret (Must be... private method)"
  end
end

Example01.hello

puts "* Example01.hello  public? #{Example01.public_methods.include? :hello}"
puts "* Example01.secret public? #{Example01.public_methods.include? :secret}"
