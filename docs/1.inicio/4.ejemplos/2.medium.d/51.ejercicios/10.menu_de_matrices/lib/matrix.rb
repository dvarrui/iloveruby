#!/usr/bin/env ruby

require_relative "input"
require_relative "sparse-matrix"

class Matrix
  def initialize(values = [])
    @values = values
  end

  def value(x,y)
    @values[x][y]
  end

  def size
    [ @values.size, @values[0].size]
  end

  def gets()
    # Entrada de una matriz
    rows = read_integer("Número de filas de la matriz: ")
    cols = read_integer("Número de columnas de la matriz: ")
    values = []

    for i in 0...rows
      row = []
      for j in 0...cols
        print "Elemento [#{i}][#{j}]: "
        value = STDIN.gets.to_i
        row << value
      end
      values << row
    end

    @values = values
    self
  end

  def show
    rows, cols = size()
    puts "[INFO] Matrix (#{rows}x#{cols})"
    for i in 0...rows
      for j in 0...cols
        print "%3d" % value(i, j)
      end
      puts
    end
  end

  def to_sparse
    puts "==> matrix to sparse matrix"
    rows, cols = size()
    values = {}
    data = { rows: rows, cols: cols, values: values}
    for i in 0...rows
      for j in 0...cols
        coord = [i, j]
        data[:values][coord]= value(i, j)
      end
    end
    SparseMatrix.new(data)
  end
end
