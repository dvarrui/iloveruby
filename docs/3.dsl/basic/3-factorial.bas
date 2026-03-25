
LET number, 3
LET factorial, 1
LET i, number
  
REPEAT number do
  let factorial, factorial  * i
  let i, i - 1
end
  
PRINT "FACTORIAL DE", number, "ES", factorial
