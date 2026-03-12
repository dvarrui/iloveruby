module ActAsBash
  def echo(*args)
    puts args.join(' ')
  end

  def pwd
    system("pwd")
  end

  def whoami
    system("whoami")
  end
end

extend ActAsBash
