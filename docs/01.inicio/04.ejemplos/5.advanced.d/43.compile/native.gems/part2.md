[<<back](README.md)

# Native gems (part2)

> Part 2 - This goes into the details of how ruby loads the native gem and extension (and includes a nice sequence diagram of how all the bits happen together): https://notepad.onghu.com/2023/learning-by-reversing-s1-e2-native-gems/

_La Parte 2 explica cómo Ruby recoge y usa la gema cuando la necesita. Viajaremos a través de varios archivos para descubrir qué está sucediendo. No vamos a reconstruir la gema ni mirar el Makefile, etc. en esta publicación._

## ¿Qué sucede cuando requerimos una gema?

Cuando se necesita una gema, suceden dos cosas:
* La ruta de la gema se agrega a `$LOAD_PATH`. Esto le permite solicitar otros archivos dentro de la ruta de esa gema.
* El archivo `required` se carga, es decir, Ruby ejecuta el archivo

Comencemos irb y simplemente consultemos LOAD_PATH.

```
irb(main):001:0> puts $LOAD_PATH

/home/david/.rbenv/rbenv.d/exec/gem-rehash
/home/david/.rbenv/versions/3.1.3/lib64/ruby/gems/3.1.0/gems/irb-1.6.2/lib
/home/david/.rbenv/versions/3.1.3/lib64/ruby/gems/3.1.0/gems/io-console-0.6.0/lib
/home/david/.rbenv/versions/3.1.3/lib64/ruby/gems/3.1.0/extensions/x86_64-linux/3.1.0/io-console-0.6.0
/home/david/.rbenv/versions/3.1.3/lib64/ruby/gems/3.1.0/gems/reline-0.3.2/lib
/home/david/.rbenv/versions/3.1.3/lib64/ruby/gems/3.1.0/gems/fiddle-1.1.1/lib
/home/david/.rbenv/versions/3.1.3/lib64/ruby/gems/3.1.0/extensions/x86_64-linux/3.1.0/fiddle-1.1.1
/home/david/.rbenv/versions/3.1.3/lib64/ruby/gems/3.1.0/gems/power_assert-2.0.3/lib
/home/david/.rbenv/versions/3.1.3/lib64/ruby/gems/3.1.0/gems/irb-power_assert-0.1.1/lib
/home/david/.rbenv/versions/3.1.3/lib64/ruby/site_ruby/3.1.0
/home/david/.rbenv/versions/3.1.3/lib64/ruby/site_ruby/3.1.0/x86_64-linux
/home/david/.rbenv/versions/3.1.3/lib64/ruby/site_ruby
/home/david/.rbenv/versions/3.1.3/lib64/ruby/vendor_ruby/3.1.0
/home/david/.rbenv/versions/3.1.3/lib64/ruby/vendor_ruby/3.1.0/x86_64-linux
/home/david/.rbenv/versions/3.1.3/lib64/ruby/vendor_ruby
/home/david/.rbenv/versions/3.1.3/lib64/ruby/3.1.0
/home/david/.rbenv/versions/3.1.3/lib64/ruby/3.1.0/x86_64-linux
=> nil
```

La mayoría de las rutas anteriores apuntan a lugares genéricos donde encontrar gemas u otros archivos fuente de Ruby. Ahora hagamos `require "fast_polylines"` y consultemos $LOAD_PATH. Ahora aparecen 2 rutas nuevas:

```
irb(main):002:0> require "fast_polylines"
irb(main):003:0> puts $LOAD_PATH
...
/home/david/.rbenv/versions/3.1.3/lib64/ruby/gems/3.1.0/gems/fast-polylines-2.2.2/lib
/home/david/.rbenv/versions/3.1.3/lib64/ruby/gems/3.1.0/extensions/x86_64-linux/3.1.0/fast-polylines-2.2.2
```

Enlaces de interés:
* [Requiring code](https://guides.rubygems.org/rubygems-basics/#requiring-code)
* [How require is implemented](https://github.com/rubygems/rubygems/blob/7abe7a68fa798d890135c76db284c376f4d9626e/lib/rubygems/core_ext/kernel_require.rb#L23)

## Entonces, ¿qué hay disponible después de require?

Ruby mantiene una lista de todos los archivos cargados en $LOADED_FEATURES.

```
/home/david/.rbenv/versions/3.1.3/lib64/ruby/gems/3.1.0/gems/fast-polylines-2.2.2/lib/fast_polylines/fast_polylines.so
/home/david/.rbenv/versions/3.1.3/lib64/ruby/gems/3.1.0/gems/fast-polylines-2.2.2/lib/fast_polylines.rb
```

Por ejemplo `lib/fast_polylines/fast_polylines.so` es la biblioteca compartida nativa que también cargó Ruby.

> [Documentación del Kernel sobre require](https://ruby-doc.org/core-3.1.0/Kernel.html#method-i-require)
>
> * Si el nombre del archivo tiene la extensión “.rb”, se carga como archivo fuente.
> * Si la extensión es “.so”, “.o” o “.dll”, o extensión de biblioteca compartida predeterminada en la plataforma actual, Ruby carga la biblioteca compartida como una extensión de Ruby.

Cuando Ruby carga una extensión nativa, hace una cosa más: llama a una función llamada `Init_LIBRARY` desde esa extensión. En nuestro caso, la extensión se llama `fast_polylines`, por lo que invocará a un método llamado `Init_fast_polylines` desde el código fuente C compilado.

Observando el código C en el directorio `ext/fast_polylines`, lo encontramos al final del archivo.

```c
void Init_fast_polylines() {
	VALUE mFastPolylines = rb_define_module("FastPolylines");
	rb_define_module_function(mFastPolylines, "decode", rb_FastPolylines__decode, -1);
	rb_define_module_function(mFastPolylines, "encode", rb_FastPolylines__encode, -1);
}
```

Este código define un módulo llamado `FastPolylines` con dos métodos (`decode` y `encode`) para que una vez que cargada la extensión nativa estarán disponibles para Ruby.

## Resumiendo

Hemos visto lo siguiente:
1. Una vez instalada la gema, necesitamos que algunos archivos estén en el lugar correcto.
    * El archivo que queremos incluir de nuestro código debe estar en lib dentro de la carpeta gem. Puede estar en una subcarpeta (por ejemplo, lib/a pero luego debemos hacer un `require "a/file.rb"`)
    * La extensión nativa compilada debe estar en: lib/gem_name/gem_name.so
2. Hacer un require implica que Rubygems cambie la ruta de carga y cargue el archivo principal.
3. El primer archivo que se requiere debe cargar la biblioteca compartida nativa
4. La biblioteca nativa debe tener una función Init_LIBRARY que establezca el puente entre Ruby y el código C
5. Ruby llamará a esa función cuando se cargue el archivo de extensión

![](https://notepad.onghu.com/images/posts/lbr-gem/02.require-native-gem.png)


En realidad no vamos a tener que preocuparnos de todos estos detalles: Ruby y Rubygems se encarga de ello. Sin embargo, comprenderlo cómo funciona no puede ayudar a depurar problemas inesperados.

## Mirando hacia el futuro

Ya hemos visto la carga del código de la gema y la extensión nativa.

En la siguiente parte, veremos detalles más específicos de nuestro código.
