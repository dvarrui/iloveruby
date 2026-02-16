# Este fichero no funciona bien

set +e
bash -e <<TRY
  echo "Ejecutando python"
  python3 test/src/fk_UnitTest.py
  echo "se rompio tu python"
TRY
if [ $? -ne 0 ]; then
  echo caught exception
  docker-compose down
fi
