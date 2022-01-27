
def square_root(target, current = 0, inc = 1)
  return current if inc < 0.00001

  min = 0
  max = 9
  if inc == 1
    min = 1
    max = target
  end

  better = current
  min.upto(max).each do |i|
    n = current + inc * i
    if (n*n) < target
      better = n
    elsif (n*n) == target
      return n
    else
      return square_root(target, better, inc/10.0)
    end
  end
  return better
end
