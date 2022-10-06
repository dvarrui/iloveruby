[<< back](README.md)

# Entorno del proceso

Entorno, en este sentido, se refiere a lo que se conoce como "variables de entorno". Las variables de entorno son pares clave-valor que contienen datos para un proceso.

Cada proceso hereda variables de entorno de su padre. Los establece un proceso principal y los heredan sus procesos secundarios. Las variables de entorno son por proceso y son globales para cada proceso.

Aquí hay un ejemplo simple de cómo configurar una variable de entorno en una Shell `bash`, iniciar un proceso de Ruby y leer esa variable de entorno.

```bash
$ MESSAGE='wing it' ruby -e "puts ENV['MESSAGE']"
```

La sintaxis `VAR=value` es la forma `bash` de establecer variables de entorno. Lo mismo se puede lograr en Ruby usando la constante `ENV`.

```ruby
# The same thing, with places reversed!
ENV['MESSAGE'] = 'wing it'
system "echo $MESSAGE"
```

Ambos ejemplos imprimen: "wing it".

En bash, se accede a las variables de entorno utilizando la sintaxis: `$VAR`. Como se puede ver en estos ejemplos, las variables de entorno se pueden usar para compartir el estado entre procesos que ejecutan diferentes lenguajes, `bash` y `ruby` en este caso.

## Es un hash, ¿verdad?

Aunque `ENV` usa la API de acceso de estilo hash, en realidad no es un `Hash`. Por ejemplo, implementa `Enumerable` y parte de la API `Hash`, pero no todo. No se implementan métodos clave como `merge`. Se puede hacer cosas como `ENV.has_key?`, pero no cuente con que todas las operaciones hash funcionen.

```ruby
puts ENV['EDITOR']
puts ENV.has_key?('PATH')
puts ENV.is_a?(Hash)

# outputs:
# => vim
# => true
# => false
```

## En el mundo real

En el mundo real, las variables de entorno tienen muchos usos. Aquí hay algunos que son flujos de trabajo comunes en la comunidad de Ruby:

```bash
$ RAILS_ENV=production rails server
$ EDITOR=mate bundle open actionpack
$ QUEUE=default rake resque:work
```

Las variables de entorno se utilizan a menudo como una forma genérica de aceptar entradas en un programa de línea de comandos. Cualquier terminal (en Unix o Windows) ya los soporta y la mayoría de los programadores están familiarizados con ellos. El uso de variables de entorno suele ser menos costoso que analizar explícitamente las opciones de la línea de comandos.

## Llamadas al sistema

No hay llamadas al sistema para manipular directamente las variables de entorno, pero las funciones de la biblioteca C setenv(3) y getenv(3) hacen la mayor parte del trabajo. También eche un vistazo a environ(7) para obtener una descripción general.

[<< back](README.md)
