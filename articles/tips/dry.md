

# dry-logger

> Enlace de interés: https://dry-rb.org/gems/dry-logger/1.0/

## Introducción

`dry-logger` proporciona una solución de logging independiente y sin dependencias, adecuada para cualquier aplicación de Ruby.

* Registro estructurado por defecto.
* Registro en múltiples destinos a través de `backends` de logging conectables.
* Formateo detallado de registros mediante `formaters`.
* Lógica de registro personalizable a través del filtrado de registros.
* Registro de excepciones listo para usar.
* Soporte integrado para plantillas de registro de texto con salida coloreada personalizable.
* Soporte integrado para entradas de registro etiquetadas.
* API pública para agregar sus propios `backends` y `formaters`.

## Configuración básica

Para configurar un logger `$stdout` básico, simplemente hay que usar el método de configuración principal `Dry.Logger`:

```ruby
logger = Dry.Logger(:my_app)

logger.info "Hello World"
# Hello World
```

El método acepta varias opciones para configurar el logger. Puede cambiar el `formater` predeterminado, proporcionar plantillas de texto personalizadas, etc.

Veamos una plantilla de registro más detallada que muestre más información en la salida:

```ruby
logger = Dry.Logger(:test, template: :details)

logger.info "Hello World"
# [test] [INFO] [2022-11-17 11:43:52 +0100] Hello World
```

## Usando varios destinos de log

Puede configurar su `logger` para iniciar sesión en más de un destino. En el caso del `logger` predeterminado, el destino se establece en `$stdout`. Supongamos que desea iniciar sesión tanto en `$stdout` como en un archivo:

```ruby
logger = Dry.Logger(:test, template: :details).add_backend(stream: "logs/test.log")

# This goes to $stdout and logs/test.log too
logger.info "Hello World"
# [test] [INFO] [2022-11-17 11:46:12 +0100] Hello World
```

# Registro condicional

Se puede indicar a los `backends` cuándo deben iniciar sesión usando la opción `log_if`. Se puede configurar como un símbolo que representa un método que implementa `Dry::Logger::Entry` o como un proceso personalizado.

Veamos un ejemplo:

```ruby
logger = Dry.Logger(:test, template: :details)
  .add_backend(stream: "logs/requests.log", log_if: -> entry { entry.key?(:request) })

# This goes only to $stdout
logger.info "Hello World"
# [test] [INFO] [2022-11-17 11:50:12 +0100] Hello World

# This goes to $stdout and logs/requests.log
logger.info "GET /posts", request: true
# [test] [INFO] [2022-11-17 11:51:50 +0100] GET /posts request=true
```

## Usando plantillas personalizadas

Puede proporcionar plantillas de registro de texto personalizadas utilizando la sintaxis normal Ruby de plantillas de cadenas tokenizadas:

```ruby
logger = Dry.Logger(:test, template: "[%<severity>s] %<message>s")

logger.info "Hello World"
# [INFO] Hello World
```

Se admiten los siguientes tokens:

| Token        | Descripción |
| ------------ | ----------- |
| %\<progname>s | el nombre de su registrador, es decir, `Dry.Logger(:test)`` establece progname='test'|
| %\<gravedad>s | nombre del nivel de registro |
| %\<time>s     | marca de tiempo de entrada de registro |
| %\<mensaje>s  | mensaje de texto de registro pasado como una cadena, es decir, `logger.info("Hello World")` establece el mensaje en "Hello World" |
| %\<payload>s  | carga útil de entrada de registro opcional proporcionada como palabras clave, es decir, `logger.info(text: "Hello World")`` establece el payload en {text: "Hello World"} y su presentación depende del formateador que se utilice |

Además, puede usar claves de payload que se espera que se pasen a un backend de registro específico. Aquí hay un ejemplo:

```ruby
logger = Dry.Logger(:test, template: "[%<severity>s] %<verb>s %<path>s")

logger.info verb: "GET", path: "/users"
# [INFO] GET /users 
```
