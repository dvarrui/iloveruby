[<< back](../README.md)

# Traductor

> Enlace de interés:
> * https://gemini.google.com/app/459a0780fca5809a?hl=es-ES
> * https://gemini.google.com/app/136c9113fcbfad94?hl=es-ES

## Definiciones

 como se dice al programa que convierte código ruby a asm? traductor o transpilador?
Gemini said

1. Compilador: Cuando el programa toma un lenguaje de alto nivel (Ruby) y lo convierte en un lenguaje de bajo nivel (Ensamblador/ASM), lo más correcto es llamarlo Compilador.
2. Transpilador (Source-to-Source): cuando el programa convierte un lenguaje de programación en otro lenguaje de nivel similar.
    * Ejemplos: De TypeScript a JavaScript, o de CoffeeScript a Ruby.
    * Su función principal es permitir el uso de nuevas características de un lenguaje (como en JavaScript moderno) en entornos antiguos, convirtiéndolas a sintaxis compatible (por ejemplo, Babel convierte código nuevo de JS a versiones anteriores) o traduciendo lenguajes como TypeScript a JavaScript para que los navegadores lo entienda
3. Traductor (El término general): es un término paraguas que engloba a ambos. Es correcto, pero es menos técnico. En la literatura académica, a menudo se habla de "Traducción de Código", pero cuando el destino es código máquina o ensamblador, estaríamos hablando de un Compilador.

## ruby2src

El programa `ruby2src` es un multitraductor. En algunos casos compilador y en otros transpilador.
