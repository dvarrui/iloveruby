
# Características de POO

> Enlaces de interés:
> * http://worrydream.com/EarlyHistoryOfSmalltalk/
> * https://es.wikibooks.org/wiki/Programaci%C3%B3n_Orientada_a_Objetos/Caracter%C3%ADsticas_de_la_POO
> * https://ferestrepoca.github.io/paradigmas-de-programacion/poo/poo_teoria/concepts.html
> * https://dewitters.com/object-oriented-programming-doesnt-need-encapsulation/

Parece que hay consenso en asociar las siguientes características a la programación  "orientación a objetos".

1. Abstracción
2. Encapsulamiento
3. Modularidad
4. Ocultación

Otras
5. Polimorfismo
6. Herencia

## 1. Abstracción

* Características esenciales de un objeto, donde se capturan sus comportamientos.
* Cada objeto en el sistema sirve como modelo de un "agente" abstracto que puede **realizar trabajos, informar y cambiar su estado, y "comunicarse" con otros objetos** en el sistema **sin revelar cómo se implementan estas características**.

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

* Comportamientos diferentes, asociados a objetos distintos, pueden compartir el mismo nombre; al llamarlos por ese nombre se utilizará el comportamiento correspondiente al objeto que se esté usando.
* Dicho de otro modo, las referencias y las colecciones de objetos pueden contener objetos de diferentes tipos, y la invocación de un comportamiento en una referencia producirá el comportamiento correcto para el tipo real del objeto referenciado.

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

---

# Encapsulamiento-poo

> Enlace de interés:
> * https://styde.net/encapsulamiento-en-la-programacion-orientada-a-objetos/

## 1. Definamos Encapsulamiento

* Es el proceso de almacenar en una misma sección los elementos de una abstracción que constituyen su estructura y su comportamiento; **sirve para separar el interfaz contractual de una abstracción y su implantación**.
* Esto se consigue a través de la ocultación de información. Ocultación de información es el proceso de ocultar «Todos los Secretos» de un objeto que no aportan a sus características específicas.
* Para que la abstracción funcione como debe, la implementación debe estar encapsulada, nunca está de más recordar que **cada clase debe tener dos partes, una interfaz y una implementación**.

Existen tres niveles de acceso para el encapsulamiento, los cuales son:
1. **Público (Public)**: Todos pueden acceder a los datos o métodos de una clase que se definen con este nivel, este es el nivel más bajo, esto es lo que tu quieres que la parte externa vea.
2. **Protegido (Protected)**: Podemos decir que estás no son de acceso público, solamente son accesibles dentro de su clase y por subclases.
3. **Privado (Private)**: En este nivel se puede declarar miembros accesibles sólo para la propia clase.

## 2. Ejemplo

Voy a hacer un pequeño ejemplo, no usaré ningún lenguaje de Programación Orientado a Objetos, debido a que el Curso es Programación Orientada a Objetos en «General».

El Ejemplo del Vehículo nuevamente, Usaremos la característica COLOR.

| Opción | Declaración |
| ------ | ----------- |
| a      |  Declaro COLOR como Privado   |
| b      |  Declaro COLOR como Protegido |
| c      |  Declaro COLOR Como Público   |

**Contexto 1:**  Se necesita que cualquiera pueda acceder a el color de un vehículo, entonces: ¡Claro!, Sí escogiste la Opción C, te has Ganado un pase al siguiente ejemplo…, de lo contrario vuelve a darle un repaso a los niveles de acceso.

**Contexto 2**: Se necesita qué color se pueda acceder a través no sólo de vehículo, sí no ahora también de Buses, y como todos sabemos un bus es un tipo de vehículo, entonces también deberá tener acceso a color. Correcta Opción b

**Contexto 3:** Se necesita que color se pueda acceder solamente para vehículo.
Correcta Opción a.

Amigos, esto ha sido todo, espero hayan comprendido lo qué es el encapsulamiento de datos, dudas al respecto pueden dejarlas en los comentarios y con gusto les estaré respondiendo.
