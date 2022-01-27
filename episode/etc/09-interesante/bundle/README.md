

* `gem install bundle`, empezamos instalando la herramienta **bundle**.
* `mkdir demo; cd demo`, creamos un directorio nuevo para nuestro proyecto.
* `bundle init`, crea fichero Gemfile. Personalizamos el fichero Gemfile con la gemas de nuestro proyecto.
* `bundle install`, para instalar las gemas especificadas en Gemfile. Si no somos el usuario root y no tenemos permisos para instalar las gemas en las rutas del sistema, entonces las gemas se instalarán en `vendor/bundle`.

De esta forma podemos garantizar que las gemas que requiere nuestro proyecto estarán contenidas en la carpeta de nuestro proyecto.

* `bundle exec cmd`, para ejecutar nuestra aplicación y que además las gemas requeridas se buscarán en la ruta `vendor/bundle`.


