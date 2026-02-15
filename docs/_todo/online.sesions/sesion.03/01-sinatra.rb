#!/usr/bin/env ruby

require 'sinatra'

get '/' do
  'Recuerda usar este URL http://localhoat:4567/fran-says'
end

get '/frank-says' do
  'Put this in your pipe & smoke it!'
end
