# ASGMT lists
# asigna valores iniciales
marks = '3,4,3,2,7,8,9,1,1,5'

# code
passed = 0
failed = 0

for i in marks.split(','):
    if int(i) >= 5:
        passed += 1
    else:
        failed += 1

print(passed)
print(failed)
