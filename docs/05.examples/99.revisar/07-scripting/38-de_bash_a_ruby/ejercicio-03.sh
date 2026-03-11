#!/bin/bash

echo "[INFO] Ejecutando el ejercicio 03..."

mkdir curso1920

for i in hardware ingles lenguaje-de-marcas sistemas-operativos; do
  # Esto es lo que se repite
  mkdir curso1920/$i
  echo "david" > curso1920/$i/leeme.txt
done
