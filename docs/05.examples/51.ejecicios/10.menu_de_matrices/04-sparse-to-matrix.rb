#!/usr/bin/env ruby

require_relative "lib/sparse-matrix"

sparse = SparseMatrix.new
sparse.gets
sparse.show

matrix = sparse.to_matrix
matrix.show
