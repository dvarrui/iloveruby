#!/bin/bash
# Descripción: crear usuarios, grupos y carpetas con determinados permisos

# Crear grupos: jedis, siths
groupadd jedis
groupadd siths

# Crear usuarios: jedi1, jedi2, sith1, sith2
useradd jedi1 -m -g jedis
useradd jedi2 -m -g jedis
useradd sith1 -m -g siths
useradd sith2 -m -g siths

# Crear carpetas: public, private, group

mkdir /home/jedi1/private
chmod 700 /home/jedi1/private
chown jedi1 /home/jedi1/private
chgrp jedis /home/jedi1/private

mkdir /home/jedi1/group
chmod 750 /home/jedi1/group
chown jedi1 /home/jedi1/group
chgrp jedis /home/jedi1/group

mkdir /home/jedi1/public
chmod 755 /home/jedi1/public
chown jedi1 /home/jedi1/public
chgrp jedis /home/jedi1/public

