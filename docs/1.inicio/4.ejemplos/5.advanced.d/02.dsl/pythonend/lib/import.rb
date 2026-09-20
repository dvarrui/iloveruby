
def import(name)
  if File.exist? name
    load name
  else
    load name + ".py"
  end
end
