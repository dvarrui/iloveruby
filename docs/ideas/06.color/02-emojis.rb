#!/usr/bin/env ruby
# emoji URL: https://www.mclibre.org/consultar/htmlcss/html/html-unicode-secuencias-generos.html

require 'colorize'

def example01
  ##
  # EXAMPLE 01: var names are UTF
  puts "\n[Example 01] Nombres de variables en UTF".white
  # U+1F9D1 U+200D U+1F4BB # Hex: &#x1f9d1;&#x200d;&#x1f4bb;
  🧑‍💻 = "David"
  puts " => Hola! Soy #{🧑‍💻.to_s}. ¿Cómo te llamas?"
end

def example02
  ##
  # EXAMPLE 02: puts UTF
  puts "\n[Example 02] Ejemplo de impresión de caracteres UTF".white
  puts " => \u{1f9d1} \u{2764} \u{1F48E}"
end

example01
example02
