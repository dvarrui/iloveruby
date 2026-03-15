class Libro
  attr_reader :titulo, :autor, :isbn

  def initialize(titulo, autor, isbn)
    @titulo = titulo
    @autor = autor
    @isbn = isbn
  end

  def to_s
    "\"#{@titulo}\" por #{@autor} (ISBN: #{@isbn})"
  end
end

class Biblioteca
  attr_reader :nombre

  # La clase Biblioteca está compuesta/agrega una colección (Array) de Libros.
  def initialize(nombre)
    @nombre = nombre
    # El estado interno del contenedor es la colección de objetos.
    @libros = []
    puts "Biblioteca '#{nombre}' creada."
  end

  # --- Métodos de Gestión (Interfaz de Alto Nivel) ---

  # 1. Añadir: Agrega un libro a la colección.
  def agregar_libro(libro)
    raise TypeError, "Se espera un objeto Libro" unless libro.is_a?(Libro)
    @libros << libro
    puts "-> Agregado: #{libro.titulo}"
  end

  # 2. Buscar: Filtra la colección (utilizando Enumerable#select).
  def buscar_por_autor(autor)
    # Delega la búsqueda al array interno.
    @libros.select { |libro| libro.autor.downcase.include?(autor.downcase) }
  end

  # 3. Eliminar: Remueve un libro de la colección.
  def eliminar_por_isbn(isbn)
    libro_eliminado = @libros.delete_if { |libro| libro.isbn == isbn }.first
    if libro_eliminado
      puts "<- Eliminado: #{libro_eliminado.titulo}"
    else
      puts "Libro con ISBN #{isbn} no encontrado."
    end
  end

  # 4. Mostrar Contenido: Itera sobre la colección.
  def total_libros
    @libros.count
  end

  def listar_todos
    puts "\n--- Contenido de la #{@nombre} (Total: #{total_libros}) ---"
    if @libros.empty?
      puts "La biblioteca está vacía."
    else
      @libros.each_with_index { |libro, i| puts "#{i + 1}. #{libro.to_s}" }
    end
  end
end
