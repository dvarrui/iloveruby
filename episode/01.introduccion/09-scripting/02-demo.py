#!/usr/bin/env python

import subprocess
time = subprocess.check_output("date")
print "La fecha actual es: ", time.replace("\n",""), " (OK)"
