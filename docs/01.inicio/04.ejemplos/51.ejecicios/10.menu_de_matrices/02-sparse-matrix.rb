#!/usr/bin/env ruby

require_relative "lib/sparse-matrix"

puts "==> gets sparse matrix"
matrix = SparseMatrix.new.gets()

puts ""
puts "==> show sparse matrix"
matrix.show
