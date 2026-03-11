require "sinatra/base"

class HelloWorld < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/hello' do
    erb :hello
  end

  get '/iam/:name' do
    "Hello #{params['name']}!"
  end
end

HelloWorld.run!
