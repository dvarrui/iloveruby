#!/usr/bin/env bash

echo "[ INFO ] Probando un try-catch en Bash"

function command_ok {
  ping -c 1 1.1.1.1
  return $?
} 

function command_fail {
  ping -c 1 192.168.42.16
  return $?
} 

command_ok && echo "[  OK  ] Lo que se esperaba: El comando OK ha funcionado!"
command_fail || echo "[ FAIL ] Lo que se esperaba: El comando FAIL ha fallado!"

