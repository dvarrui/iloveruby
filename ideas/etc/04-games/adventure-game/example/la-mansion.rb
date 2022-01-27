
class Adventure
  def intro
  '
  =====================
  LA MANSIÓN DEL TERROR
  =====================

  Fernando es un chico de 17 años, su vida es aparentemente normal.
  Su vecina Carolina, con la que trata de salir desde los 11 años,
  tiene una especial atracción por todo lo paranormal. Lo lejos de
  sus casas hay una pequeña vivienda que según cuentan está embrujada
  y a la cual llaman la mansión del terror. Según Carolina, todo aquél
  que entra queda atrapado y sin salida posible. Fernando, que además
  de no creer en fantasmas es muy dado a las bravuconadas, ha hecho
  una apuesta con Carolina. Si consigue salir de la casa, irá con él
  al baila de fin de curso. Fernando ha entrado por una ventana, que
  se ha cerrado de golpe cortando su única salida.
  ¿Conseguirá Fernando salir de la mansión del terror?
  ¿Conseguirá Fernando ir al baila con Carolina?
  Todo depende de ti ahora...
'
  end

  def create
    add_room 'dormitorio', {
      desc: 'Estás en un pequeña habitación pintada de blanco.
Junto a tí puedes ver una cama y una mesita de noche.',
      doors: {'sur' => 'pasillo1'} }

    add_room 'cocina', {
      desc: 'Estás en una cocina.
Puedes ver un fregadero y una mesa con platos.
Una nevera al fondo hace ruido.',
      doors: { 'sur' => 'pasillo2' } }

    add_room 'salon', {
      desc: 'Estás en el salón de la casa.
Puedes ver una gran mesa rodeada de sillas.',
      doors: { 'sur' => 'pasillo3' } }

    add_room 'pasillo1', {
      desc: 'Estás en el pasillo.
Puede ver una ventana con rejas en una de las paredes.',
      doors: { 'norte' => 'dormitorio',
               'sur' => 'almacen',
               'este' => 'pasillo2'} }

    add_room 'pasillo2', {
      desc: 'Estás en el pasillo.
Puedes ver una puerta que parece ser la entrada principal de la casa.',
      doors: { 'norte' => 'cocina',
              'oeste' => 'pasillo1',
              'este' => 'pasillo3'}
    }
    add_room 'pasillo3', {
      desc: 'Estás en el pasillo.
Hay una ventana cerrada en una de las paredes.',
      doors: { 'norte' => 'salon',
              'oeste' => 'pasillo2' }
    }
    add_room 'almacen', {
      desc: 'Estás es un almacén oscuro.
Hay de cajas repartidas por toda la habitación y objetos tirados por el suelo.',
      doors: { 'norte' => 'pasillo1' }
    }

    add_player( room: 'dormitorio' )

    #Objeto:hueso:1:Un hueso::2:0
    add_item 'hueso', {
      room: 'almacen',
      states: [ 'Hay un hueso en el suelo.' ]
    }

    #Objeto:perro:1:Un perro rabioso:Un perro comiéndose un hueso:9:0
    add_item 'perro', {
      room: 'cocina',
      states: [ 'Un perro rabioso que no te deja acercarte a la escalera.',
                'Un perro entretenido, comiéndose un hueso.' ]
    }

    #Objeto:escalera:1:Una escalera::9:0
    add_item 'escalera', {
      room: 'cocina',
      states: [ 'Hay una escalera detrás de la nevera.',
                'La escalera está apoyada y preparada para poder subir por ella' ]
    }
    #Objeto:llave:1:Una llave sobre la lámpara::3:0
    add_item 'llave', {
      room: 'salon',
      states: [ 'Hay una llave sobre la lámpara.' ]
    }

  end

  def logic
    if get_item('perro').collected?
      puts "El perro te ha mordido, y mueres desangrado!"
      puts "GAME OVER"
      exit 1
    end
    if get_item('escalera').collected? and get_item('perro').state_id == 0
      player.drop('escalera')
      puts "El perro no te deja acercarte a coger la escalera"
    end
    if get_item('hueso').room == get_item('perro').room
      get_item('perro').state_id = 1
    end
    if get_item('llave').collected? and get_item('escalera').state_id == 0
      player.drop('llave')
      puts "No llegas a coger la llave."
    end
    if get_item('escalera').room == get_item('llave').room
      get_item('escalera').state_id = 1
    end
    if get_item('llave').collected? and player.room.id == 'pasillo2' and
       is_action('use', 'llave')
      puts "Enhorabuena! Has escapado de la mansión!"
      exit 0
    end
  end

end
