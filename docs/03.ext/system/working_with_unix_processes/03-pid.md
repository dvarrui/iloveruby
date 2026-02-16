[<< back](README.md)

# Los procesos tienen ID

Cada proceso que se ejecuta en su sistema tiene un identificador de proceso único, denominado "pid".

El pid no dice nada sobre el proceso en sí, es simplemente una etiqueta numérica secuencial. Así es como el núcleo ve su proceso: como un número.

Así es como podemos inspeccionar el pid actual en un programa Ruby. Enciende irb y prueba esto:

```ruby
# This line will print the pid of the current ruby process. This might be an
# irb process, a rake process, a rails server, or just a plain ruby script.
puts Process.pid
```

Un pid es una representación simple y genérica de un proceso. Como no está ligado a ningún aspecto del contenido del proceso, puede entenderse desde cualquier lenguaje de programación y con cualquier sencilla herramienta. Veremos a continuación cómo podemos usar el pid para rastrear los detalles del proceso usando diferentes utilidades.

## Referencias cruzadas

Para obtener una imagen completa, podemos usar ps(1) para hacer una referencia cruzada de nuestro pid con lo que ve el kernel. Dejando su sesión `irb` abierta, ejecute el siguiente comando en una terminal:

```
$ ps -p <pid-of-irb-process>
```

Este comando debería mostrar un proceso llamado 'irb' con un pid que coincida con lo que se imprimió en la sesión de irb.

## En el mundo real

Solo saber el pid no es tan útil en sí mismo. Entonces, ¿dónde se usa?

Un lugar común donde encontrará pids en el mundo real es en los archivos de registro. Cuando tiene múltiples procesos iniciando sesión en un archivo, es imperativo que se pueda saber qué línea de registro proviene de qué proceso. Incluir el pid en cada línea resuelve ese problema.

Incluir el pid también le permite cruzar información de referencia con el sistema operativo, mediante el uso de comandos como top(1) o lsof(8). Aquí hay algunos resultados de ejemplo del arranque del servidor Spyglass. Los primeros corchetes de cada línea indican el pid de donde proviene la línea de registro.

```
[58550] [Spyglass::Server] Listening on port 4545
[58550] [Spyglass::Lookout] Received incoming connection
[58557] [Spyglass::Master] Loaded the app
[58557] [Spyglass::Master] Spawned 4 workers. Babysitting now...
[58558] [Spyglass::Worker] Received connection
```

## Llamadas al sistema

`Process.pid` de Ruby se asigna a getpid(2).

También hay una variable global que contiene el valor del pid actual. Se puedes acceder al valor a través de `$$`.

Ruby hereda este comportamiento de otros lenguajes anteriores (tanto Perl como bash son compatibles con `$$`), sin embargo, lo evito cuando es posible. Escribir `Process.pid` en su totalidad es mucho más expresivo de su intención que la variable dólar-dólar, y es menos probable que confunda a aquellos que no han visto el dólar-dólar antes.

[<< back](README.md)
