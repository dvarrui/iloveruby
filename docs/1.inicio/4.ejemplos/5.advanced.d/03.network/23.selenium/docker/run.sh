#!/usr/bin/env bash

NAME=ruby_script
SCRIPT="docker/execute.sh $1"
TEMPLATE="ruby:3.1"

docker run -it --rm --name $NAME -v "$PWD":/opt -w /opt $TEMPLATE $SCRIPT

