#!/usr/bin/env ruby
# asigna valores iniciales
words = 'aro|clara|patata|brillo'
letter = 'a'

# code here

letter_counter = {}
word_list = words.split('|')

word_list.each do |word|
    counter = word.count(letter)
    letter_counter[word] = counter
end 

puts letter_counter
