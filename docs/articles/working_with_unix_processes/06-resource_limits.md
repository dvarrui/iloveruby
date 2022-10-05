[<< back](README.md)

# Límite de recursos del proceso

En el último capítulo analizamos el hecho de que los recursos abiertos están representados por descriptores de archivos. Es posible que haya notado que cuando los recursos no se cierran, los números de descriptor de archivo continúan aumentando. Surge la pregunta: ¿cuántos descriptores de archivos puede tener un proceso?

La respuesta depende de la configuración de su sistema, pero lo importante es que **hay algunos límites de recursos que son impuestos al proceso por el núcleo**.

## Encontrar los límites

Continuaremos con el tema de los descriptores de archivos. Usando Ruby podemos consultar el número máximo de descriptores de archivo permitidos:

```ruby
p Process.getrlimit(:NOFILE)
# On my machine this snippet outputs:
# => [2560, 9223372036854775807]
```

Usamos `Process.getrlimit(:NOFILE)` para consultar la cantidad máxima de archivos abiertos. Devolvió un Array de dos elementos.

El primer elemento de la matriz es el límite suave para la cantidad de descriptores de archivos, el segundo valor es el límite estricto para la cantidad de descriptores de archivos.

# Límites blandos frente a límites duros

¿Cual es la diferencia? Me alegro de que preguntas. El límite suave no es realmente un límite. Lo que significa que si supera el límite suave (en este caso, al abrir más de 2560 recursos a la vez), se generará una excepción, pero siempre se puede cambiar ese límite si lo desea.

Tenga en cuenta que el límite estricto en mi sistema para la cantidad de descriptores de archivos es un número entero ridículamente grande. ¿Es posible abrir tantos? Probablemente no, estoy seguro de que te encontrarás con restricciones de hardware antes de que se puedan abrir muchos recursos a la vez.

En mi sistema, ese número en realidad representa el infinito. Se repite en la constante `Process::RLIM_INFINITY`. Intente comparar esos dos valores para estar seguro. Entonces, en mi sistema, puedo abrir efectivamente tantos recursos como desee, una vez que alcance el límite suave para mis necesidades.

Entonces, cualquier proceso puede cambiar su propio límite suave, pero ¿qué pasa con el límite duro? Por lo general, eso solo lo puede hacer un superusuario. Sin embargo, su proceso también puede superar el límite estricto suponiendo que tenga los permisos necesarios. Si está interesado en cambiar los límites a nivel de todo el sistema, comience por echar un vistazo a sysctl(8).

# Superando el límite suave

Avancemos y superemos el límite suave para el proceso actual:

```ruby
Process.setrlimit(:NOFILE, 4096)
p Process.getrlimit(:NOFILE)

# outputs:
# => [4096, 4096]
```

Puede ver que se estableció un nuevo límite para el número de archivos abiertos, y al solicitar ese límite nuevamente, tanto el límite estricto como el límite flexible se establecieron en el nuevo valor 4096.

Opcionalmente, podemos pasar un tercer argumento a `Process.setrlimit` especificando también un nuevo límite estricto, suponiendo que tengamos los permisos para hacerlo. Tenga en cuenta que bajar el límite estricto, como hicimos en el último fragmento, es irreversible: una vez que baja, no vuelve a subir.

El siguiente ejemplo es una forma común de aumentar el límite flexible de un recurso del sistema para que sea igual al límite estricto, el valor máximo permitido.

```ruby
Process.setrlimit(:NOFILE, Process.getrlimit(:NOFILE)[1])
```

# Excediendo el límite

Tenga en cuenta que exceder el límite suave generará `Errno::EMFILE`:

```ruby
# Set the maximum number of open files to 3. We know this
# will be maxed out because the standard streams occupy
# the first three file descriptors.
Process.setrlimit(:NOFILE, 3)

File.open('/dev/null')

# outputs:
# => Errno::EMFILE: Too many open files - /dev/null
```

# Otros recursos

Puede utilizar estos mismos métodos para comprobar y modificar los límites de otros recursos del sistema. Algunos comunes son:

```ruby
# El número máximo de procesos simultáneos
# permitido para el usuario actual.
Process.getrlimit(:NPROC)

# El archivo de mayor tamaño que se puede crear.
Process.getrlimit(:FSIZE)

# El tamaño máximo del segmento de pila del proceso.
Process.getrlimit(:STACK)
```

Consulte la documentación (http://www.ruby-doc.org/core-1.9.3/Process.html#method-c-setrlimit) de `Process.getrlimit` para consultar el listado completo de las opciones disponibles.

# En el mundo real

La necesidad de modificar los límites de los recursos del sistema no es una necesidad habitual para la mayoría de los programas. Sin embargo, para algunas herramientas especializadas esto puede ser muy importante.

Un caso de uso es cualquier proceso que necesite manejar miles de conexiones de red simultáneas. Un ejemplo de esto es la herramienta de rendimiento httperf(1) http. Un comando como `httperf --hog --server www --num-conn 5000` le pedirá a httperf(1) que cree 5000 conexiones simultáneas. Obviamente, esto será un problema en mi sistema debido a su límite flexible predeterminado, por lo que httperf(1) deberá superar su límite flexible antes de que pueda realizar la prueba correctamente.

Otro caso de uso real para limitar los recursos del sistema es una situación en la que se ejecuta código de terceros y se necesita mantenerlo dentro de ciertas restricciones. Puede establecer límites para los procesos que ejecutan ese código y revocar los permisos necesarios para cambiarlos, asegurándose así de que no utilicen más recursos de los que les permite.

# Llamadas al sistema

`Process.getrlimit` y `Process.setrlimit` de Ruby se asignan a getrlimit(2) y setrlimit(2), respectivamente.

[<< back](README.md)
