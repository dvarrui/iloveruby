
class Character
  attr_reader :name, :type

  def initialize(params)
    @name = Name.new(params[:name])
    @type = Type.new(params[:type])
  end
end

class Name
  def initialize(name)
    @name = name
  end

  def show
    puts "My name is #{@name}"
  end
end

class Type
  def initialize(type)
    @type = type
  end

  def show
    puts "I'm a #{@type}"
  end
end
