# File: 02-fractalpy.py

from modern.logo import logo

def mi_dibujo(l):
    def dibujar_arbol(longitud):
        if longitud < 10:
            return
        
        l.fd(longitud)
        l.rt(20)
        dibujar_arbol(longitud - 15)
        l.lt(40)
        dibujar_arbol(longitud - 15)
        l.rt(20)
        l.pu()
        l.bk(longitud)
        l.pd()

    # Configuración inicial
    l.pu()
    l.lt(90)
    l.bk(100)
    l.pd()
    
    # El bucle REPEAT de Logo usando nuestra función
    l.repeat(12, lambda: (
        dibujar_arbol(60),
        l.rt(30)
    ))

# Ejecución
if __name__ == "__main__":
    logo(mi_dibujo)
