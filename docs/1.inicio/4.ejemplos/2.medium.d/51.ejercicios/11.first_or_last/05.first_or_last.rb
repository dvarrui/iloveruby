def is_lowercase_vowel?(c)
  ["a", "e", "i", "o", "u"].include? c
end

def first_or_last(text, first)
  # Devolver el primer o el último caracter (vocal minúscula)
  max = text.size - 1
  indexes = (0..max).to_a
  if !first
    indexes = indexes.reverse
  end

  for i in indexes
    letter = text[i]
    return letter if is_lowercase_vowel?(letter)
  end

  "?"
end
