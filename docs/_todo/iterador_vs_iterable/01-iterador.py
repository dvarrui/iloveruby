# https://www.w3schools.com/python/python_iterators.asp

mytuple = ("apple", "banana", "cherry")

print("[ INFO ] Example 01")

myit = iter(mytuple)

print(next(myit))
print(next(myit))
print(next(myit))

print("[ INFO ] Example 02")

for x in mytuple:
  print(x)

# Create an iterator that returns numbers, starting with 1, and each sequence will increase by one (returning 1,2,3,4,5 etc.):
print("[ INFO ] Example 03")

class MyNumbers:
    def __iter__(self):
        self.a = 1
        return self

    def __next__(self):
        x = self.a
        self.a += 1
        return x

myclass = MyNumbers()
myiter = iter(myclass)

print(next(myiter))
print(next(myiter))
print(next(myiter))
print(next(myiter))
print(next(myiter))
