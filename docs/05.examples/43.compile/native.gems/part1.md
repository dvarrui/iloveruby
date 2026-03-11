[<<back](README.md)

# Native gems (part1)

>  Part 1 - This covers the background to the gem we explore: https://notepad.onghu.com/2023/learning-by-reversing-s1-e1-native-gems/

_En la Parte 1, analizamos los antecedentes de la gema que vamos a explorar. Veremos cómo funciona la gema y también cómo cambiar, reconstruir e instalar la gema localmente._

## Requisitos

Proceso:
* Tengo instalado: gcc, make y ruby-devel.

## Instalación de la gema

* Instalamos la gem que vamos a estudiar (`gem install fast-polylines`)
* Probamos la gema:

```
❯ irb
irb> require "fast-polylines"
=> true

irb> FastPolylines.encode([[38.5, -120.2], [40.7, -120.95], [43.252, -126.453]])
=> "_p~iF~ps|U_ulLnnqC_mqNvxq`@"
```

## Unpack

Desempaquetamos la gema para poder estudiarla:
* `mkdir unpack`
* `cd unpack`
* `gem fetch fast-polylines`
* `gem unpack fast-polylines-2.2.2.gem`

De modo que tenemos lo siguiente:
```
❯ tree
.
├── fast-polylines-2.2.2
│   ├── CHANGELOG.md
│   ├── ext
│   │   └── fast_polylines
│   │       ├── extconf.rb
│   │       └── fast_polylines.c
│   ├── lib
│   │   ├── fast_polylines
│   │   │   └── version.rb
│   │   ├── fast-polylines.rb
│   │   └── fast_polylines.rb
│   ├── README.md
│   └── spec
│       ├── fast-polylines_spec.rb
│       ├── fast_polylines_spec.rb
│       └── spec_helper.rb
└── fast-polylines-2.2.2.gem
```

Nos falta un fichero más.

```
gem spec fast-polylines-2.2.2.gem --ruby > fast-polylines-2.2.2/fast-polylines.gemspec
```

> El comando anterior sin `--ruby` extrae las especificaciones en formato YAML.

## Desinstalamos la gema

* `gem uninstall fast-polylines`, desinstalamos la gema.

## Source code

* Con `gem list |grep fast` comprobamos que no muestra nada y por tanto la gema NO está instalada en nuestro sistema.
* `git clone https://github.com/klaxit/fast-polylines.git`
* cd INTO-REPO.
* `bundle install`
* `make benchmark`
* `make test`

Comprobamos que podemos usar la gema directamente desde el directorio donde se ha generado sin necesidad de instalarla en el sistema:

```
❯ irb -Ilib -Iext

irb> require "fast-polylines"
=> true

irb> puts $LOAD_PATH

.../repo/lib
.../repo/ext
```

## Cambiando el código fuente C

* Si ejecutamos el comando `make test` vemos cómo se ejecuta la compilación y los test normalmente.
```
❯ make test
make -C ext/fast_polylines
make[1]: se entra en el directorio '.../repo/ext/fast_polylines'
compiling fast_polylines.c
linking shared-object fast_polylines/fast_polylines.so
make[1]: se sale del directorio '.../repo/ext/fast_polylines'
bundle exec rspec
.................

Finished in 0.00782 seconds (files took 0.10357 seconds to load)
17 examples, 0 failures
```

Vamos a cambiar el código fuente C.
* Descomentamos la línea siguiente del fichero `ext/fast_polylines/fast_pplylines.c` para activar los mensajes de DEBUG.
```
[CODE]
// Uncomment this line to show debug logs.
#define DEBUG 1
[CODE]
```
* Si ahora ejecutamos `make test` vemos que ahora aparecen mensajes de DEBUG durante el proceso que antes no aparecían.

## Cambiando el código fuente Ruby

Cambiando el código Ruby:
* Añadimos lo siguiente al fichero `lib/fast_polylines.rb`
```
# frozen_string_literal: true

require_relative "fast_polylines/version"
require "fast_polylines/fast_polylines"

[RESTO DEL FICHERO]
```
* Cambiamos la versión en `lib/fast_polylines/version.rb`:
```
# frozen_string_literal: true

module FastPolylines
  VERSION = "2.2.2.dev"
end
```

* `make console`. Es lo mismo que compilar el código C y luego hacer `irb -I lib:ext -r fast_polylines` como antes. Comprobamos que hemos cambiado el número de versión:

```
❯ make console
make -C ext/fast_polylines
make[1]: se entra en el directorio 'repo/ext/fast_polylines'
make[1]: No se hace nada para 'all'.
make[1]: se sale del directorio 'repo/ext/fast_polylines'
irb -I lib:ext -r fast_polylines

irb(main):001:0> pp FastPolylines::VERSION
"2.2.2.dev"
=> "2.2.2.dev"     
```

* Construimos la gema a partir del código modificado.

```
❯ gem build fast-polylines.gemspec
  Successfully built RubyGem
  Name: fast-polylines
  Version: 2.2.2.dev
  File: fast-polylines-2.2.2.dev.gem
```

* Instalamos la gema:
```
❯ gem install fast-polylines-2.2.2.dev.gem
Building native extensions. This could take a while...
Successfully installed fast-polylines-2.2.2.dev
Parsing documentation for fast-polylines-2.2.2.dev
Installing ri documentation for fast-polylines-2.2.2.dev
Done installing documentation for fast-polylines after 0 seconds
1 gem installed
```

* Comprobamos:
```
❯ gem list |grep fast
fast-polylines (2.2.2.dev)
```
