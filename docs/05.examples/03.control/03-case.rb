#!/usr/bin/ruby

edad = 20

case edad
 when 0..6
   puts "Niño"
 when 12..18
   puts "Adolescente"
 when 18..30
   puts "Joven"
 when 6..12
   "#{names.length} students. Thats perfect. Welcome to ruby!"
 else
   "Wow #{names.length} students. We’ll have to ﬁnd a bigger room."
 end
end

puts greet('Alexander', 'Holger', 'Zyki', 'Sebastian', 'Johann', 'chenkefei',
  'JetHo eTang', 'Matthias', 'oanap op', 'Andrei', 'Phillip')

