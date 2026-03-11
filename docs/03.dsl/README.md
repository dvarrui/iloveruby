[<< back](../index.md) | [HOME](../index.md) | [next >>](../01.inicio/README.md)

```
iLoveRuby -> DSL

EN CONSTRUCCION!!!
```

# Sección 3: DSL

Para mostrar con ejemplos reales que las características que hemos visto del lenguaje Ruby le permiten construir de forma sencilla casi cualquier tipo de DSL (Lenguaje específico del dominio), he creado varios ejemplos:

Para "ejecutar" los programas de ejemplo hacemos `source .nalias`, y ahora ya tenemos disponibles los "compiladores" e "intérpretes":

* [BASIC](./basic/): DSL de Ruby para crear un BASIC.
    * Para ejecutar hacemos `nbasic 01-holamundo.bas`.
* [C](./c/): DSL de Ruby para crear un C.
    * Para "compilar" hacemos `ncc 01-holamundo.c`.
    * Para ejecutar hacemos `./a.out`.
* Javascript: En desarrollo!
* LIST: En desarrollo!
* Logo: En desarrollo!
* [Python](./python/): DSL de Ruby para crear un Python.
    * Para ejecutar hacemos `npython 01-hello.py`.

En cada DSL de lenguaje tenemos la subcarpeta `lib` que contiene los ficheros de Ruby que hacen la magia para cada DSL.