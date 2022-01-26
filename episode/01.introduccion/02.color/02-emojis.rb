#!/usr/bin/env ruby
# emoji URL: https://www.mclibre.org/consultar/htmlcss/html/html-unicode-secuencias-generos.html

require 'colorize'

def example01
  ##
  # EXAMPLE 01: var names are UTF
  puts "[Example 01] Nombres de variables en UTF"
  # apl functional symbol alpha: U+237A Hex: &#x237a; Dec: &#9082;
  ⍺ = 2
  # circled number sixteen: U+246F Hex: &#x246f; Dec: &#9327;
  ⑯ = 16
  puts " => Tenemos que (\u{237a} * \u{246f} ) = #{(⍺ * ⑯)}"
end

def example02
  ##
  # EXAMPLE 02: var names are UTF
  puts "\n[Example 02] Nombres de variables en UTF"
  # U+1F9D1 U+200D U+1F4BB # Hex: &#x1f9d1;&#x200d;&#x1f4bb;
  🧑‍💻 = "David"
  puts " => Hola! Soy #{🧑‍💻.to_s}. ¿Cómo te llamas?"
end

def example03
  ##
  # EXAMPLE 03: puts UTF
  puts "\n[Example 03] Ejemplo de impresión de caracteres UTF"
  puts " => \u{1f9d1}\u{200d}\u{1f4bb}  \u{2764}  \u{1F337}"
end

# example01
example02
example03
