#---
# Excerpted from "Everyday Scripting in Ruby"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/bmsft for more book information.
#---
module OneGem

  ONEDIR = "test/data/one"
  ONENAME = "one-0.0.1.gem"
  ONEGEM = "#{ONEDIR}/#{ONENAME}"

  def clear
    FileUtils.rm_f ONEGEM
  end

  def build(controller)
    Dir.chdir(ONEDIR) do
      controller.gem "build one.gemspec"
    end
  end

  def rebuild(controller)
    clear
    build(controller)
  end

  extend self
end
