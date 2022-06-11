#!/usr/bin/env ruby

def roll_dice(value)
  max = value + 1
  puts "Tiras el dado"
  espera

  dice = rand(max)
  while dice.zero?
    dice = rand(max)
    puts "¡Ha salido un #{dice}!"
    espera
  end
  puts "¡Ha salido un #{dice}!"
  espera
  return dice
end

def espera(value=3)
  #sleep value
end

def despertar
  puts "* Despiertas en una taberna, te encuentras tirado en el suelo, con dolor de cabeza." \
       "A primera vista no hay nadie más.*"
  espera 3
  puts "*Pero al incorporporarte ves un hombre más alto que tú, te fijas en la" \
       "forma puntiaguda de las orejas, es el tabernero, es un elfo, está detrás " \
       "de la barra, dando la espalda.*"
  espera 3

  puts "¿Qué haces?"
  puts "1. Te acercas a preguntarle qué ha pasado."
  puts "2. Intentas salir por la puerta sin hacer ruido. " \
       "(Dado de sigilo D20 - Para �xito se requiere una tirada de 10 o superior)"

  option = gets.to_i

  preguntar_que_ocurre if option == 1
  intentar_salir if option == 2
end

def preguntar_que_ocurre
  puts "*Al acercarte llamas su atención.*"
  espera 1
  puts "Tabernero: Buenos días dormilón, tras lo de anoche tuve que tomarte el pulso." \
       " Pensé que después de tal golpe en tu estado habrías muerto."
  espera 1
end

def intentar_salir
  dice = roll_dice(20)
  if dice < 10
    ir_a_la_puerta
  else
    el_tabernero_responde
  end
end

def el_tabernero_responde
  puts "*Mientras te vas acercando a la puerta, escuchas unos golpecitos en la barra" \
       ", al darte la vuelta, ves al tabernero observándote, con cara de sorpresa.*"
  espera
  puts "Tabernero: Despiertas en el suelo, solo ves al dueño del local de espaldas " \
       "y lo primero que haces es intentar irte sin decir ni mu..."
  espera
  puts "Tabernero: Ven aquí, acércate. Voy a intentar refrescarte lo ocurrido anoche..."
  espera
  puts "*Te diriges a la barra. Donde te está esperando limpiándola*"
  espera
end

def ir_a_la_puerta
  puts "*Al intentas ir hacia la puerta, uno de tus pies choca con una jarra de cerveza" \
       " derramada en el suelo, el tabernero lo escucha y se gira*"
  espera
  puts "Tabernero: ¡Eh! ¿A dónde vas? Lo minimo es saludar, ven aquí"\
       ", que llevas horas ahí tirado."
  espera
end

despertar
