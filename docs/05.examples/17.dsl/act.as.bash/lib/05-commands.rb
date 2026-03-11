module ActAsBash
  def echo(*args)
    puts args.join(' ')
  end

  def method_missing(method, *args, &block)
    command = "#{method} #{args.join(' ')}"
    system(command)
 end
end

extend ActAsBash
