
x = "awesome"

def myfunc()
  global x
  x = "fantastic"
  print("Python is " + x)
end

myfunc()

print("Python is " + x)
