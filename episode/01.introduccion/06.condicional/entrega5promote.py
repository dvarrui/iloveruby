# ASGMT conditionals
# asigna valores iniciales
num_fails = 2
spanish_grade = 7
maths_grade = 3
# Your code

if num_fails < 2:
    promote = True
elif num_fails > 2:
    promote = False
else:
    promote = False
    if spanish_grade >= 5 and maths_grade >= 5:
        promote = True

print(promote)
