def first_or_last(text, first)
  # Devolver el primer o el último caracter (vocal minúscula)
  max = text.size - 1
  if first
    indexes = (0..max)
  else
    indexes = (0..max).to_a.reverse
  end

  for i in indexes
    if ["a", "e", "i", "o", "u"].include? text[i]
      return text[i]
    end
  end

  "?"
end
