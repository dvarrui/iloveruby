
class Character
  attr_reader :name, :type

  def initialize(params)
    @name = params[:name]
    @type = params[:type]
  end

  def show
    puts "My name is #{@name}, and I'm a #{@type}."
  end
end
