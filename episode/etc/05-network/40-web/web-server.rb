require 'socket'

port = 8081
host = "localhost"

server = TCPServer.new(host,port)

puts "[INFO] Servidor web arrancado (#{host}:#{port})."
while (conn = server.accept)
  puts conn.to_s
  conn.puts "Conexión establecida<br>"
  puts "=> Solicitud recibida : #{conn.gets}"
  conn.close
end
