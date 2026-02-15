
# Transpilador Ruby to BASIC

Utilizaremos la gema `parser`para parsear el código Ruby y obtener su AST (Abstract Syntax Tree). A cotinuación recorremos el AST de forma recursiva.

* `gem install parser` para instalar la gema.

2. El Transpilador basado en AST

¿Por qué el AST es mejor?

    Jerarquía Real: El AST entiende que un puts dentro de un if pertenece a ese if. Las Regex solo ven líneas sueltas.

    Ambigüedad cero: No importa si pones espacios extra o paréntesis; el parser identifica que el nodo es de tipo :send (enviar mensaje/llamar método).

    Recursividad Natural: Al procesar el árbol, si un nodo tiene "hijos", simplemente volvemos a llamar a procesar_nodo.

Diferencia visual del AST

Si pudieras ver el AST de x = 10, se vería algo así como un objeto estructurado:

(lvasgn :x
  (int 10))

Esto es mucho más fácil de traducir a LET X = 10 que intentar adivinar con patrones de texto.
Siguiente paso sugerido

El uso de AST nos permite manejar cosas complejas como la precedencia de operadores (que 2 + 3 * 4 se calcule correctamente en BASIC).

¿Te gustaría que hagamos que este transpilador basado en AST pueda manejar expresiones matemáticas anidadas? Sería como crear un mini-compilador real.