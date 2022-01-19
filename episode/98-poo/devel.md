

# Características de POO

> Enlaces de interés:
> * https://es.wikibooks.org/wiki/Programaci%C3%B3n_Orientada_a_Objetos/Caracter%C3%ADsticas_de_la_POO

Parece que hay un acuerdo acerca de qué características contempla la "orientación a objetos". Según es acuerdo, las características siguientes son las más importantes:
1. Abstracción
2. Encapsulamiento
3. Modularidad
4. Ocultación

## 1. Abstracción

* Denota las características esenciales de un objeto, donde se capturan sus comportamientos.
* Cada objeto en el sistema sirve como modelo de un "agente" abstracto que puede **realizar trabajo, informar y cambiar su estado, y "comunicarse" con otros objetos** en el sistema **sin revelar cómo se implementan estas características**.

## 2. Encapsulamiento

* Significa reunir todos los elementos que pueden considerarse pertenecientes a una misma entidad, al mismo nivel de abstracción.
* Esto permite aumentar la cohesión de los componentes del sistema. Algunos autores confunden este concepto con el principio de ocultación, principalmente porque se suelen emplear conjuntamente.

## 3. Modularidad

* Propiedad que permite subdividir una aplicación en partes más pequeñas (llamadas módulos), cada una de las cuales debe ser tan independiente como sea posible de la aplicación en sí y de las restantes partes.
* Estos módulos se pueden compilar por separado, pero tienen conexiones con otros módulos. Al igual que la encapsulación, los lenguajes soportan la modularidad de diversas formas.

> En Ruby, Python los módulos no se compilan. Un cambio en un módulo no implica volver a compilar los módulos dependientes.

## 4. Principio de ocultación

* **Cada objeto está aislado del exterior**, es un módulo natural, y **cada tipo de objeto expone una interfaz a otros objetos que especifica cómo pueden interactuar con los objetos de la clase**.

> NOTA: Exponer una interfaz implica que hay unos métodos/funciones públicos que pueden ser usados para interactuar con el exterior. Y unos métodos/funciones privados que no ven hacía fuera. Son detalles de implementación.

* El aislamiento protege a las propiedades de un objeto contra su modificación por quien no tenga derecho a acceder a ellas; solamente los propios métodos internos del objeto pueden acceder a su estado. Esto asegura que otros objetos no puedan cambiar el estado interno de un objeto de manera inesperada, eliminando efectos secundarios e interacciones inesperadas.
* **Algunos lenguajes relajan esto, permitiendo un acceso directo a los datos internos del objeto de una manera controlada y limitando el grado de abstracción. La aplicación entera se reduce a un agregado o rompecabezas de objetos**.

## 5. Polimorfismo

* Comportamientos diferentes, asociados a objetos distintos, pueden compartir el mismo nombre; al llamarlos por ese nombre se utilizará el comportamiento correspondiente al objeto que se esté usando. O, dicho de otro modo, las referencias y las colecciones de objetos pueden contener objetos de diferentes tipos, y la invocación de un comportamiento en una referencia producirá el comportamiento correcto para el tipo real del objeto referenciado.

> NOTA: El polimorfismo es natural en Ruby por el "duck typing".

* **Cuando esto ocurre en "tiempo de ejecución", esta última característica se llama asignación tardía o asignación dinámica (Ejemplo Ruby)**.
* Algunos lenguajes proporcionan medios más estáticos (en "tiempo de compilación") de polimorfismo, tales como las plantillas y la sobrecarga de operadores de C++.


## 6. Herencia

* Las clases no están aisladas, sino que se relacionan entre sí, formando una jerarquía de clasificación. Los objetos heredan las propiedades y el comportamiento de todas las clases a las que pertenecen.
* La herencia organiza y facilita el polimorfismo y el encapsulamiento, permitiendo a los objetos ser definidos y creados como tipos especializados de objetos preexistentes.
* Estos pueden compartir (y extender) su comportamiento sin tener que volver a implementarlo. Esto suele hacerse habitualmente agrupando los objetos en clases y estas en árboles o enrejados que reflejan un comportamiento común.
* Cuando un objeto hereda de más de una clase se dice que hay herencia múltiple.

> NOTA: Ruby no tiene herencia múltiple. Tiene mixins. La herencia multiple genera conflictos que hay que resolver. Los mixins es una forma de reutilizar código como si fuera heredado de otra clase.

## Recolección de basura

la recolección de basura o garbage collector es la técnica por la cual el entorno de objetos se encarga de destruir automáticamente, y por tanto desvincular la memoria asociada, los objetos que hayan quedado sin ninguna referencia a ellos. Esto significa que el programador no debe preocuparse por la asignación o liberación de memoria, ya que el entorno la asignará al crear un nuevo objeto y la liberará cuando nadie lo esté usando.
    En la mayoría de los lenguajes híbridos que se extendieron para soportar el Paradigma de Programación Orientada a Objetos como C++ u Object Pascal, esta característica no existe y la memoria debe desasignarse expresamente.
