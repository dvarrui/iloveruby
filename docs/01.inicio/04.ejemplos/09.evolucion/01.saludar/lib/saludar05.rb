
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
