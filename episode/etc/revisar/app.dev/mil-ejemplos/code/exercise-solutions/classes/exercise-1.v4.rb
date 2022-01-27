#---
# Excerpted from "Everyday Scripting in Ruby"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/bmsft for more book information.
#---
  class Counter
    def self.counted_new
      @count = self.count + 1 #(1)
      new
    end

    def self.count
      @count = 0 if @count.nil?
      @count
    end
  end

