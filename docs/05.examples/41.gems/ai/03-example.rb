#!/usr/bin/env ruby
require "openai"
token = `cat private.token`.strip
client = OpenAI::Client.new(access_token: token)

prompt = 'What is ruby metaprogramming?'
response = client.completions(
    parameters: {
      model: "text-davinci-003",
      prompt: prompt,
      max_tokens: 2000
    })
puts response['choices'][0]['text']
