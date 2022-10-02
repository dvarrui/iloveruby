
# Primer

Esta sección le proporcionará antecedentes sobre algunos conceptos clave utilizados en el libro. Definitivamente se recomienda que lea esto antes de pasar a los capítulos más sustanciosos.

## ¿Por qué importa?

El modelo de programación Unix ha existido, de alguna forma, desde 1970. Fue entonces cuando se inventó Unix en Bell Labs, junto con el lenguaje o marco de programación C. En las décadas que han transcurrido desde entonces, Unix ha superado la prueba del tiempo como el sistema operativo elegido por su confiabilidad, seguridad y estabilidad.

Los conceptos y técnicas de programación de Unix no son una moda pasajera, no son el último lenguaje de programación popular. Estas técnicas trascienden los lenguajes de programación. Ya sea que esté programando en C, C++, Ruby, Python, JavaScript, Haskell o [inserte su lenguaje favorito aquí], estas técnicas SERÁN útiles.

Este material ha existido, prácticamente sin cambios, durante décadas. Los programadores inteligentes han estado utilizando la programación de Unix para resolver problemas difíciles con una multitud de lenguajes de programación durante los últimos 40 años y seguirán haciéndolo durante los próximos 40 años.

## ¡Aprovecha el poder!

Te advierto ahora, los conceptos y técnicas descritos en este libro pueden traerte un gran poder. Con este poder, puede crear software nuevo, comprender software complejo que ya existe e incluso utilizar este conocimiento para avanzar en su carrera al siguiente nivel.

Solo recuerda, un gran poder conlleva una gran responsabilidad. Sigue leyendo y te diré todo lo que necesitas saber para obtener el poder y evitar las trampas.

## Visión general

Este libro no está destinado a ser leído como un manual de referencia. Es más un recorrido. Para aprovecharlo al máximo, debe leerlo secuencialmente, ya que cada capítulo se basa en el anterior. Una vez que haya terminado, puede usar los encabezados de los capítulos para encontrar información si necesita un repaso.

Este libro contiene muchos ejemplos de código. Le recomiendo encarecidamente que los siga ejecutándolos usted mismo en un intérprete de Ruby. Jugar con el código usted mismo y hacer ajustes ayudará a que los conceptos se asimilen mucho más.

Una vez que haya leído el libro y jugado con los ejemplos, estoy seguro de que querrá tener en sus manos un proyecto del mundo real que sea un poco más profundo. Luego, eche un vistazo al proyecto Spyglass incluido.

Spyglass es un servidor web que se creó específicamente para su inclusión en este libro. Está diseñado para enseñar conceptos de programación Unix. Toma los conceptos que se aprenden aquí y muestra cómo se usarían en un proyecto del mundo real. Eche un vistazo al último capítulo de este libro para una introducción más profunda.

## Llamadas al sistema

Para comprender las llamadas al sistema primero se requiere una explicación rápida de los componentes de un sistema Unix, específicamente el espacio de usuario frente al núcleo.

El núcleo de su sistema Unix se asienta sobre el hardware de su computadora. Es un intermediario para cualquier interacción que deba ocurrir con el hardware. Esto incluye cosas como escribir/leer desde el sistema de archivos, enviar datos a través de la red, asignar memoria o reproducir audio a través de los altavoces. Dada su potencia, los programas no tienen permitido el acceso directo al kernel. Cualquier comunicación se realiza a través de llamadas al sistema.

La interfaz de llamada al sistema conecta el kernel con el espacio del usuario. Define las interacciones que se permiten entre su programa y el hardware de la computadora.

En el espacio de usuario es donde se ejecutan todos sus programas. Puede hacer mucho en sus programas de la zona de usuario sin hacer uso de una llamada al sistema: operaciones matemáticas, operaciones de cadenas, controlar el flujo con declaraciones lógicas. Pero diría que si desea que sus programas hagan algo interesante, deberá involucrar al kernel a través de llamadas al sistema.

Si fuera un programador de C, estas cosas probablemente serían una segunda naturaleza para ti. Las llamadas al sistema están en el corazón de la programación C.

Pero espero que usted, como yo, no tenga experiencia en programación C. Aprendiste a programar en un lenguaje de alto nivel. Cuando aprendió a escribir datos en el sistema de archivos, no le dijeron qué llamadas al sistema hacen que eso suceda.

La conclusión es que las llamadas al sistema permiten que sus programas de espacio de usuario interactúen con el hardware de su computadora, a través del kernel. Veremos las llamadas al sistema más comunes a medida que avancemos en los capítulos.

## Nomenclatura, wtf(2)

Uno de los obstáculos para aprender sobre la programación de Unix es dónde encontrar la documentación adecuada. ¿Quieres escuchar al kicker? Todo está disponible a través de las páginas de manual de Unix (páginas de manual), y si está utilizando una computadora basada en Unix en este momento, ¡ya está en su computadora!

Si nunca ha usado páginas de manual antes, puede comenzar invocando el comando man man desde una terminal.

Perfecto, ¿verdad? Bueno, algo así. Las páginas de manual para la API de llamada al sistema son un gran recurso para las siguientes dos situaciones:

1. Un programador de C que quiere saber cómo invocar una determinada llamada al sistema, o
1. Averiguar el propósito de una determinada llamada al sistema
