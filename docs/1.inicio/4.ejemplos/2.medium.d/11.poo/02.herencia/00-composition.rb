# --- Clase Componente ---
class Motor
  attr_reader :tipo, :estado

  def initialize(tipo)
    @tipo = tipo
    @estado = "apagado"
  end

  def arrancar
    @estado = "encendido"
    puts "Motor de tipo #{@tipo} arrancado y listo para la marcha."
  end

  def apagar
    @estado = "apagado"
    puts "Motor apagado."
  end
end

# --- Clase Compuesta (Utiliza la Composición) ---
class Coche
  attr_reader :modelo, :motor # Un Coche TIENE UN Motor

  # En el constructor, inicializamos la instancia de la clase Motor
  def initialize(modelo, tipo_motor)
    @modelo = modelo
    # Esto es la Composición: crear una instancia de otra clase.
    @motor = Motor.new(tipo_motor) 
  end

  # El Coche DELEGA la acción de arrancar a su objeto Motor
  def encender
    puts "Intentando arrancar el #{@modelo}..."
    @motor.arrancar # Llama al método del objeto Motor
  end
  
  def conducir
    if @motor.estado == "encendido"
      puts "El #{@modelo} está conduciendo."
    else
      puts "El #{@modelo} no puede conducir, el motor está apagado."
    end
  end
end

# --- Uso del programa ---

# 1. Creamos una instancia de Coche
mi_coche = Coche.new("Tesla Modelo S", "Eléctrico")

puts "--- Inspección Inicial ---"
puts "Modelo: #{mi_coche.modelo}"
puts "Tipo de motor: #{mi_coche.motor.tipo}" 
puts "Estado del motor: #{mi_coche.motor.estado}" 
puts "\n"

# 2. Intentamos conducir (fallará porque el motor está apagado)
mi_coche.conducir 
puts "\n"

# 3. Encendemos el coche (delegando la acción al objeto Motor)
mi_coche.encender
puts "\n"

# 4. Conducimos de nuevo (ahora funcionará)
mi_coche.conducir

