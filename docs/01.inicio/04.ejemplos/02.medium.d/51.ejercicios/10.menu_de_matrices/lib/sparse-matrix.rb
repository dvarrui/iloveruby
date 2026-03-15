#!/usr/bin/env ruby

require_relative "input"
require_relative "matrix"

class SparseMatrix
  def initialize(data = {rows: 0, cols:0, values:[]})
    @data = data
  end

  def value(x, y)
    value = @data[:values][[x, y]]
    return 0 if value.nil?

    value
  end

  def size
    [@data[:rows], @data[:cols]]
  end

  def gets()
    rows = read_integer("Número de filas de la matriz: ")
    cols = read_integer("Número de columnas de la matriz: ")

    values = {}
    @data = { rows: rows, cols: cols, values: values }

    loop do
      puts "Nuevo elemento"
      row = read_integer("  Número de la fila (0-#{rows-1}): ")
      col = read_integer("  Número de la columna (0-#{cols-1}): ")
      value = read_integer("  Escribe un valor no nulo: ")

      if value.zero?
        puts "  [ERROR] El valor no puede ser nulo"
      else
        values[[row,col]] = value
      end
      resp = read("¿Otro elemento? (S/N): ").downcase
      return self if resp == "n"
    end
  end

  def show
    rows, cols = size()
    puts "[INFO] SparseMatrix (#{rows}x#{cols})"
    for i in 0...rows
      for j in 0...cols
        print "#{value(i, j).to_s.rjust(3)}"
      end
      puts ""
    end
  end

  def to_matrix
    puts "==> sparse matrix to matrix"
    rows, cols = size()
    data = []
    for i in 0...rows
      row = []
      for j in 0...cols
        row << value(i, j)
      end
      data << row
    end
    Matrix.new(data)
  end
end
