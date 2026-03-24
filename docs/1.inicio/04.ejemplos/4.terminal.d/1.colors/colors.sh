#!/usr/bin/env bash
#
# URL: https://twitter.com/climagic/status/1582032494681260033?t=yvzT1uukdq2OT1MI0A5ZLQ&s=35
# Command Line Magic (@climagic)
# Show your basic terminal text colors for the purpose of changing them in your preferences.
# printf "\e[%dm%d dark\e[0m \e[%d;1m%d bold\e[0m\n" {30..37}{,,,}

printf "\e[%dm%d dark\e[0m \e[%d;1m%d bold\e[0m\n" {30..37}{,,,}
