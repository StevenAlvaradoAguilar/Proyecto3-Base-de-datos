create database estadisticas;











create subscription mysub 
	connection 'host=localhost port=5436 dbname=ministerio_salud user=rol_proyecto3 password=Proye3Ins'
	publication mypub_pacientes