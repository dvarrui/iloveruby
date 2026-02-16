# Este fichero debe funcionar

function execute_python {
  echo "[ INFO ] Ejecutando python"
  python3 test/src/fk_UnitTest.py
  if [ $? -ne 0 ]; then
    echo "[ FAIL ] Python no funciona!"
    return 99
  fi
  return 0
}

function execute_docker_compose {
  echo "[ INFO ] RUN: docker-compose down"
  return $?
}

execute_python
execute_docker_compose

exit 0
