
# Bundle

> URL: https://twitter.com/kirill_shevch/status/1583150001991331841?t=Yu2nvIaCVtOgqVjdwvgUOg&s=35

Veamos ejemplo de uso del comando `bundle`.

## Bundle outdated

* `bundle outdated`: Muestra el listado de las gemas de nuestro proyecto que están desactualizadas.

```
❯ bundle outdated
Fetching gem metadata from https://rubygems.org/..........
Resolving dependencies...

Gem                    Current  Latest  Requested  Groups
net-sftp               2.1.2    3.0.0
net-ssh                5.2.0    7.0.1
rubocop                1.35.1   1.37.0
rubocop-ast            1.21.0   1.22.0
rubocop-performance    1.14.3   1.15.0
terminal-table         1.8.0    3.0.2
thor                   0.20.3   1.2.1
unicode-display_width  1.8.0    2.3.0
```

## Bundle open

* `EDITOR=<editor_name> bundle open <gem_name>`: Muestra el código fuente de la gema en el editor que especifiquemos. Es muy útil para la depuración.
* Ejemplo: `EDITOR=atom bundle open colorize`.

## Bundle doctor

`bundle doctor` verifica su Gemfile y el entorno de gemas en busca de problemas como versiones de Ruby que no coinciden.

```bash
$ bundle doctor
The Gemfile's dependencies are satisfied
```

## Bundle gem

`bundle gem <gem_name>`, crea una gema Ruby. Crea un esqueleto/estructura con opciones como linter, ci, motor de prueba, etc.

```bash
$ bundle gem foo
Creating gem 'foo'...
Changelog enabled in config
Standard enabled in config
Initializing git repo in /home/david/Descargas/foo
      create  foo/Gemfile
      create  foo/lib/foo.rb
      create  foo/lib/foo/version.rb
      create  foo/sig/foo.rbs
      create  foo/foo.gemspec
      create  foo/Rakefile
      create  foo/README.md
      create  foo/bin/console
      create  foo/bin/setup
      create  foo/.gitignore
      create  foo/test/test_helper.rb
      create  foo/test/foo_test.rb
      create  foo/CHANGELOG.md
      create  foo/.standard.yml
Gem 'foo' was successfully created. For more information on making a RubyGem visit https://bundler.io/guides/creating_gem.html
```
