#!/usr/bin/env ruby

require "nokogiri"

html = <<EOF
<html>
  <header>Esto es el header</header>
  <body>
    <h1>Este es el body</h1>
    <div id="obiwan">Obiwan Kenobi</div>
    <div class="droides">
      <p>R2D2</p>
      <p>C3PO</p>
    </div>
    <p>Ejemplo de Nokogiri</p>
  </body>
</html>
EOF

doc = Nokogiri::HTML.parse(html)

puts "\n==> Localizar div p "
puts doc.css("div p")

puts "\n==> Localizar div id:obiwan"
items = doc.css("div")
puts items.select { |i| i["id"] == "obiwan" }

puts "\n==> Localizar div class:droides"
items = doc.css("div")
puts items.select { |i| i["class"] == "droides" }

