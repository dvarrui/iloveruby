
module ActAsBash
  def echo(*args)
    puts args.join(' ')
  end
end

extend ActAsBash
