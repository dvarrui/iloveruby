[<< back](README.md)

# Spawning terminal process

Una interacción común en un programa de Ruby es la de ejecutar un comando en una terminal. Esto sucede sobretodo cuando estamos escribiendo un script de Ruby para unir algunos comandos. Hay varias formas de generar procesos para ejecutar comandos de terminal en Ruby.

Antes de ver las diferentes formas de hacerlo, veamos el mecanismo que se usa en profundidad.

## fork + exec

Todos los métodos que veremos a continuación son variaciones de un tema: fork(2) + execve(2).

Ya hemos visto fork(2) en capítulos anteriores, pero este es nuestro primer vistazo a execve(2). Es bastante simple, execve(2) le permite reemplazar el proceso actual con un proceso diferente.

Dicho de otra manera: execve(2) le permite transformar el proceso actual en cualquier otro proceso. Puede tomar un proceso Ruby y convertirlo en un proceso Python, un proceso ls(1) u otro proceso Ruby.

execve(2) transforma el proceso y nunca regresa. Una vez que haya transformado su proceso de Ruby en otra cosa, nunca podrá volver.

```ruby
exec 'ls', '--help'
```

El combo fork + exec es bastante común cuando se generan nuevos procesos. execve(2) es una forma muy eficiente de transformar el proceso actual en otro; el único inconveniente es que su proceso actual se ha ido. Ahí es donde fork(2) es útil.

Puede usar fork(2) para crear un nuevo proceso, luego use execve(2) para transformar ese proceso en lo que quiera. ¡Voila! Su proceso actual sigue ejecutándose como antes y pudo generar cualquier otro proceso que desee.

Si su programa depende de la salida de la llamada execve(2), puede usar las herramientas que aprendimos en los capítulos anteriores para manejarlo. `Process.wait` se asegurará de que su programa espere a que el proceso secundario termine lo que esté haciendo para que pueda recuperar el resultado.

## Descriptores de archivos y exec


[<< back](README.md)
