#!/usr/bin/env ruby

require_relative "lib/04-aldi-lib"

URL = "https://www.aldi.es/supermercados/encuentra-tu-supermercado.html"
codes = [ "38670", "38550", "38260", "38611", "35014", "35214", "38639" ]

codes.each do |code|
  aldi = Aldi.new(URL)
  aldi.click_button("SALTAR", debug: false)
  aldi.filter(code)
  if aldi.exist_button? "Continuar"
    puts "    [SKIP] Continuar button"
    # aldi.click_button("Continuar")
  else
    aldi.click_link("Mapa", debug: false)
    aldi.click_button("Calcule la ruta:", debug: false)
  end
  puts "    Teléfono: #{aldi.get_telefono.colorize(:green)}"
  aldi.quit
end
