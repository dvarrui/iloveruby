#!/bin/bash
# Variables del script
MODULOS="hardware ingles lenguaje-de-marcas sistemas-operativos redes"
CURRENT_YEAR=$(date +%y)
NEXT_YEAR=$(date -d "year" +%y)
CURSO="curso$CURRENT_YEAR$NEXT_YEAR"

# Comienza el script
echo "[INFO] Ejecutando $(basename $0 .sh)..."
echo -n "Escribe el nombre del ALUMNO: "
read ALUMNO

# Borrar el directorio si existe
if [ -d $CURSO ]
then
  rm -r $CURSO
fi

mkdir $CURSO

for I in $MODULOS
do
  # Esto es lo que se repite
  mkdir $CURSO/$I
  echo $ALUMNO > $CURSO/$I/leeme.txt
done

