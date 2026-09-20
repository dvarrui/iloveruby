#!/usr/bin/env ruby
require "tk"

$names = %w{ yellow gray green
              blue red black white cyan
              pink yellow orange gray}
$colornames = TkVariable.new($names)

root = TkRoot.new
root.title = "Window"

list = TkListbox.new(root) do
   listvariable $colornames
   pack('fill' => 'x')
end

list.place('height' => 150,
           'width'  => 100,
           'x'      => 10,
           'y'      => 10)

scroll = TkScrollbar.new(root) do
   orient 'vertical'
   place('height' => 150, 'x' => 110)
end

list.yscrollcommand(proc { |*args|
   scroll.set(*args)
})

scroll.command(proc { |*args|
   list.yview(*args)
}) 

Tk.mainloop

