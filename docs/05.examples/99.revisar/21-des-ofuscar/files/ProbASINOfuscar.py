#!/usr/bin/python3
import os,sys,subprocess,hashlib,base64

#-----VARIABLE-----#
numEjer="A"
host="www.aprendeaprogramar.org"
titulo="Problema A => Comprobamos que el usuario alumno exista en el sistema"
nTestActual=1
fuenteBase64="I2luY2x1ZGUgPGlvc3RyZWFtPgp1c2luZyBuYW1lc3BhY2Ugc3RkOwoKaW50IG1haW4oKXsKCWNvdXQgPDwiOGRlMjBlYWYxZjExN2EwMGI1NGExNTY3ZTM2MTIxN2QzM2NkNDBjZjI4ZjRmNDQxODIwY2MyN2RjZDMzY2I1MCI8PGVuZGw7CglyZXR1cm4gMDsKfQkK"

#------------------------------------AUXILIARES--------------------------------


#Caso de test fallido
def testFail(error):
	global nTestActual

	print("--------TEST "+str(nTestActual)+"----------------------")
	print("[ERROR]")
	print(error)
	print("------------------------------------")
	sys.exit(-1)


#Caso de test correcto
def testPartialSuccess(texto):

	global nTestActual


	print("--------TEST "+str(nTestActual)+"----------------------")
	print("[OK]")
	print(texto)
	print("------------------------------------")
	print("")
	nTestActual=nTestActual+1


#Caso de test correcto
def testSuccess():

	global nTestActual
	#cadena="OK"+host+numEjer+"OK"+str(nTestActual);
	#m = hashlib.sha256()
	#m.update(cadena.encode('utf-8'))

	print("------------------------------------")
	print("-------------TODOS LOS TEST PASADOS--------------------")
	print("[OK]")
	print("Problema "+numEjer+" correcto. Sube el fichero ProbARes.cpp que se ha generado")
	
	#print(str(m.hexdigest()))
	f = open('ProbARes.cpp', 'w')
	f.write(base64.b64decode(fuenteBase64).decode())
	f.close()

	sys.exit(0)

#------------------------------------FIN AUXILIARES-----------------------------


#-----------------------------------DEFINIMOS TEST-----------------------------


#Imprimimos titulo
print(titulo+"\n")
#Comprobamos si es root lo primero
if os.geteuid()!=0:
	testFail("Debes ejecutar el fichero como ROOT o usando sudo")

testPartialSuccess("Ejecutado el script con privilegios de ROOT")


#Ejecutando prueba 1: Comprobando si el usuario alumno existe
usuarioATestear="alumno"
comando="id "+usuarioATestear+" | wc -l"

ps = subprocess.Popen(comando,shell=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
output = ps.communicate()[0]
#Comprobamos si falla
try:
	if int(output)<1:
		testFail("No se encuentra el usuario "+usuarioATestear)
except ValueError:
	testFail("No se encuentra el usuario "+usuarioATestear)

testPartialSuccess("Usuario "+usuarioATestear+" existente en el sistema")


#Final de todos los casos sin fallar

testSuccess()





