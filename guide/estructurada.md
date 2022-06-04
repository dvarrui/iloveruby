[<< back](README.md)

# Programación estructurada

La programación estructurada es un paradigma de programación que recurre únicamente a subrutinas y tres estructuras básicas: secuencia, selección (if y switch) e iteración (bucles for y while).

## Estructura de secuencial

```ruby
print "What's your name? "
name = gets.chomp

puts "Hello #{name}!"
```

## Estructura condicional

```ruby
print "Select lang (en, es): "
lang = gets.chomp

if lang == 'en'
  puts "Hello!"
elsif lang == 'es'
  puts "¡Hola!"
else
  puts "Sorry, I don't speak #{lang}"
end
```

## Estructura iterativa

```ruby
print "How much do you love me? (Integer) "
value = gets.to_i

i = 0
while (i<value)
  print "(#{i}) Kiss "
  i += 1
end
```

```ruby
print "How much do you love me? (Integer) "
value = gets.to_i

value.times do |i|
  print "(#{i}) Kiss "
end
```
