
# mruby howto

Enlace de interés:
* mruby web site: http://mruby.org/
* mruby docs: https://mruby.org/docs/
* [Executing Ruby code with mruby](http://mruby.org/docs/articles/executing-ruby-code-with-mruby.html)

https://www.reddit.com/r/ruby/comments/yo1mhs/understanding_the_mruby_programming_language_and/?utm_source=share&utm_medium=android_app&utm_name=androidcss&utm_term=14&utm_content=share_button

reddit (https://www.reddit.com/r/ruby/comments/yo1mhs/understanding_the_mruby_programming_language_and/?utm_source=share&utm_medium=android_app&utm_name=androidcss&utm_term=14&utm_content=share_button)
Understanding the MRuby programming language and how to integrate...
I recently learned that Ruby has a lite version. By embedding it in a host, it is hackable. It resembl


Examples:
* [mruby-examples](https://github.com/rmosolgo/mruby-examples/blob/master/readme.md)
* [GitHub de mruby](https://github.com/mruby/mruby)
* [How to compile an mruby example? - Stack Overflow](https://stackoverflow.com/questions/19329146/how-to-compile-an-mruby-example)
* [RubyConf 2019 - mruby/c](https://youtu.be/1VFPSHs3WvI): Running on Less Than 64KB RAM Microcontroller by HAMUSI Hitoshi I will show you an actual IoT product which uses one-chip-microcontr...

# Ejemplo 1

* `rbenv install mruby-3.1.0`, instalar **mruby** usando **rbenv**.
* `mrbc demo.rb`, compilar el ejemplo **demo.rb** a bytecode.
* `ruby -b demo.mrb`, ejecutar **demo.mrb**.

# ANEXO: Instalación directa de mruby

* Descargar el zip estable.
* Descomprimir.
* cd FOLDER
* `./minirake`, compile inside of the mruby source root.
* `./minirake test`, generate and execute the test tools.
* `./minirake clean`, clean all build files.

## Proyectos con mruby

* MRuby::CLI (http://mruby-cli.org/): A utility for setting up a CLI with mruby that compiles binaries to Linux, OS X, and Windows.
* https://github.com/dabroz/mruby-simple-game-engine: This project is based on a talk I gave at Game Industry Conference 2016 in Poznań titled "Why (m)ruby should be your next scripting language?". This project implements a very basic component-based game engine. The backend is written in C++ and uses SFML for rendering. All game logic is in mruby scripts.
* https://github.com/ruby-rcade/mruby-game-engine-example


* Executing Ruby code with mruby: https://mruby.org/docs/articles/executing-ruby-code-with-mruby.html
