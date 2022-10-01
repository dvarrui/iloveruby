[<<back](../README.md)

# Programación Orientada a Objetos

Vamos a ver la POO de Ruby en varios niveles.

## Clase

Una clase es una especie de "plantilla" en la que se definen los atributos y métodos predeterminados de un tipo de objeto. Esta plantilla se crea para poder crear objetos fácilmente. Al método de crear nuevos objetos mediante la lectura y recuperación de los atributos y métodos de una clase se le conoce como instanciación.

> Los atributos de una instancia de clase de escriben con "@" al principio. Por ejemplo `@name`. Los métodos/funciones de clase se definen dentro de la clase con `def`, igual que cualquier método/función.

![Ejemplo](files/objetos-01-instancia.rb)

## Herencia

Herencia de la clase `Person` a la clase `Jedi`, es la facilidad mediante la cual la clase `Jedi` hereda en ella cada uno de los atributos y operaciones de `Person`, como si esos atributos y operaciones hubiesen sido definidos por la misma `Jedi`.

![Ejemplo](files/objetos-02-herencia.rb)

## Ocultación

Cuando usamos una instancia de una clase, podemos usar los métodos y variables registrados como "públicos". En Ruby por defecto: todos los métodos/funciones son públicos, y todos los atributos por defecto son privados.

Los componentes registrados como "privados" (private) mantienen escondidos al programador y solo pueden ser accedidos a través de otros métodos públicos.

![Ejemplo](files/objetos-03-ocultacion.rb)

Salida:
```
naw-ibO
Can't invoke private method!
```

![Ejemplo](files/objetos-04-ocultacion-y-herencia.rb)

Salida:
```
naw-ibO
Can't invoke private method!
```

---
[Continuar con objetos 2a parte >>](objetos2.md)
