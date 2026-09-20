
class Word 

  def initialize(word)
    @word = word
  end

  def self.to_chars(str)
    chars = []
    str.size.times { chars << str[_1] }
    chars
  end

  def contains?(letters)
    input_chars = letters
    input_chars = Word.to_chars(letters) unless letters.class == Array
    output = []
   
    chars = Word.to_chars(@word) 
    input_chars.size.times do |index|
      char = chars[index]
      input_char = input_chars[index]

      result = :error
      result = :fail if chars.include?(input_char)
      result = :ok if char == input_char
      
      output << result
    end
    output
  end
end
