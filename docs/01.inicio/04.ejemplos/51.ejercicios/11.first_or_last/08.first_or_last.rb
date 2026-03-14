def is_lowercase_vowel?(letter)
  %w[a e i o u].include? letter
end

def get_letters(text, first)
  return text.chars if first
  text.chars.reverse
end

def first_or_last(text, first)
  # Devolver el primer o el último caracter (vocal minúscula)
  letters = get_letters(text, first)

  letters.each do |letter|
    return letter if is_lowercase_vowel?(letter)
  end

  "?"
end
