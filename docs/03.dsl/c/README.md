Dsl ruby para imitar c

Imitar C en Ruby es el desafío definitivo de metaprogramación porque son polos opuestos: C es estático, de bajo nivel y gestiona memoria manualmente; Ruby es dinámico, de alto nivel y abstrae todo lo anterior.

Para lograrlo, tenemos que imitar la sintaxis de tipos, el uso de punteros y la estructura de funciones con main().
1. El motor: CLangDSL

Usaremos method_missing para capturar los "tipos" (int, char, void) y un objeto especial para simular punteros.
Ruby

class Pointer
  attr_accessor :value
  def initialize(value); @value = value; end
  def deref; @value; end
  def set(v); @value = v; end
end

class CContext
  def initialize
    @stdout = ""
  end

  # Simulamos tipos como métodos que definen variables
  def int(name, value = 0)
    instance_variable_set("@#{name}", value)
  end

  def char_ptr(name, value = "")
    instance_variable_set("@#{name}", Pointer.new(value))
  end

  # El famoso printf
  def printf(format, *args)
    output = format.gsub("%d", "%s").gsub("%s", "%s") % args
    print output
  end

  # Estructura de punteros: &variable
  def addr(name)
    Pointer.new(instance_variable_get("@#{name}"))
  end

  def run(&block)
    instance_eval(&block)
    main if respond_to?(:main)
  end
end

2. El DSL en acción: Escribiendo "C" en Ruby

Aquí es donde la sintaxis se vuelve extraña. Intentaremos que se vea lo más parecido posible a un archivo .c.
Ruby

c_compiler = CContext.new

c_compiler.run do
  # Simulación de prototipos y funciones
  def main
    int :edad, 25
    char_ptr :nombre, "Gemini"
    
    printf "Hola %s, tu edad es %d\n", @nombre.deref, @edad
    
    # Simulando manipulación de punteros
    puntero_edad = addr(:edad)
    puntero_edad.set(26)
    
    printf "Nueva edad tras puntero: %d\n", @edad
    
    return 0
  end
end

3. Comparativa de Elegancia e Interacción (HCI)

Este DSL es un experimento de "Fricción Intencionada". Ruby suele ser fluido, pero aquí lo obligamos a ser rígido.
Característica	C Real	Ruby-C DSL	¿Por qué cambia?
Declaración	int x = 10;	int :x, 10	Ruby necesita símbolos (:x) para identificar nombres.
Punteros	int *p = &x;	p = addr(:x)	Ruby no tiene acceso real a la memoria (RAM).
Punto de entrada	main() obligatorio	def main	En Ruby el código es script, en C es funcional.
La elegancia de la "falsa seguridad"

Lo interesante de este DSL desde la Interacción Humano-Máquina es que, aunque parece C, sigue teniendo la red de seguridad de Ruby. Si intentas acceder a un "puntero nulo", Ruby te dará un error de objeto, no un Segmentation Fault que tire abajo todo el sistema operativo.
4. El límite: Los Semicolons ; y los Tipos Reales

Hay dos cosas que Ruby no puede imitar de C sin volverse ilegible:

    El punto y coma (;): En Ruby son opcionales y se consideran "ruido". Obligar a usarlos no aporta nada al intérprete.

    El tipado estático: En nuestro DSL, int es solo un método. Podrías pasarle un String y Ruby no se quejaría hasta la ejecución. C, en cambio, lo detectaría en la compilación.

Haskell, que mencionamos antes, es mucho más parecido a C en cuanto a rigor de tipos, pero con una elegancia matemática superior.

¿Te gustaría ver cómo Haskell logra la misma seguridad de C pero sin punteros, usando algo llamado "Inmutabilidad"? Es un salto cuántico en la teoría de lenguajes.


