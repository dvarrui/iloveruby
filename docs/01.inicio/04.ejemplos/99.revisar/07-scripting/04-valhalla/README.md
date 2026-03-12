
# Valhalla

Es un ejemplo de creación de un _mini Gestor de Infraestructura_ usando Ruby.
* El nodo master tendrá instalada esta herramienta.
* Los nodos esclavos tendrán el servidor SSH configurado para poder entrar de forma remota.

---

# Configurar acceso remoto SSH

* Ir al master. Generar certificados `ssk-keygen`.
* `ssh-copy-id root@192.168.1.111` copiar certificados al cliente.
* Comprobar `ssh root@ip-cliente` y entramos sin la clave.
