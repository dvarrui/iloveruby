
require 'singleton'

##
# Application configuration
class Config
  @@debug = false
   
  def self.debug=(debug)
    @@debug=debug
  end

  def self.debug?
    @@debug
  end
end
