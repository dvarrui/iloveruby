#!/bin/bash

function crear_carpetas() {
  echo "Ejecutando la función con $1"
  for i in $1
  do
    echo "Voy a crear la carpeta $i"
    mkdir $i
  done
  echo "-----"
}

crear_carpetas "a b c"
crear_carpetas "d e f g"
