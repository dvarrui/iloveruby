#!/usr/bin/env ruby
require "openai"
token = `cat private.token`.strip

OpenAI.configure do |config|
    config.access_token = token
    # config.organization_id = ENV.fetch("OPENAI_ORGANIZATION_ID") # Optional
    config.uri_base = "https://oai.hconeai.com/" # Optional
    config.request_timeout = 240 # Optional
end
client = OpenAI::Client.new

response = client.chat(
    parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: [{ role: "user", content: "Hello!"}], # Required.
        temperature: 0.7,
    })
puts response.dig("choices", 0, "message", "content")
# => "Hello! How may I assist you today
