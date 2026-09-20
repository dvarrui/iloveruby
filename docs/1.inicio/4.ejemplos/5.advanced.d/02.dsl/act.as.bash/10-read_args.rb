#!/usr/bin/env ruby
require_relative 'lib/10-read'

echo "[Example] #{$0}"

USERNAME = `whoami`
echo "Username: " + USERNAME
rmdir 'temp'
echo "$S1=", $S1
echo "$S2=", $S2

