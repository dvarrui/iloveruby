
# Redis

> Enlaces de interés:
> * https://www.ionos.es/digitalguide/hosting/cuestiones-tecnicas/redis-tutorial-paso-a-paso/
> * Documentación: https://redis.io/docs/data-types/
> * Usar el cliente (https://redis.io/docs/manual/cli/)

## Instalación

Redis es un base de datos en memoria. Para trabajar con ella lo primero es instalar el software necesario.

* `zypper in redis` para instalar Redis (servidor y comandos) en la máquina.
* `sudo redis-server`. Lo primero es iniciar el servicio Redis.

## Ejemplo de uso

* Desde otra terminar iniciamos el comando cliente `redis-cli`.

> Para que podamos conectarnos con el cliente, se supone que antes debemos siempre iniciar el servidor.

* Nos aparece un prompt `127.0.0.1:6379>` que nos indica a qué base de datos Redis nos hemos conectado.

Desde este prompt podemos lanzar comandos a Redis. Veamos algunos ejemplos:

```
❯ redis-cli
127.0.0.1:6379> ping
PONG
127.0.0.1:6379> get hola
(nil)
127.0.0.1:6379> set hola "Hola Mundo!"
OK
127.0.0.1:6379> get hola
"Hola Mundo!"
127.0.0.1:6379> quit
```

* Aunque se cierre el cliente, si lo volvemos a iniciar, vemos que se vuelve a conectar con la base de datos en memoria y que la información se mantiene almacenada.
* Si paramos el servidor el cliente ya no podrá acceder a la información. Además cuando se cierra el servidor, éste crea un fichero `dumb.rdb` donde guarda toda la información (Ejemplo: `hola = "Hola Mundo!"`) que había en memoria.
* Si volvemos a iniciar el servidor, éste lee el contenido de `dump.rdb` para restaurar la información que teníamos guardada.

## Ruby binding

En lugar de usar comandos de Redis para interactuar con la base de datos, podemos crear nuestro programa Ruby y usar la gema `redis`.

* `gem install redis`, para instalar el binding ruby a redis
* `ruby 01-set.rb`, ejemplo para escribir valores en Redis.
* `ruby 02-set.rb`, ejemplo para leer valores en Redis.

## Distributed

* Ejemplo `examples/distributed_redis.rb`.
* Se trabaja en paralelo en varias BD Redis para todas las operaciones.
