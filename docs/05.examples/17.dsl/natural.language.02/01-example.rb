#!/usr/bin/env ruby

require_relative 'lib/talk'

talk = Talk.new
yo = talk.add_actor(:yo, :light_blue)
tu = talk.add_actor(:tu, :light_green)

yo.say "Hola, soy #{yo.name}"
tu.say "Hola!"
