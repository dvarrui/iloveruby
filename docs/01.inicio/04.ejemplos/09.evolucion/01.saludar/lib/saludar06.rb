
def hola_a(nombre, linea = nil)
  frase = "¡Hola #{nombre.capitalize}!"
  return frase if linea.nil?

  " #{linea} => ¡Hola #{nombre.capitalize}!"
end

def decir(frase)
  puts frase
end

def preguntar_a(nombre)
  decir "¿Cuantas veces le saludo #{nombre}?"
end

def saludar_a_desconocido
  decir '¡Disculpe! ¿Le conozco?'
end

def saludar_a(nombre)
  preguntar_a nombre.capitalize
end

def saludar_n_veces_a(nombre:, veces:)
  veces.times { decir hola_a(nombre) }
end

def saludar_enfadado_n_veces_a(nombre:, veces:)
  (1..veces).each { |cadavez| decir hola_a(nombre, cadavez) }
end
