#!/usr/bin/env ruby

require "erb"

class Data
  def initialize(name, rol)
    @name = name
    @rol = rol
  end

  # Support templating of member data.
  def get_binding
    binding
  end
end

# Create template.
template = %{
<starwars>
  <character>
    <name><%= @name %></name>
    <rol><%= @rol %></rol>
  </character>
</starwars>
}.gsub(/^  /, '')

# Produce result.
render = ERB.new(template)
obiwan  = Data.new "obiwan", "jedi"
render.run(obiwan.get_binding)
