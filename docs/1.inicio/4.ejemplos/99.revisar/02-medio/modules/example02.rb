#!/usr/bin/env ruby

module Example02
  def self.hello
    puts "Hello people! (It's public method)"
    secret
  end

  class << self
    private
    def secret
      puts "Say a secret (Must be... private method)"
    end
  end
end

Example02.hello

puts "* Example02.hello  public? #{Example02.public_methods.include? :hello}"
puts "* Example02.secret public? #{Example02.public_methods.include? :secret}"
