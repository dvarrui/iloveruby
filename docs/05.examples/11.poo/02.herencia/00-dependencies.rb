
class ServicioNotificacion
  def initialize(tipo_canal)
    @canal = tipo_canal
  end

  def enviar(mensaje, destinatario)
    puts "[#{@canal.upcase}]: Enviando '#{mensaje}' a #{destinatario}."
  end
end

class ProcesadorPedidos
  attr_reader :nombre

  def initialize(nombre)
    @nombre = nombre
  end

  # Este método TIENE una dependencia de ServicioNotificacion:
  # Lo recibe como parámetro (Inyección de Dependencia).
  def procesar(pedido_id, servicio_notificacion)
    # 1. Verificar si el parámetro es del tipo esperado (buena práctica)
    unless servicio_notificacion.is_a?(ServicioNotificacion)
      raise TypeError, "Se requiere una instancia de ServicioNotificacion."
    end

    puts "\n==> Procesador #{self.nombre} recibiendo pedido ##{pedido_id}..."

    # Simulación de la lógica de procesamiento
    puts "Pedido ##{pedido_id} validado y listo para envío."

    # 2. Uso temporal de la dependencia (Aquí ocurre la dependencia)
    mensaje = "Tu pedido ##{pedido_id} ha sido procesado correctamente."
    destinatario = "Cliente_#{pedido_id}"

    servicio_notificacion.enviar(mensaje, destinatario)

    puts "<== Procesamiento de pedido ##{pedido_id} completado."
  end
end

# 1. Crear el Procesador (Clase Dependiente)
procesador_web = ProcesadorPedidos.new("Web-Shop")

# 2. Crear los Servicios de Notificación (Clase Dependida) de forma independiente
notificador_email = ServicioNotificacion.new("email")
notificador_sms = ServicioNotificacion.new("SMS")

# 3. Inyectar la Dependencia en el método
# El ProcesadorPedidos usa el notificador, pero no lo "posee".

puts "--- Procesamiento con Notificación por Email ---"
procesador_web.procesar(1001, notificador_email)

puts "\n--- Procesamiento con Notificación por SMS ---"
procesador_web.procesar(1002, notificador_sms)
