
# Esteganografía de Texto usando caracteres de ancho zero.

Insertar un mensaje oculto dentro de un documentos de texto.

Para ello vamos a codificar el mensaje oculto usando utilizando caracteres de ancho cero (Zero-Width Characters).

Utilizaremos una codificación binaria simple:
* Bit '0' se representa con el Zero Width Space (U+200B)
* Bit '1' se representa con el Zero Width Non-Joiner (U+200C)

Fichero hide_message.rb

Modo de uso `ruby hide_message.rb`

3. Detección (El Paso Clave)

Cuando el estudiante entregue su trabajo generado por una IA, puedes usar el siguiente script de decodificación para ver si la marca "PIRATA" está presente:
Ruby

# Archivo: decodificar_pirata.rb

# Definición de los caracteres de ancho cero
ZWSP = "\u200b" # El "0" binario
ZWNJ = "\u200c" # El "1" binario

# Leer el texto entregado por el estudiante (asumiendo que está en este archivo)
texto_entregado = File.read("trabajo_entregado.txt", encoding: 'utf-8')

# 1. Extraer solo los caracteres de ancho cero
binario_oculto = texto_entregado.chars.select do |char|
  [ZWSP, ZWNJ].include?(char)
end.join

# 2. Convertir los ZWC de vuelta a una cadena binaria '0' y '1'
cadena_binaria = binario_oculto.gsub(ZWSP, '0').gsub(ZWNJ, '1')

# 3. Decodificar la cadena binaria a texto (agrupando por 8 bits)
decodificado = ""
cadena_binaria.scan(/.{8}/).each do |byte|
  decodificado << byte.to_i(2).chr(Encoding::UTF_8)
end

puts "\n--- Resultado de la Decodificación ---"
puts "Cadena Binaria Extraída: #{cadena_binaria.length > 50 ? cadena_binaria[0..50] + '...' : cadena_binaria}"

if decodificado.include?("PIRATA")
  puts "🚨 ¡DETECTADO! El mensaje oculto ha sido encontrado:"
  puts "Mensaje decodificado: **#{decodificado.strip}**"
else
  puts "✅ No se encontró el mensaje 'PIRATA' en los caracteres ocultos."
end

Simplemente, copia el texto que el estudiante haya pegado en su entrega en el archivo trabajo_entregado.txt y ejecuta ruby decodificar_pirata.rb. Si la IA copió el prompt, la marca "PIRATA" aparecerá en la decodificación.


