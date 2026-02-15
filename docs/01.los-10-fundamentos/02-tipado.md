[<< back](./README.md)

# 2. Tipado fuerte y dinámico

> IMHO: El "tipado" es una de los motivos de mayor discordia y/o separación entre programadores... pero sigamos.

Ruby es un lenguaje con **tipado fuerte y dinámico**. Si, dinámico y fuerte. A veces se entiende mal el concepto de tipado fuerte. Un ejemplo de lenguaje con tipado débil es el lenguaje B, predecesor de C. En B todos los datos eran bytes y el lenguaje no "entendía" el contenido. Era el programador el que debía acordarse de cuando una variable guardaba números o códigos ASCII, etc.

Ejemplo:

```ruby
# Tipo dinámico: el tipo de la variable sólo se sabe en tiempo de ejecución
texto = "4"
texto.class   #=> String

numero = 2
numero.class   #=> Integer

# Tipado fuerte
texto + numero #=> Error: `+': no implicit conversion of Integer into String (TypeError)

# Casting: conversión de tipo explícita
texto + numero.to_s   #=> "42"
texto.to_i + numero   #=> 6
"Quiero #{numero} manzanas" #=> "Quiero 2 manzanas"
```

**Definiciones de tipos**

| Tipado   | Ejemplo                             | Descripción | Lenguajes |
| -------- | ----------------------------------- | ----------- | --------- |
| Débil    | JavaScript: 4 + "2" resulta en "42" | En una operación con dos tipos distintos, el lenguaje intenta "adivinar" la intención del usuario y realiza una conversión implícita (coerción) | JavaScript, PHP, C (en ciertos aspectos de memoria), B (El antecesor de C)|
| Fuerte   | Python: 4 + "2" lanzará un error (TypeError)| No permite operaciones entre tipos diferentes a menos que el programador, haga una conversión explícita (casting) | Python, Java, Ruby, Go, Rust |
| Estático | int i; (Variable de tipo entero)| El tipo de las variables se conoce en tiempo de compilación | Java, Rust, C |
| Dinámico | nombre = "Obi-wan" | El tipo de las variables sólo se sabe en el momento de la ejecución | Ruby, Python, JavaScript, PHP |

Puede ser que estés pensando que los lenguajes de tipado dinámico no son para tí. En tal caso, mejor que lo dejes aquí, pero si quieres darle una oportunidad te lo agradeceré. Por si sirve de ayuda, en Ruby acompañamos el código con test. Los tests nos ayudan a mantener cierta calidad en el código y adegurarnos que las clases/objetos/métodos hacen lo que tienen que hacer, lo cual es fundamental siempre. Con código pequeño, grande o mediano.
