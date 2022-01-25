# ASGMT files
# asigna valores iniciales
filename = 'points.txt'

# code
f = open(filename)
distances = []
for line in f:
    items = line.split()
    x = int(items[0])
    y = int(items[1])
    distance = (x**2 + y**2) ** 0.5
    distances.append(distance)

f.close()

# min_distance = 4.123105625617661
min_distance = min(distances)

print(min_distance)

