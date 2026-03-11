require 'pry'

class Character
  attr_reader :name, :type

  def initialize(params)
    @name = Name.new(params[:name])
    @type = Type.new(params[:type])
  end

  def method_missing(method, *args, &block)
    words = method.to_s.split('_')
    if words[0] == 'show'
      [ 'show', 'my', 'and'].each { |w| words.delete(w) }
      words.each do |c|
        component = self.send c.to_sym
        component.send :show
      end
    end
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
