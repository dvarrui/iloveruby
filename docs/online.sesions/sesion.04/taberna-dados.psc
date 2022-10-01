Proceso Taberna
	
	Definir tirada como entero
	
	Escribir "*Despiertas en una taberna, te encuentras tirado en el suelo, con dolor de cabeza. A primera vista no hay nadie más.*"
	Esperar 1 Segundo
	Escribir "*Pero al incorporporarte ves un hombre más alto que tú, te fijas en la forma puntiaguda de las orejas, es el tabernero, es un elfo, está detrás de la barra, dando la espalda.*"
	Esperar 2 Segundos
	Escribir "¿Qué haces?"
	Escribir "1. Te acercas a preguntarle qué ha pasado."
	Escribir "2. Intentas salir por la puerta sin hacer ruido. (Dado de sigilo D20 - Para éxito se requiere una tirada de 10 o superior)"
	
	leer eleccion
	
	Si eleccion = 1 Entonces
		Escribir "*Al acercarte llamas su atención.*"
		Esperar 1 Segundo
		Escribir "Tabernero: Buenos días dormilón, tras lo de anoche tuve que tomarte el pulso. Pensé que después de tal golpe en tu estado habrías muerto."
		Esperar 1 Segundo
	FinSi
	
	Si eleccion = 2 Entonces
		Escribir "Tiras el dado"
		Esperar 2 segundos
		tirada = azar(20)
		mientras tirada = 0 Hacer
			tirada = azar(20)
			escribir "¡Ha salido un ",tirada,"!"
			Esperar 2 segundos
		FinMientras
		escribir "¡Ha salido un ",tirada,"!"
		Esperar 2 segundos 
	FinSi
	
	si tirada < 10 Entonces
		Escribir "*Al intentas ir hacia la puerta, uno de tus pies choca con una jarra de cerveza derramada en el suelo, el tabernero lo escucha y se gira*"
		Esperar 1 Segundo
		Escribir "Tabernero: ¡Eh! ¿A dónde vas? Lo minimo es saludar, ven aquí, que llevas horas ahí tirado."
		Esperar 1 segundo
		
	sino 
		Escribir "*Mientras te vas acercando a la puerta, escuchas unos golpecitos en la barra, al darte la vuelta, ves al tabernero obserbándote, con cara de sorpresa.*"
		Esperar 1 segundo
		Escribir "Tabernero: Despiertas en el suelo, solo ves al dueño del local de espaldas y lo primero que haces es intentar irte sin decir ni mu..."
		Esperar 1 Segundo
		Escribir "Tabernero: Ven aquí, acércate. Voy a intentar refrescarte lo ocurrido anoche..."
		Esperar 1 Segundo
		Escribir "*Te diriges a la barra. Donde te está esperando limpiandola*"
		Esperar 2 segundos
	FinSi

	
	
	Escribir "Tabernero: ¿Recuerdas lo que te ocurrió?"
	Esperar 2 Segundos
	Escribir "1. Solo recuerdo haber bebido unas copas de más..."
	Escribir "2. ¿Golpe...?"
	
	leer opcResaca
	
	Si opcResaca = 1 Entonces
		Escribir "Tabernero: Exacto, bebiste muchas jarras de cervezas, pero lo importante es que una vez borracho, intentaste pelearte con el capitán de la guardia, que precisamente no estaba de humor."
		Esperar 1 segundo
		Escribir "Tabernero: No te culpo tampoco, lo que dijo de los de tu raza no estuvo bien nunca he entendido la necesidad del odio que le tienen los orcos a los humanos, las guerras acabaron hace siglos."
		Esperar 1 segundo
	FinSi
	
	Si opcResaca = 2 Entonces
		Escribir "Tabernero: Estabas borracho, el capitán de la guardia tiró una de tus cervezas, con el tropiezo con él, vio tu cara de humano bajo tu capucha, y e imagino que ya sabes lo que opinan los orcos de los humanos..."
		Esperar 1 segundo
		Escribir "Tabernero: Una cosa llevó a la otra y acabaste en el suelo de un golpe."
		Esperar 1 Segundo
	FinSi
	
	Escribir "Tabernero: Al noquearte se llevó tu bolsa de monedas y tus armas. Salió hace unas horas, su campamento no está muy lejos de aquí. Dime, ¿vas a intentar recuperarlas?"
	Esperar 2 segundos
	
	Escribir "1. Por supuesto, necesito mis cosas."
	Escribir "2. Sí, voy a devolvérsela a ese cabrón."
	
	leer opcVenganza
	
	Escribir "De acuerdo, toma este cuchillo, no sé si querrás hacerlo sin llamar la atención o armando un buen jaleo, pero ya que no tienes nada es posible que lo necesites."
	
	Esperar 1 Segundo
	
	Escribir "*Se ha añadido CUCHILLO al inventario*"
	Escribir "*Te guardas el cuchillo en la parte trasera del pantalón."
	
	Esperar 2 Segundos
	
	Escribir "Tabernero: El campamento está aproximadamente a un kilómetro hacia el norte, lo verás fácilmente."
	Esperar 1 segundo
	Escribir "Tabernero: Ten en cuenta que a pesar de haber algún que otro orco, esto es una ciudad élfica, los elfos de la guardia son buenos cazadores y algunos son demasiado buenos con la magia. Yo no entraría a lo loco."
	Esperar 1 segundo
	Escribir "Tabernero: Buena suerte, procura que no te maten, me debes 10 riggs por las cervezas de anoche y 3 por el el cuchillo."
	
	Esperar 2 Segundos
	Escribir "*Sales de la taberna*."
	
FinProceso