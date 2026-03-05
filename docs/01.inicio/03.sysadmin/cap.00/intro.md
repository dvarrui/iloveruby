[<< back](../README.md) | [HOME](../README.md) | [next >>](./presentar.md)

# 0. Introducción

```
A: ¿Un administrador de sistemas necesita saber scripting?
P: Sí, claro
A: Pero eso es para programadores, yo quiero ser sysadmin
P: Por eso
```

El scripting es la herramienta que permite automatizar tareas sysadmin complejas de forma sencilla. ¿Vas a seguir haciendo las cosas "manualmente"? 

Hoy en día, un administrador que no sabe programar scripts no es realmente un administrador, sino un "operador". La diferencia radica en la escalabilidad: un script puede hacer en 5 segundos lo que a ti te tomaría 5 horas de clics repetitivos.

## 0.1 ¿Por qué es imprescindible?

* **Automatizar tareas rutinarias**: Crear usuarios, hacer copias de seguridad, limpiar logs o actualizar parches.
* **Consistencia**: Un script no se cansa ni se equivoca al escribir una configuración a las 3:00 AM; un humano sí.
* **Monitorización proactiva**: Se pueden programar scripts para revisar el estado de los servicios y enviar una alerta (o intentar reiniciarlos) antes de que alguien se queje.
* **Infraestructura como Código (IaC)**: En entornos de nube (AWS, Azure, Google Cloud), la infraestructura se despliega mediante scripts y código, no mediante interfaces visuales.

> **Consejo**: La regla de oro en administración de sistemas es: _"Si tienes que hacer algo más de dos veces, automatízalo"_. Al principio tardarás más escribiendo el script que haciendo la tarea a mano, pero a largo plazo, ese script te regalará horas de sueño y tranquilidad.

# 0.2 ¿Por dónde empezar?

No necesitas ser un desarrollador de software senior, pero sí entender la lógica de programación básica:

* **Variables**: Para guardar nombres de servidores o rutas de archivos.
* **Bucles (Loops)**: Para aplicar una acción a 100 servidores a la vez.
* **Condicionales (If/Else)**: "Si el disco está lleno al 90%, borra temporales; si no, no hagas nada".
* **Manejo de errores**: Qué debe hacer el script si un servidor no responde.


# 0.3 Los lenguajes que dominan el mercado

Dependiendo de tu entorno, deberías enfocarte en uno de estos dos (o ambos):

| Lenguaje     | Entorno Principal | Uso Ideal |
| ------------ | ----------------- | --------- |
| Bash / Shell | Linux / Unix      | Automatización a nivel de sistema operativo, manejo de archivos y procesos internos |
| PowerShell   | Windows / Azure   | Gestión de Active Directory, servidores Windows y servicios en la nube de Microsoft |
| Python       | Multiplataforma   | Ideal para APIs y análisis de datos |
| Ruby         | Multiplataforma   | La "navaja suiza". Ideal para automatizaciones complejas y herramientas de DevOps |

**¿Por qué Ruby y no otro lenguaje de scripting más clásico?**

* Matz diseñó Ruby pensando en crear un lenguaje de scripting, de hecho se inspiró en Perl (SmalLtalk y LISP) y el lenguaje proporciona de forma nativa muchos elementos similares a Bash.
* Ruby es muy fácil de escribir y muy fácil de leer. Se lee y escribe de forma "natural" (como esccribir en Inglés).
* Normalmente, cuando me ha tocado impartir clases de scripting dentro de loc cursos de administración de sistemas, tenemos "muy poco tiempo" (por lo menos, menos del que me gustaría) para impartir este contenido y tuvimos que buscar la forma de dar mucho en poco tiempo. En esto Ruby es ideal. 
* Como Ruby hereda tanto de Perl (lenguaje clásico de administración de sistemas) y absorve tantos elementos de Bash, si ya los conoces entonces el proceso de aprendizaje te será muy fácil, rápido y divertido.
