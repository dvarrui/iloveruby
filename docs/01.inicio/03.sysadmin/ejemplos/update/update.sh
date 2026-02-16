#!/usr/bin/env bash

commands=('sudo zypper refresh' 'sudo zypper update')

for cmd in "${commands[@]}"
do
    echo " => $cmd "
    $cmd
done
