def is_lowercase_vowel?(letter) = %w[a e i o u].include? letter

def letters(text, first)
  return text.chars if first
  text.chars.reverse
end

def first_or_last(text, first)
  # Devolver el primer o el último caracter (vocal minúscula)
  letters(text,first).each { return _1 if is_lowercase_vowel? _1 }
  
  "?"
end
