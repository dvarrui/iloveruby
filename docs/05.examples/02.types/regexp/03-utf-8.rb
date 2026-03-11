#!/usr/bin/ruby


def apply_filter_to(filter, input)
  result = filter.match(input)

  if result
    puts result.captures
  else
    puts "Sin resultado"
  end
end

input = "Cabecera...\"title\"=\"vistas\"...bonitas."
filter = /\"title\"=\"(\w+)\"/
apply_filter_to(filter, input)

input = "Cabecera...\"title\"=\"vistas.\"bonitas."
filter = /\"title\"=\"(\w+[.]+)\"/
apply_filter_to(filter, input)

input = "Cabecera...\"title\"=\"Habitación.\"bonitas."
filter = /\"title\"=\"([A-Za-z.áéíóú]+)\"/
apply_filter_to(filter, input)

input = "Cabecera...\"title\"=\"Habitación con vistas.\"bonitas."
filter = /\"title\"=\"([A-Za-z.áéíóú ]+)\"/
apply_filter_to(filter, input)

input = "Cabecera...id=\"title_164206\"...cola"
filter = /id=\"title_(\d+)\"/
apply_filter_to(filter, input)
