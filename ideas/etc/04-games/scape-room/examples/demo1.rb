
room(:main) do
  puts "Estás en una habitación a oscuras."
  puts "Ves una puerta sucia al fondo."
  puts "A tus pies hay un objeto que parece una linterna."

  actions = {
              'p' => 'Salir por la puerta',
              'c' => 'Coger la linterna'
            }
  option = wait_user(actions)
  next_state(option)
end

room('p') do
  print "Estás abriendo la puerta"
  wait_seg(4)
  next_state(:exit)
end

room('c') do
  print "Cogiste el objeto pero estaba roto"
  wait_seg(4)
  next_state(:main)
end
