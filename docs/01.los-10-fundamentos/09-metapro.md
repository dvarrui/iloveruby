[<< back](./README.md)

# 9. La metaprogramación

```
El arma secreta
```

Cuando estudiaba en la Universidad (ULPGC) la carrera de Ingeniería Informática, en 4º teníamos una asignatura muy interesante llamada "Inteligencia Artificial" (no iba de los LLM tan populares hoy en día). Recuerdo cuando nos enseñaron LISP es esa asignatura (aunque ya lo conocía de haber leído algo en libros) y también recuerdo que se me quedó grabado en la mente que LISP tenía la propiedad de automodificarse en tiempo de ejecución. Es a lo que nos referimos como "metaprogramación". Que LISP veía a su propio código como datos y el programa podía cambiar de diferentes formas en cada ejecución. ¡Me flipo! (Si, es una expresión de persona mayor de los 80, pero es el término que encaja)

Resulta que Matz, para crear Ruby, se inspiró en LISP, Perl y SmallTalk, y cogió la idea de metaprogramación de LISP para Ruby (¡Me encantó!)

Pero... debo hacer una advertencia. La metaprogramación divide a los programadores/ingenieros. Para unos es una característica superpotente, y para otros es un supermal del que hay que huir como la peste.

Pues si no le temes a la "metaprogramación", ¡adelante!. En caso, contrario, Ruby no es para tí.

> **NOTA**: Como dijimos anteriormente, como vamos a acompañar a nuestros programas de los test adecuados, vamos a tener el superpoder de la metaprogramación "controlado" en todo momento para que no sea "dispararse en la pierna".

Para metaprogramar en Ruby tenemos:
* eval
* ...
* ...
* method_missing

Veamos ejemplos:
