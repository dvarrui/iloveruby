
Enlaces de interés:
* [How do I use Selenium with Ruby?](https://www.tutorialspoint.com/how-do-i-use-selenium-with-ruby)
* https://www.selenium.dev/documentation/webdriver
* https://www.lambdatest.com/blog/selenium-ruby/

# Instalación y configuración

Instalar al gema:
* `gem install "selenium-webdriver"`

Descargar el driver:
* https://www.selenium.dev/documentation/webdriver/getting_started/install_drivers/
* `wget https://github.com/mozilla/geckodriver/releases/download/v0.31.0/geckodriver-v0.31.0-linux64.tar.gz`

# Docker 

Los script se pueden ejecutar en la máquina real si hemos instalado las dependencias (punto anterior), o
también lo podemos ejecutar desde un contenedor docker de la siguiente forma:

```bash
./docker/run.sh 01-example.rb
```



