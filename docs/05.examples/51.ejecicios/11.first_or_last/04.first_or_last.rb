def is_lowercase_vowel?(c)
  return true if ["a", "e", "i", "o", "u"].include? c
  false
end

def first_or_last(text, first)
  # Devolver el primer o el último caracter (vocal minúscula)
  max = text.size - 1
  if first
    indexes = (0..max)
  else
    indexes = (0..max).to_a.reverse
  end

  for i in indexes
    letter = text[i]
    return letter if is_lowercase_vowel?(letter)
  end

  "?"
end
