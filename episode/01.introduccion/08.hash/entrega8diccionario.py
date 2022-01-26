# ASGMT dicts
# asigna valores iniciales
words = 'aro|clara|patata|brillo'
letter = 'a'

# code here

letter_counter = {}
word_list = words.split('|')

for word in word_list:
    counter = word.count(letter)
    letter_counter[word] = counter

print(letter_counter)
