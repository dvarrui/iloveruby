[<< back](./README.md)

# 5. Quitando "ruido" visual

Ruby además tiene algunas "particularidades" que permiten que el lenguaje se "acerque" al lenguaje natural (el inglés). Las siguientes, por ejemplo:

1. **Los paréntesis se pueden omitir** si la expresión se entiende bien sin ellos. Por defecto, no los pondremos.
2. Casi **todas las sentencias son expresiones** y por tanto siempre (o casi siempre) se devuelve algún valor.
3. **Se sobreentiende un `return` al final de un método**. Se puede omitir la instrucción `return` al final de los métodos, porque se asume que el valor de la última expresión evaluada será el valor devuelto por el método.

Ejemplos:

```ruby
nombre = "Obi-wan"
# (Ejemplo 1) Los paréntesis sobran la mayoría de las veces
nombre.upcase #=> "OBI-WAN" 
puts nombre   #=> Muestra "Obi-wan" por el terminal

# (Ejemplo 2) Casi todo es una expresión
persona = if age >= 18
  "Adulta"
else
  "Menor"
end

# (Ejemplo 3) La sentencia return sobra al final del método
def suma(a, b)
  a + b
end
```

**Reflexión**

A menudo se critica a Ruby por ser un lenguaje demasiado flexible, poco ortogonal, que tiene varias formas de hacer lo mismo. Qué tiene magia...

Matz va evolucionando el diseño de Ruby para mantenerlo coherente, OOP, y en la medida de lo posible va incorporando azúcar sintáctico o cambios para ampliar sus capacidades para poder programar Ruby casi como si estuviéramos escribiendo en inglés.

Veremos más ejemplo, un poco más adelante.

---
[next >>](./06-clases.md)
