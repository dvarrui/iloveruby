

> Akshay @ak_rails) https://twitter.com/ak_rails/status/1592918377877889024?t=e0E1idA--CBREYIAbvz7AQ&s=35

* El método `Kernel#binding` devuelve un objeto `Binding` que envuelve el contexto actual.
* Esto le permite acceder a las variables, métodos y `self` en el ámbito donde se llamó a `binding` en cualquier otro lugar del código.
* Las plantillas ERB usan `binding` para crear una salida dinámica de la siguiente manera:

![](https://pbs.twimg.com/media/FhsuF2HaAAAzflH?format=jpg&name=small)

* Para obtener más detalles, consulte la [siguiente publicación](https://www.akshaykhot.com/render-dynamic-views-using-erb/), donde se  utiliza el método `binding` para crear vistas dinámicas similares a las de Rails.
* No es exactamente como lo hace Rails, pero las ideas básicas son similares.
