
# Reproduce Java ListOf<type>

module ListOfType
  def method_missing(method, *args)
    words = method.to_s.split('_')
    unless words[0] == 'ListOf'
      puts "[ERROR] There's no method called '#{method}'"
      return
    end

    size = args[0] || 10
    value = args[1] || nil

    unless words[1] == value.class.to_s 
      puts "[ERROR] Error type: #{method} can't store #{value}"
      return []
    end

    Array.new(size, value)
  end
end

