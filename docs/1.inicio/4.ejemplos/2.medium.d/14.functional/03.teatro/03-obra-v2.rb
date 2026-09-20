#!/usr/bin/ruby
# enconding: utf-8

require_relative '03-actor'

titulo_de_la_obra 'El Imperio Contraataca', tab: 16

luke  = Actor.new 'Luke Skywalker', :tan
vader = Actor.new '   Darth Vader', :darkslategray

vader.dice "¿Obiwan no te contó... lo qué le pasó a tu padre?"
luke.dice_gritando  "¡Me dijo que tú lo mataste!"
vader.dice "¡No!. Yo..., soy... tu padre"
luke.dice_gritando  "¡Nooooooo!!!"

luke.info
vader.info
