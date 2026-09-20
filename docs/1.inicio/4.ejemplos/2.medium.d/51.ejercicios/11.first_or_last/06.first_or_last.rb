def is_lowercase_vowel?(letter)
  %w[a e i o u].include? letter
end

def create_indexes(text, first)
  max = text.size - 1
  indexes = (0..max).to_a
  if !first
    indexes = indexes.reverse
  end
  return indexes
end

def first_or_last(text, first)
  # Devolver el primer o el último caracter (vocal minúscula)
  indexes = create_indexes(text, first)

  for i in indexes
    letter = text[i]
    return letter if is_lowercase_vowel?(letter)
  end

  "?"
end
