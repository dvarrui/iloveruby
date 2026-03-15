#encoding: utf-8

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

name = "snake_game"
require "#{name}/version"

Gem::Specification.new name, SnakeGame::VERSION do |s|
  s.summary = "Play classic Snake game using Curses"
  s.email = "jm.gilgado@gmail.com"
  s.homepage = "http://github.com/josem/#{name}"
  s.authors = ["José M. Gilgado"]
  s.files = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.license = "MIT"
  s.add_runtime_dependency "curses"
end

