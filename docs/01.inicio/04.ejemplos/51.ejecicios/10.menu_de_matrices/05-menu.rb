#!/usr/bin/env ruby

require_relative "lib/input"
require_relative "lib/matrix"
require_relative "lib/sparse-matrix"

def show_menu()
  puts ""
  puts "MENÚ PARA OPERAR CON MATRICES"
  puts "  0) Salir del menú"
  puts "  1) Leer matriz "
  puts "  2) Leer matriz escasa"
  puts "  3) Mostrar matriz"
  puts "  4) Cambiar representación"
  puts ""
end

def leer_matriz()
  puts "==> 1. Leer matriz"
  matrix = Matrix.new
  matrix.gets
end

def leer_matriz_escasa()
  puts "==> 2. Leer matriz escasa"
  matrix = SparseMatrix.new
  matrix.gets
end

matriz = Matrix.new

loop do
  show_menu
  opcion = read_integer("Opción: ")

  if opcion == 0
    exit
  elsif opcion == 1
    matrix = leer_matriz()
  elsif opcion == 2
    matrix = leer_matriz_escasa()
  elsif opcion == 3
    matrix.show
  elsif opcion == 4
    if matrix.is_a? Matrix
      matrix = matrix.to_sparse
    elsif matrix.is_a? SparseMatrix
      matrix = matrix.to_matrix
    else
      puts "[ERROR] Formato de matriz desconocida"
    end
    # Añadir a partir de aquí implementación de resto de opciones
  end
end

puts "Gracias por usar el programa"
