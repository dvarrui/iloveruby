
```
EN PROGRESO!!!
```

# Warnings en Ruby: No los ignores!!!

> Enlace al vídeo original:
> * [RubySur - Marzo 2026](https://www.youtube.com/live/IJRtU7XlZwM?is=cQ3tW6bVh6_bfUUk)

* Los warnings son mensajes que emite Ruby.
* Los warnings no son ruido en los logs. Son muy útiles.

Tipos de warnings:
- performance
- cuando sucede un overwrite de un método
- etc

* Se pueden emitir warnings en cualquier momento, usando el método `warn` del `Kernel`.
* Firma del método: `def warn(*msg, uplevel: nil, category: nil)`.
    - `uplevel:`, cuantas líneas del stack se muestran en el warning.
    - `category:`, 3 posibles categorías.
        - `:deprecated`
        - `:experimental`
        - `:performance`
        - otros sin categoría?

