def first_or_last(text, first)
  # Devolver el primer o el último caracter (vocal minúscula)
  max = text.size - 1
  if first
    for i in (0..max)
      if ["a", "e", "i", "o", "u"].include? text[i]
        return text[i]
      end
    end
  else
    for i in (0..max).to_a.reverse
      if ["a", "e", "i", "o", "u"].include? text[i]
        return text[i]
      end
    end
  end

  "?"
end
