
class Lisp
  def self.+(a, b); a + b; end
  def self.*(a, b); a * b; end
  def self.println(val); puts val; end

  # El evaluador: toma un array donde el primer elemento es el método
  def self.eval(list)
    return list unless list.is_a?(Array)

    method, *args = list
    # Evaluamos los argumentos recursivamente (por si son listas anidadas)
    evaluated_args = args.map { |arg| eval(arg) }

    # Llamamos al método en esta clase
    send(method.to_sym, *evaluated_args)
  end
end

# Definimos un método global "L" para crear la estructura de lista
def L(*args)
  args
end
