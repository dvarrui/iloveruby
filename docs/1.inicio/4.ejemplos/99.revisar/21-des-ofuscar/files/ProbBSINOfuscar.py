#!/usr/bin/python3
import os,sys,subprocess,hashlib,base64

#-----VARIABLE-----#
numEjer="B"
host="www.aprendeaprogramar.org"
titulo="Problema B => Comprobamos que podemos resolver hosts de Internet"
nTestActual=1
fuenteBase64="I2luY2x1ZGUgPGlvc3RyZWFtPgp1c2luZyBuYW1lc3BhY2Ugc3RkOwoKaW50IG1haW4oKXsKCWNvdXQgPDwiMDY2ZjkzZTU3YjAxNWIxZGY4NDc3MTEyZGQzYWUwMmE1OWY5NDdkN2FmZTcxZTk3Mjk0MDlkNjJlZTE3OTk0MyI8PGVuZGw7CglyZXR1cm4gMDsKfQkK"

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
	print("Problema "+numEjer+" correcto. Sube el fichero ProbBRes.cpp que se ha generado")
	#print(str(m.hexdigest()))

	f = open('ProbBRes.cpp', 'w')
	f.write(base64.b64decode(fuenteBase64).decode())
	f.close()

	sys.exit(0)
#------------------------------------FIN AUXILIARES-----------------------------


#-----------------------------------DEFINIMOS TEST-----------------------------

#Imprimimos titulo
print(titulo+"\n")


#Ejecutando prueba , comprobamos si puede resolver hostnames
hostsATestear=["google.es","aprendeaprogramar.org","programa-me.com","marca.es"]

for miHost in hostsATestear:
	comando="host "+miHost+" | grep 'has address' | wc -l"

	ps = subprocess.Popen(comando,shell=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
	output = ps.communicate()[0]
	#Comprobamos si falla
	try:
		if int(output)<1:
			testFail("No puede resolverse el host "+miHost)
	except ValueError:
		testFail("No puede resolverse el host "+miHost)
	

	testPartialSuccess("El nombre de dominio "+miHost+" se ha podido resolver correctamente")
#Final de todos los casos sin fallar

testSuccess()





