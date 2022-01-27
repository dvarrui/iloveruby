require 'gtk2'

buttom = Gtk::Button.new("Say Hello")
buttom.signal_connect("clicked") do |_widget|
  puts "Hello World!"
end

window = Gtk::Window.new('Ruby GTK2 - demo1')
window.signal_connect("delete_event") do |_widget|
  puts "Window closed"
  false
end
window.signal_connect("destroy") do |_widget|
  puts "Window destroy"
  Gtk.main_quit
end

window.set_border_width(10)
window.border_width = 10
window.add(buttom)
window.show_all

Gtk.main
