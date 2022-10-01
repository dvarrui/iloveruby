Proceso Taberna
	
	Definir tirada como entero
	
	Escribir "*Despiertas en una taberna, te encuentras tirado en el suelo, con dolor de cabeza. A primera vista no hay nadie m�s.*"
	Esperar 1 Segundo
	Escribir "*Pero al incorporporarte ves un hombre m�s alto que t�, te fijas en la forma puntiaguda de las orejas, es el tabernero, es un elfo, est� detr�s de la barra, dando la espalda.*"
	Esperar 2 Segundos
	Escribir "�Qu� haces?"
	Escribir "1. Te acercas a preguntarle qu� ha pasado."
	Escribir "2. Intentas salir por la puerta sin hacer ruido. (Dado de sigilo D20 - Para �xito se requiere una tirada de 10 o superior)"
	
	leer eleccion
	
	Si eleccion = 1 Entonces
		Escribir "*Al acercarte llamas su atenci�n.*"
		Esperar 1 Segundo
		Escribir "Tabernero: Buenos d�as dormil�n, tras lo de anoche tuve que tomarte el pulso. Pens� que despu�s de tal golpe en tu estado habr�as muerto."
		Esperar 1 Segundo
	FinSi
	
	Si eleccion = 2 Entonces
		Escribir "Tiras el dado"
		Esperar 2 segundos
		tirada = azar(20)
		mientras tirada = 0 Hacer
			tirada = azar(20)
			escribir "�Ha salido un ",tirada,"!"
			Esperar 2 segundos
		FinMientras
		escribir "�Ha salido un ",tirada,"!"
		Esperar 2 segundos 
	FinSi
	
	si tirada < 10 Entonces
		Escribir "*Al intentas ir hacia la puerta, uno de tus pies choca con una jarra de cerveza derramada en el suelo, el tabernero lo escucha y se gira*"
		Esperar 1 Segundo
		Escribir "Tabernero: �Eh! �A d�nde vas? Lo minimo es saludar, ven aqu�, que llevas horas ah� tirado."
		Esperar 1 segundo
		
	sino 
		Escribir "*Mientras te vas acercando a la puerta, escuchas unos golpecitos en la barra, al darte la vuelta, ves al tabernero obserb�ndote, con cara de sorpresa.*"
		Esperar 1 segundo
		Escribir "Tabernero: Despiertas en el suelo, solo ves al due�o del local de espaldas y lo primero que haces es intentar irte sin decir ni mu..."
		Esperar 1 Segundo
		Escribir "Tabernero: Ven aqu�, ac�rcate. Voy a intentar refrescarte lo ocurrido anoche..."
		Esperar 1 Segundo
		Escribir "*Te diriges a la barra. Donde te est� esperando limpiandola*"
		Esperar 2 segundos
	FinSi

	
	
	Escribir "Tabernero: �Recuerdas lo que te ocurri�?"
	Esperar 2 Segundos
	Escribir "1. Solo recuerdo haber bebido unas copas de m�s..."
	Escribir "2. �Golpe...?"
	
	leer opcResaca
	
	Si opcResaca = 1 Entonces
		Escribir "Tabernero: Exacto, bebiste muchas jarras de cervezas, pero lo importante es que una vez borracho, intentaste pelearte con el capit�n de la guardia, que precisamente no estaba de humor."
		Esperar 1 segundo
		Escribir "Tabernero: No te culpo tampoco, lo que dijo de los de tu raza no estuvo bien nunca he entendido la necesidad del odio que le tienen los orcos a los humanos, las guerras acabaron hace siglos."
		Esperar 1 segundo
	FinSi
	
	Si opcResaca = 2 Entonces
		Escribir "Tabernero: Estabas borracho, el capit�n de la guardia tir� una de tus cervezas, con el tropiezo con �l, vio tu cara de humano bajo tu capucha, y e imagino que ya sabes lo que opinan los orcos de los humanos..."
		Esperar 1 segundo
		Escribir "Tabernero: Una cosa llev� a la otra y acabaste en el suelo de un golpe."
		Esperar 1 Segundo
	FinSi
	
	Escribir "Tabernero: Al noquearte se llev� tu bolsa de monedas y tus armas. Sali� hace unas horas, su campamento no est� muy lejos de aqu�. Dime, �vas a intentar recuperarlas?"
	Esperar 2 segundos
	
	Escribir "1. Por supuesto, necesito mis cosas."
	Escribir "2. S�, voy a devolv�rsela a ese cabr�n."
	
	leer opcVenganza
	
	Escribir "De acuerdo, toma este cuchillo, no s� si querr�s hacerlo sin llamar la atenci�n o armando un buen jaleo, pero ya que no tienes nada es posible que lo necesites."
	
	Esperar 1 Segundo
	
	Escribir "*Se ha a�adido CUCHILLO al inventario*"
	Escribir "*Te guardas el cuchillo en la parte trasera del pantal�n."
	
	Esperar 2 Segundos
	
	Escribir "Tabernero: El campamento est� aproximadamente a un kil�metro hacia el norte, lo ver�s f�cilmente."
	Esperar 1 segundo
	Escribir "Tabernero: Ten en cuenta que a pesar de haber alg�n que otro orco, esto es una ciudad �lfica, los elfos de la guardia son buenos cazadores y algunos son demasiado buenos con la magia. Yo no entrar�a a lo loco."
	Esperar 1 segundo
	Escribir "Tabernero: Buena suerte, procura que no te maten, me debes 10 riggs por las cervezas de anoche y 3 por el el cuchillo."
	
	Esperar 2 Segundos
	Escribir "*Sales de la taberna*."
	
FinProceso