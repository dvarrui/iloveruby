require_relative 'maze-code-game/application'

##
# Main Class
module MazeCodeGame
  ##
  # Play the game
  # @param args [Array] Input arguments
  def self.play(args)
    puts "[INFO] Running version #{Application::VERSION} with #{args}"
    require_relative 'maze-code-game/window'
  end
end
