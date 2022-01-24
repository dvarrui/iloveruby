
PROGRAM EJEMPLO_PASCAL;
        USES CRT;
        VAR num:REAL;

BEGIN
     ClrScr;
     WRITE('Introduzca un numero : ');
     READLN(num);

     IF (num > 0) AND (num < 100) THEN
       BEGIN
         WRITELN('Número entre 0 y 100');
       END;
     ELSE
       BEGIN
         WRITELN('Número fuera del intervalo');
       END;

END.
