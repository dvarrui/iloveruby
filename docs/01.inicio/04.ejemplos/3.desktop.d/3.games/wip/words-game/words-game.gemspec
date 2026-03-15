#encoding: utf-8

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

name = "words-game"
require "#{name}/version"

Gem::Specification.new name, WordsGame::VERSION do |s|
  s.summary = "Words game: try to gues the hide word"
  s.email = "dvarrui@protonmail.com"
  s.homepage = "http://github.com/dvarrui/#{name}"
  s.authors = ["David Vargas Ruiz"]
  s.files = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.license = "GLP-3"

  s.add_runtime_dependency "colorize"
end

