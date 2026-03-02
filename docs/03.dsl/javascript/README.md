Haz un dale con ruby para imitar jacasxrupt

Hacer un DSL en Ruby para imitar a JavaScript (o específicamente su sintaxis de objetos y funciones) es un ejercicio divertido porque nos obliga a romper la elegancia de Ruby para adoptar la "verbosidad" y el estilo de JS.

Para lograrlo, usaremos una combinación de method_missing, Procs (clausuras) y una gestión especial de constantes.
1. El Motor: JSContext

JavaScript se basa en objetos que son básicamente mapas de funciones. En Ruby, podemos usar una clase que atrape cualquier asignación y la convierta en un comportamiento.
Ruby

class JSContext
  def initialize
    @variables = {}
  end

  # imita 'var' o 'let'
  def var(name, value = nil)
    @variables[name] = value
  end

  # Permite llamar a funciones como si fueran métodos de JS
  def method_missing(name, *args, &block)
    if name.to_s.end_with?('=')
      # Asignación de variable: objeto.propiedad = valor
      var_name = name.to_s.chomp('=').to_sym
      @variables[var_name] = args[0]
    elsif @variables.key?(name)
      # Llamada a función: nombre()
      val = @variables[name]
      val.is_a?(Proc) ? val.call(*args) : val
    else
      super
    end
  end

  # Imitamos console.log
  def console
    @console ||= Object.new.tap do |obj|
      def obj.log(*args); puts args.join(" "); end
    end
  end

  # El puente para definir funciones estilo JS
  def function(&block)
    block
  end

  def run(&block)
    instance_eval(&block)
  end
end

2. El DSL en acción: Escribiendo "JavaScript" en Ruby

Ahora podemos usar este contexto para escribir código que visualmente parece JavaScript (usando flechas -> para simular funciones anónimas y la estructura de objetos).
Ruby

js = JSContext.new

js.run do
  # var saludo = function(nombre) { ... }
  var :saludo, function { |nombre|
    "Hola, " + nombre
  }

  # console.log(saludo("Mundo"))
  console.log saludo("Mundo")

  # Imitando objetos dinámicos
  var :usuario, { nombre: "Gemini", rol: "AI" }
  
  console.log "Usuario:", usuario[:nombre], "con rol:", usuario[:rol]
end

3. Comparativa de Elegancia: Ruby imitando a JS

Desde la Interacción Humano-Máquina (HCI), este experimento es un "downgrade" intencionado de la elegancia de Ruby para ganar familiaridad con JS:
Elemento	Ruby Puro	Ruby-JS DSL	JavaScript Real
Definición	def hola; end	var :hola, function { }	function hola() { }
Salida	puts "msj"	console.log "msj"	console.log("msj")
Sentimiento	Conciso, semántico.	Híbrido, algo ruidoso.	Prolijo, basado en llaves.
¿Por qué Ruby permite esto?

Ruby es un "lenguaje maleable". A diferencia de Python o Go, Ruby permite redefinir el significado de method_missing. En este DSL:

    Engañamos al programador: Le hacemos creer que console es un objeto global, cuando es un método que devuelve un objeto anónimo.

    Carga Cognitiva: Para un desarrollador de JS, este DSL reduce la carga de aprender Ruby, pero aumenta el "ruido" al tener que usar símbolos como :saludo.

4. El límite de la imitación

Hay algo que Ruby no puede imitar de JavaScript fácilmente: las llaves {} para bloques de código sin que parezcan Hashes (diccionarios). En JS, las llaves son estructurales; en Ruby, las llaves son para datos o para bloques de una sola línea. Esta es una barrera sintáctica insalvable que mantiene a Ruby como Ruby.

¿Te gustaría que intentáramos llevar este DSL al extremo y añadir un sistema de "prototipos" (herencia basada en objetos) como el que tenía JavaScript antes de las clases de ES6? Sería la demostración definitiva de la flexibilidad de Ruby.

Si

Para implementar un sistema de prototipos al estilo JavaScript (donde un objeto hereda directamente de otro objeto y no de una clase), necesitamos que cada "objeto" en nuestro DSL de Ruby tenga un enlace a su padre.

En Ruby, podemos hacer esto creando una clase JSObject que gestione su propia tabla de propiedades y su prototipo.
1. El motor de Prototipos en Ruby

Aquí es donde la metaprogramación se pone seria. Cada objeto tendrá un __proto__.
Ruby

class JSObject
  attr_accessor :proto

  def initialize(proto = nil, properties = {})
    @proto = proto
    @properties = properties
  end

  def method_missing(name, *args, &block)
    name_str = name.to_s

    # Asignación: objeto.propiedad = valor
    if name_str.end_with?('=')
      prop_name = name_str.chomp('=').to_sym
      return @properties[prop_name] = args[0]
    end

    # Búsqueda: Buscar en este objeto, si no, buscar en el prototipo (__proto__)
    prop_name = name.to_sym
    if @properties.key?(prop_name)
      val = @properties[prop_name]
      # Si es una función (Proc), la ejecutamos pasándole 'self' como 'this'
      val.is_a?(Proc) ? val.call(self, *args) : val
    elsif @proto
      @proto.send(name, *args, &block)
    else
      nil # undefined
    end
  end
end

2. El DSL Final: Herencia por Prototipos

Ahora, configuremos el entorno para que se sienta como el viejo y querido JS.
Ruby

class JSContext
  def Object
    @object_root ||= JSObject.new
  end

  def run(&block)
    instance_eval(&block)
  end
  
  def console
    @console ||= Object.new.tap { |o| def o.log(*msg); puts msg.join(" "); end }
  end
end

# --- EJECUCIÓN ---

js = JSContext.new
js.run do
  # 1. Creamos un "prototipo" animal
  animal = JSObject.new(Object)
  animal.comer = ->(this) { console.log "El animal está comiendo..." }

  # 2. Creamos un objeto 'perro' que hereda de 'animal'
  perro = JSObject.new(animal)
  perro.ladrar = ->(this) { console.log "¡Guau! Mi nombre es #{this.nombre}" }
  
  # 3. Instanciamos un perro específico
  mi_perro = JSObject.new(perro)
  mi_perro.nombre = "Firulais"

  # Probamos la cadena de prototipos
  mi_perro.ladrar # Propio del prototipo 'perro'
  mi_perro.comer  # Heredado del prototipo 'animal'
end

3. Análisis de Ingeniería y HCI
El "This" de JavaScript

En JavaScript, la palabra clave this es famosa por ser confusa. En nuestro DSL de Ruby, tuvimos que pasar this explícitamente como el primer argumento del bloque (->(this) { ... }). Esto es porque en Ruby, el self dentro de un bloque (Proc) no cambia automáticamente al objeto que lo llama.
¿Por qué esto es elegante?

Desde la Interacción Humano-Máquina, este sistema es elegante porque:

    Consistencia de modelo: Logramos que la herencia funcione sin usar la palabra clave class de Ruby. Todo es un objeto y enlaces entre ellos.

    Transparencia: El usuario del DSL puede ver la "cadena de mando" de los objetos de forma visual.

Comparativa: Ruby vs Go vs JS
Característica	Go (POO)	JS (Prototipos)	Ruby DSL (Prototipos)
Herencia	No existe (Composición)	Cadena de __proto__	Simulada con method_missing
Flexibilidad	Estricta y estática	Totalmente dinámica	Totalmente dinámica
Carga Cognitiva	Baja (pero limitada)	Alta (por el contexto de this)	Media (hay que pasar this)
Reflexión final sobre los DSL

