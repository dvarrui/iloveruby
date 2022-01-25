
# Encapsulamiento-poo

> Enlace de interés:
> * https://styde.net/encapsulamiento-en-la-programacion-orientada-a-objetos/

**El encapsulamiento en la programación orientada a Objetos ¿Recuerdan que este también es un elemento fundamental del modelo de objetos?** sabía que esa era la respuesta, entonces empezaremos con la lección.

## 1. Definamos Encapsulamiento

* Es el proceso de almacenar en una misma sección los elementos de una abstracción que constituyen su estructura y su comportamiento; **sirve para separar el interfaz contractual de una abstracción y su implantación**.
* Pero..! ¿Cómo consigo esto?, ¡tranquilo! esto se consigue a través de la ocultación de información, ves como todo es más fácil estando relajado, ¿No sabes que es la ocultación de información?, ¡Tranquilo!, No, aún no estás tranquilo, ¿Ya? seguimos, Ocultación de información es el proceso de ocultar «Todos los Secretos» de un objeto que no aportan a sus características específicas.
* Para que la abstracción funcione como debe, la implementación debe estar encapsulada, nunca está de más recordar que **cada clase debe tener dos partes, una interfaz y una implementación**, tranquilo no te asustes si no sabes que es una clase, ya llegaremos a ese tema, de momento manténgase concentrado en la encapsulación.


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
