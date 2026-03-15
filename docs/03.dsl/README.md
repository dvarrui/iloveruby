[<< back](../index.md) | [HOME](../index.md) | [next >>](../01.inicio/README.md)

```
iLoveRuby -> DSL

EN CONSTRUCCION!!!
```

# Sección 3: DSL

> Enlaces de interés:
> * [Write your own DSL in Ruby | Tom de Bruijn](https://tomdebruijn.com/posts/ruby-write-your-own-domain-specific-language/): Let's create our own Domain Specific Language. We'll use our metaprogramming toolbox for Ruby to configure a gem and have Ruby write code for us.

## Definición

Un DSL (Domain Specific Languaje) es un lenguaje diseñado específicamente para resolver problemas en un dominio particular. El objeto de resolver un problema usando DSL es que de esta forma se aumenta la productividad al ofrecer una sintaxis concisa y cercana al lenguaje del negocio, facilitando la comunicación con usuarios no técnicos.

## Características

El lenguaje de programación Ruby tiene unas características que lo hacen ideal para crear DSL, por ejemplo:

* El tipado dinámico de mucha flexibilidad.
* Los paréntesis de los métodos son opcionales.
* Los closures o bloques de código son objetos que se pasan por parámetros pero además se pueden pasar de forma "natural" como el "último" parámetro implícito del método.
* Hay varias formas de implementar metaprogramación.
* El método `method_missing` puede "capturar" invocaciones que no existen y actuar de forma controlada.
* El punto y coma para separar las sentencias es opcional.
* "Casi" toda sentencia es una expresión y por tanto, siempre devuelve algo.
* etc.

## Ejemplos

Se han creado los siguientes DSL de ejemplo para demostrar en la práctica real que la teoría sobre Ruby funciona.

* [BASIC](./basic/): DSL de Ruby para crear el lenguaje de programación nBASIC.
    * Para ejecutar hacemos `nbasic 01-holamundo.bas`.
* [C](./c/): DSL de Ruby para crear el lenguaje de programación nC.
    * Para "compilar" hacemos `ncc 01-holamundo.c`.
    * Para ejecutar hacemos `./a.out`.
* [Python](./python/): DSL de Ruby para crear el lenguaje de programación nPython.
    * Para ejecutar hacemos `npython 01-hello.py`.
* [si-entonces](./si-entonces/README.md): DSL de Ruby para recrear la estructura condicional del lenguaje usando las propiedades del propio Ruby.

> En Desarrollo: Javascript, LIST  y Logo.

## Desarrollo

* Para cada DSL se ha creado la subcarpeta `lib` que contiene los ficheros que hacen la "magia" de convertir Ruby en un lenguaje diferente.
* La carga de los alias `.nalias` es para aumentar el efecto de la magia, creando los alias `nbasic`, `ncc`, `npython`, como si fueran los intérpretes o compiladores del lenguaje imitado.
* El nombre `nbasic`, no significa "New Basic" sino "No es Basic".

## Otros

* [apiguy/kiddo](https://github.com/apiguy/kiddo): A Shoes-inspired Ruby DSL for building simple WPF and Silverlight applications (2010, IronRuby)

