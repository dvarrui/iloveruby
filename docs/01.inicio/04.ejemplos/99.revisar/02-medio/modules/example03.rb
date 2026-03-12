#!/usr/bin/env ruby

module Example03
  def self.hello
    puts "Hello people! (It's public method)"
    secret
  end

  private_class_method def self.secret
    puts "Say a secret (Must be... private method)"
  end
end

Example03.hello

puts "* Example03.hello  public? #{Example03.public_methods.include? :hello}"
puts "* Example03.secret public? #{Example03.public_methods.include? :secret}"
