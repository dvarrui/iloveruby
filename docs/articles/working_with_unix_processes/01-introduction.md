[<< back](README.md)

# Introducción

Cuando era niño, me sentaba frente al ordenador cada vez que podía. No porque estuviera programando, sino porque estaba fascinado por las posibilidades de esta asombrosa máquina. Crecí como usuario de computadoras usando ICQ, Winamp y Napster.

A medida que crecía, pasaba más tiempo jugando videojuegos en el ordenador. Al principio me gustaban los juegos de disparos en primera persona y pasé la mayor parte de mi tiempo jugando juegos de estrategia en tiempo real. ¡Y luego descubrí que puedes jugar estos juegos en línea! A lo largo de mi juventud fui un "chico de ordenador": **sabía cómo usar las computadoras, pero no tenía idea de cómo funcionaban debajo del capó**.

La razón por la que doy mis antecedentes es porque quiero que sepan que no fui un niño prodigio. No me enseñé a mí mismo a programar Basic a los 7 años. Cuando tomé mi primera clase de programación de computadoras, no estaba enseñando al maestro, ni corrigiendo sus errores.

No fue hasta mi segundo año de carrera universitaria que realmente llegué a amar la programación como actividad. Algunos pueden decir que soy lento, pero tengo la sensación de que estoy más cerca de la norma de lo que piensas.

Aunque llegué a amar la programación por el hecho de programar en sí, todavía no tenía una buena comprensión de cómo funcionaba el ordenador debajo del capó. Si me hubieran dicho entonces que todo mi código se ejecutaba dentro de un proceso, te habría mirado de soslayo.

Afortunadamente para mí, me dieron la oportunidad de trabajar en una startup web local. Esto me dio la ocasión de hacer algo de programación en un sistema de producción real. Esto lo cambió todo para mí. Me dio una razón para aprender cómo funcionaban las cosas debajo del capó.

Mientras trabajaba en este sistema de producción de alto tráfico, se me presentaron problemas cada vez más complejos. A medida que aumentaron nuestras demandas de tráfico y recursos, **tuvimos que comenzar a analizar nuestra pila completa para depurar y solucionar problemas pendientes**. Con solo centrarnos en el código de la aplicación, no pudimos obtener una imagen completa de cómo funcionaba la aplicación.

Teníamos muchas capas delante de la aplicación: un cortafuegos, un balanceador de carga, un proxy inverso y caché http. Teníamos capas que funcionaban junto con la aplicación: cola de trabajos, servidor de base de datos y recopilador de estadísticas. Cada aplicación tendrá un conjunto diferente de componentes que la componen, y este libro no le enseñará todo lo que hay que saber sobre ella.

Este libro le enseñará todo lo que necesita saber sobre los procesos de Unix, y eso **garantiza que mejorará su comprensión de cualquier componente que funcione en su aplicación**.

A través de problemas de depuración, me vi obligado a profundizar en los proyectos de Ruby que hacían uso de conceptos de programación de Unix. Proyectos como Resque y Unicornio. Estos dos proyectos fueron mi introducción a la programación Unix en Ruby.

**Después de lograr una comprensión más profunda de cómo funcionaban, pude diagnosticar problemas más rápido y con mejor comprensión**, así como también depurar problemas molestos que no tenían sentido al mirar el código de la aplicación por sí mismo.

Incluso comencé a idear soluciones nuevas, más rápidas y más eficientes para los problemas que estaba resolviendo que usaban las técnicas que estaba aprendiendo de estos proyectos. Muy bien, basta de mí. Bajemos por la madriguera del conejo.
