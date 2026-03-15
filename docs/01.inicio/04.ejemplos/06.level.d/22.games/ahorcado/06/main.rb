#!/usr/bin/env ruby

#
# Variables globales
#
version = '20070410v6'
wordsfile = '../diccionario.txt'

require_relative 'ahorcado'

#
# Ejecución del programa
#
puts version
   
juego = Ahorcado.new
juego.inicializar(wordsfile)
juego.jugar
