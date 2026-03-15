class Curso
  attr_reader :nombre, :codigo
  attr_accessor :profesor # Asocia el Curso a un Profesor

  def initialize(nombre, codigo)
    @nombre = nombre
    @codigo = codigo
    @profesor = nil # Inicialmente, no hay profesor asociado
  end

  def asignar_profesor(profesor)
    @profesor = profesor
    # Opcional: Establecer la asociación inversa (bidireccional)
    profesor.agregar_curso(self) 
    puts "El curso '#{@nombre}' ha sido asignado a #{profesor.nombre}."
  end

  def mostrar_info
    nombre_profesor = @profesor ? @profesor.nombre : "No asignado"
    puts "Curso: #{@nombre} (#{@codigo})"
    puts "Profesor Asignado: #{nombre_profesor}"
  end
end

class Profesor
  attr_reader :nombre, :especialidad
  attr_reader :cursos # Asocia el Profesor a múltiples Cursos

  def initialize(nombre, especialidad)
    @nombre = nombre
    @especialidad = especialidad
    @cursos = [] # Lista de cursos asociados
  end

  # Agrega un curso a la lista del profesor (parte de la asociación bidireccional)
  def agregar_curso(curso)
    @cursos << curso unless @cursos.include?(curso)
  end

  def listar_cursos
    puts "\n--- Cursos de #{@nombre} (#{especialidad}) ---"
    if @cursos.empty?
      puts "#{@nombre} no tiene cursos asignados."
    else
      @cursos.each { |c| puts "- #{c.nombre} (#{c.codigo})" }
    end
  end
end

