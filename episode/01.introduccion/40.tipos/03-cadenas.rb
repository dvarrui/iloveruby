#!/usr/bin/env ruby

text = '2toc-penny3'

# Se pide transformar una cadena de texto de entrada text
# en funcion de unas reglas:
# El primer caracter indica el numero de veces que se repite
# la primera subcadena.
# Puedes suponer solo numeros del 1 al 9.

repeat_word1 = int(text[0])

# El ultimo caracter indica el numero de veces que se repite
# la ultima subcadena.
# Puedes suponer solo numeros del 1 al 9.
last_position = len(text) - 1
repeat_word2 = int(text[last_position])

sep_position = text.find('-')

# Las dos subcadenas de salida deberan estar separadas por una almohadilla.

word1 = text[1:sep_position]
word2 = text[sep_position+1:last_position]

result = word1*repeat_word1 + '#' + word2*repeat_word2

print(result)
