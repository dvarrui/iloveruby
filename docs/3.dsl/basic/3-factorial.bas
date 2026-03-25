
LET number, 3
LET factorial, 1
LET i, number
  
REPEAT number do
  LET factorial, factorial  * i
  LET i, i - 1
end
  
PRINT "El factorial de", number, "es", factorial
