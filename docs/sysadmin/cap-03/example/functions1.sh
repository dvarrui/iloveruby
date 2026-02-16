#!/bin/bash

function ensure_you_are_superuser {
  if [ $(whoami) != 'root' ]
  then
    echo "Sorry, you must be root!"
    exit 1
  fi
}

function do_tasks {
  echo "Hello! I'm root!"
  echo "I'm working too hard"
}

ensure_you_are_superuser
do_tasks
