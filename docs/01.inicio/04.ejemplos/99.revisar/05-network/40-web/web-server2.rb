require 'socket'
require 'cgi'

host = '127.0.0.1'
port = 8082
server = TCPServer.new(host, port)
puts "[INFO] Listening on #{host}:#{port}"

loop {
  client = server.accept

  first_request_header = client.gets
  resp = first_request_header
  resp = "<h1>Hola Mundo</h1>"
  headers = ['http/1.1 200 ok',
             "date: #{CGI.rfc1123_date(Time.now)}",
             'server: ruby',
             'content-type: text/html; charset=iso-8859-1',
            "content-length: #{resp.length}\r\n\r\n"].join("\r\n")
  client.puts headers          # send the time to the client
  client.puts resp
  client.close
}
