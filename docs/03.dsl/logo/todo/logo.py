# File: logo.py

import turtle

class LogoDSL:
    def __init__(self):
        self.t = turtle.Turtle()
        self.t.speed(0)  # Máxima velocidad
        # Aliases para comandos cortos
        self.fd = self.t.forward
        self.bk = self.t.backward
        self.rt = self.t.right
        self.lt = self.t.left
        self.pu = self.t.penup
        self.pd = self.t.pendown
        self.color = self.t.color

    def repeat(self, n, func):
        for _ in range(n):
            func()

# El orquestador del DSL
def logo(bloque_instrucciones):
    ventana = turtle.Screen()
    ventana.bgcolor("black")
    dsl = LogoDSL()
    dsl.color("cyan")
    # Ejecutamos las instrucciones pasando el objeto DSL
    bloque_instrucciones(dsl)
    ventana.exitonclick()
