
# fxruby

FXRuby is the Ruby binding to the FOX GUI toolkit.

## Instalación

* `gem install fxruby`

## Dependencia: g++

Se produce el siguiente error: `Gem::Ext::BuildError: ERROR: Failed to build gem native extension.`. Parece que esta gema requiere la construcción de software nativo y la línea `make: g++: No existe el fichero o el directorio` indica que no se encuentra `g++`.
* Compruebo se está el ejecutable:
```
❯ whereis g++
g++:
```
* Como tengo el SO OpenSUSE ejecuto lo siguiente para instalar g++: `zypper in gcc-c++`
* Comprobamos:
```
❯ whereis g++
g++: /usr/bin/g++ /usr/share/man/man1/g++.1.gz
```
* Repito el proceso de instalación de la gema.

## Dependencia fx.h

Se produce el siguiente error: `./include/FXRbCommon.h:72:10: error fatal: fx.h: No existe el fichero o el directorio #include "fx.h"`
* Creo que hay que instalar el paquete `fox16-devel`.
* Ahora tenemos el fichero `/usr/include/fox-1.6/fx.h`.

Ta tenemos la gema instalada.
```
❯ gem list|grep fxruby
fxruby (1.6.45)
```
