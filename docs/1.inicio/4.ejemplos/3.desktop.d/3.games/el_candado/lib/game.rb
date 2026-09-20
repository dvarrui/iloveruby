
require_relative 'combination'
require_relative 'rule'

class Game
  def self.play_with(rules)
    combi = Combination.new(0,0,0)
    i = 0
    while(i < 1000)
      flag = true
      rules.each { |rule| flag = flag && rule.check(combi) }
      if flag
        puts "\n[-] Respuesta: #{combi}"
        exit 0
      end
      print '.'
      i += 1
      combi.next!
    end
    puts "[x] Sin solución! Llegué hasta #{combi}"
  end
end
