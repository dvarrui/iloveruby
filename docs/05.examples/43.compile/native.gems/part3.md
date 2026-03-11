[<<back](README.md)

# Native gems (part3)

> Part 3 - How do we ensure that we have everything and that it actually gets built at installation? https://notepad.onghu.com/2023/learning-by-reversing-s1-e3-native-gems/

_Continuamos viendo cómo empaquetamos y nos aseguramos de que la extensión nativa se construya realmente durante la instalación. Además, ¿por qué hay 2 Makefiles?_

La parte 3 continúa la exploración de lo que incluye la gema y cómo se configura para que la extensión nativa se construya y esté disponible una vez que se instale la gema.

## ¿Qué hay dentro de la gema?

Cada fichero debe estar en su lugar:
* El código principal de la gema de Ruby en `lib`: es el lugar normal para incluir el archivo principal.
* La biblioteca dinámica en `lib/fast_polylines` como `fast_polylines.so` - espera, ¡esto no existía cuando vimos el código fuente!

Esto es lo que tenemos que hacer ahora: debemos pasar el código fuente C a una biblioteca dinámica en `lib/fast_polylines/fast_polylines.so`. Esto funciona así:

* Configuramos algunas cosas en el código fuente
* Lo empaquetamos como parte de nuestra gema.
* La extensión nativa se crea cuando se instala la gema (y todo debería estar en el lugar correcto en ese momento)

## Configurando cosas en el código fuente

```
❯ tree
.
├── CHANGELOG.md
├── ext
│   └── fast_polylines
│       ├── extconf.rb
│       ├── fast_polylines.c
│       ├── fast_polylines.o
│       ├── fast_polylines.so
│       └── Makefile
├── fast-polylines-2.2.2.dev.gem
├── fast-polylines.gemspec
├── Gemfile
├── Gemfile.lock
├── lib
│   ├── fast_polylines
│   │   └── version.rb
│   ├── fast-polylines.rb
│   └── fast_polylines.rb
├── LICENSE
├── Makefile
├── perf
│   └── benchmark.rb
├── README.md
└── spec
    ├── fast-polylines_spec.rb
    ├── fast_polylines_spec.rb
    └── spec_helper.rb

7 directories, 20 files

```

Se pueden ver los archivos Ruby en la carpeta lib.
Para el código nativo, hay dos partes para configurar:
* Asegúrese de que el código fuente C esté disponible
* Tener un `Makefile` que se usará cuando se instale la gema

**Código fuente C**

La gema fast_polylines es sencilla. Solo tiene un archivo de código fuente C. Los archivos fuente nativos se coloquen en el directorio ext del código fuente.
* `fast_polylines.c`: Contiene todo el código fuente C.
* `extconf.rb`: Al ejecutarlo se crea el `Makefile`.

**Makefile**

```
require "mkmf"

if ENV["DEBUG"]
  warn "DEBUG MODE."
  $CFLAGS << " " << %w(
    -Wall
    -ggdb
    -DDEBUG
    -pedantic
  ) * " "
end
create_makefile "fast_polylines/fast_polylines"
```

## Instrucciones para la instalación

```ruby
# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)
require "fast_polylines/version"

Gem::Specification.new do |spec|
  spec.name        = "fast-polylines"
  spec.version     = FastPolylines::VERSION
  spec.platform    = Gem::Platform::RUBY
  spec.authors     = ["Cyrille Courtière", "Ulysse Buonomo"]
  spec.email       = ["dev@klaxit.com"]
  spec.homepage    = "https://github.com/klaxit/fast-polylines"
  spec.summary     = "Fast & easy Google polylines"
  spec.license     = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.6")

  spec.files = Dir["{lib,ext}/**/*.{rb,c}"] + %w(README.md CHANGELOG.md .yardopts)
  spec.extensions = ["ext/fast_polylines/extconf.rb"]
  spec.test_files = Dir["spec/**/*"] + %w(.rspec)
  spec.require_paths = "lib"

  spec.add_development_dependency("benchmark-ips", "~> 2.7")
  spec.add_development_dependency("polylines", "~> 0.3")
  spec.add_development_dependency("rspec", "~> 3.5")
end
```

![](https://notepad.onghu.com/images/posts/lbr-gem/05.bits-resized.png)

