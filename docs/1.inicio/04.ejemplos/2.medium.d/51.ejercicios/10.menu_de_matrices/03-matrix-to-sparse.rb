#!/usr/bin/env ruby

require_relative "lib/matrix"

matrix = Matrix.new
matrix.gets
matrix.show

sparse = matrix.to_sparse
sparse.show
