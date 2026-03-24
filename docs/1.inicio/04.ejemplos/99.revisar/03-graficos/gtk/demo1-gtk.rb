require 'gtk'

window = Gtk::Window::new
button = Gtk::Button::new('Hello, World!')
button.signal_connect(Gtk::Button::SIGNAL_CLICKED) {
  puts 'Goodbye, World!'
  exit
}
window.add(button)
button.show
window.show
Gtk::main
