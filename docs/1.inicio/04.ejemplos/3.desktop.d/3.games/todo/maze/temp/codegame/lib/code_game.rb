
module CodeGame
  def self.play(filepath)
    game = load(filepath)
    display(game)
  end

  def self.load(filepath)
    lines = File.read(filepath).split("\n")
    game = { map: [], start: :none, finish: :none }
    lines.each_with_index do |text,index|
      line = []
      text.each_char do |c|
        if c == 'S'
          game[:start]= [index, line.size]
          line << '.'
        elsif c == 'F'
          game[:finish]= [index, line.size]
          line << '.'
        else 
          line << c.to_s
        end
      end
      game[:map] << line
    end
    game
  end

  def self.display(game)
    puts "[INFO] Displaying map"
    game[:map].each_with_index do |line,index|
      puts "#{index}: #{line.join}"
    end
    puts "[INFO] Start  at : #{game[:start]}"
    puts "[INFO] Finish at : #{game[:finish]}"
  end
end
