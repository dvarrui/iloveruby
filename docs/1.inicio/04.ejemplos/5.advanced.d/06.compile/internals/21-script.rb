
class Foo
  def !
    "Hello"
  end
end

f = Foo.new
puts not(f)
puts f.!

