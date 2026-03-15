#!/usr/bin/env ruby
require_relative 'lib/05-commands'

echo "[EXAMPLE] #{$0}"
PWD=`pwd`
echo "Estoy en el directorio #{PWD}"
mkdir 'temp'
echo "Soy el usuario #{`whoami`}"
ls

exit 0
