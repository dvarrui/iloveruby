#!/usr/bin/env ruby
# File: read_secret

class StegaReader
  # Definición de los caracteres de ancho cero
  ZWSP = "\u200b" # El "0" binario
  ZWNJ = "\u200c" # El "1" binario

  def initialize(secret)
    @secret = secret
  end

  def read_secret_from(text)
    # 1. Extraer solo los caracteres de ancho cero
    binary_secret = text.chars.select { |char| [ZWSP, ZWNJ].include?(char) }.join
    # 2. Convertir los ZWC de vuelta a una cadena binaria '0' y '1'
    cadena_binaria = binary_secret.gsub(ZWSP, '0').gsub(ZWNJ, '1')

    # 3. Decodificar la cadena binaria a texto (agrupando por 8 bits)
    decodificado = ""
    cadena_binaria.scan(/.{8}/).each { |byte| decodificado << byte.to_i(2).chr(Encoding::UTF_8) }
    puts "Cadena Binaria Extraída: #{cadena_binaria}"
    if decodificado.include?(@secret)
      puts "¡DETECTADO! El mensaje oculto ha sido encontrado:"
      puts "Mensaje decodificado: **#{decodificado.strip}**"
    else
      puts "No se encontró el mensaje #{@secret} en los caracteres ocultos."
    end
  end
end

# Leer el texto entregado por el estudiante (asumiendo que está en este archivo)
input_text = File.read("input.txt", encoding: 'utf-8')
SECRET = "Michael"
stega = StegaReader.new(SECRET)
stega.read_secret_from(input_text)
