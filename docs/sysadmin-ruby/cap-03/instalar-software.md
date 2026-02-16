[<< back](README.md)

# Instalar software

Cada vez que instalo el sistema operativo, suelo personalizarlo con los programas que uso habitualmente. Entonces vamos a crear un script para que nos ayude a personalizar la instalación del software de nuestro sistema.

Además, vamos a incluir comentarios en el código para ayudar a facilitar su lectura y entender lo que está ocurriendo dentro del script. O por lo menos, dar pistas al lector de las intenciones del programador.

## 1. Primer intento

Nuestro primero intento es [softwarectl.rb](example/softwarectl.rb):

```ruby
#!/usr/bin/env ruby

##
# Install OS packages
def install_packages
  system("zypper install -y tree")
  system("zypper install -y nmap")
  system("zypper install -y vim")
end

install_packages
```

> NOTA: En OpenSUSE se usa el comando zypper para instalar paquetes, de la misma forma que en Debian se usa el comando apt.

Bueno, a simple vista vemos lo siguente:
1. Primero se define un método que se encargará de instalar los paquetes especificados en el sistema operativo. Se usa el comando `zypper install -y PACKAGENAME` porque hago mis pruebas en OpenSUSE. Si tienes Debian lo puee cambiar por `apt-get install -y PACKAGENAME`.
2. Al final se invoca a dicho método.

Problemas:
1. Hay que poner muchas líneas `system`... y estamos incumpliendo una norma de todo buen programador: `DRY = Don't Repeat Yourself`.
2. Cada vez que cambia nuestra lista de paquetes hay que cambiar los dos métodos del script. Y eso... no es bueno. El script NO debería tocarse (modificarse) para usarlo.

---
## 2. Segunda versión con Iterador

El script anterior tiene muchas líneas repetidas. Cuando tenemos líneas que se repiten... hay que poner un bucle para simplificar o mejor aún, un iterador.

Hacemos [softwarectl2.rb](example/softwarectl2.rb) donde sustituimos las líneas de código con repetidas por iteradores de la forma siguiente:

```ruby
# Package names list
packages = [ 'tree', 'nmap', 'vim', 'geany' ]

##
# Install OS packages
def install(packages)
  packages.each do |package|
    system("zypper install -y #{package}")
  end
end
```

Vemos que tenemos un Array `packages` con la lista de todos los paquetes. Y usamos el método `each` para iterar sobre dicho Array e invocar la acción `system ...` a cada elemento de la lista.

Hemos conseguido mejorar en:
1. El script tiene menos líneas.
2. El código es más legible usando iteradores. Cumplimos con la nomrma DRY.
3. Cada vez que necesitemos personalizar la lista de paquetes sólo debemos modificar el Array `packages`. Por ese motivo, lo hemos puesto al comienzo del script, así no hay que tocar nada más del script.

Problemas:
1. Cada vez que cambia nuestra lista de paquetes debemos "modificar" el script. Eso... no es bueno.

[next >>](instalar-software2.md)
