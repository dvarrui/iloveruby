
class Empleado
  attr_reader :nombre, :id
  
  def initialize(nombre, id)
    @nombre = nombre
    @id = id
  end
    
  def to_s
    return "Empleado ID #{@id}: #{@nombre}"
  end
end


class Departamento
  attr_reader :nombre, :empleados # Un Departamento AGREGA (tiene) una lista de Empleados
  
  # Inicializa el departamento con su nombre y una lista vacía de empleados
  def initialize(nombre)
    @nombre = nombre
    @empleados = []
    puts "Departamento '#{nombre}' creado."
  end
  
  # Agrega un objeto Empleado existente a la lista
  def agregar_empleado(empleado)
    @empleados << empleado # Añade el objeto existente
    puts "#{empleado.nombre} ha sido agregado al departamento de #{@nombre}."
  end
    
  def listar_empleados
    puts "\n--- Empleados en #{@nombre} ---"
    if @empleados.empty?
      puts "No hay empleados en este departamento."
    else
      @empleados.each { |e| puts "- #{e.to_s}" }
    end
  end
end


e1 = Empleado.new("Yoda", 1)
e2 = Empleado.new("Vader", 2)
d1 = Departamento.new("StarWars")

d1.listar_empleados
d1.agregar_empleado(e1)
d1.listar_empleados
d1.agregar_empleado(e2)
d1.listar_empleados