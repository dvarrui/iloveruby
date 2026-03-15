
def si(&block)
  result = block.call
  if result
    $SI = true
  else
    $SI = false
  end
  $SI
end

def entonces(&block)
  if $SI == true
    block.call
    $SI = nil
  end
end

