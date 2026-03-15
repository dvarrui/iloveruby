#!/usr/bin/env ruby

require "nokogiri"

html = <<EOF
<html>
  <div class="jedi">Obiwan</div>
  <div >R2D2</div>
</html>
EOF

doc = Nokogiri::HTML.parse(html)
puts doc.css("div")

