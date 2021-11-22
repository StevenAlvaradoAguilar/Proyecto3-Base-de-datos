create database consulta_esquema_vacunacion_qr;

-- =======================================================================================================================================
-- Tablas necesarias para la replicación de datos
-- =======================================================================================================================================
-- DROP table personas;
create table personas
(
	id 	                       int primary key,
	cedula                     int not null,
	nombre                     varchar(50) not null,
	edad                       int not null,
	direccion_residencia       varchar(100) not null,
	centro_salud               varchar(100) not null,
	fecha_vacunacion           timestamp    null,
	numero_dosis         	   int          null,
	tipo_vacuna_aplicada       varchar(50)  null,
	responsable_personal_salud varchar(100) not null 
);
select * from personas;

-- DROP table vacuna_aplicada;
create table vacuna_aplicada
(
	id 					int primary key,
	fecha 				timestamp null,
	num_dosis 			smallint not null,
	centro_vacunacion 	int,
	paciente 			int,
	foreign key (centro_vacunacion) references centro_vacunacion,
	foreign key (paciente) references personas
);
select * from vacuna_aplicada;


-- =======================================================================================================================================
/* La tabla consultas lleva los atributos en la opción de info que es un json fecha de consulta, 
   la persona consultada, el local asociado, tipo, nombre del local y tipo de consulta */
-- =======================================================================================================================================
-- Drop table consultas;
create table consultas(
	id        serial,
    consulta  json NOT NULL,
	condicion boolean NOT NULL,
    CONSTRAINT PK_consultas PRIMARY KEY (id)
);

select * from consultas;

   	   
--Funcion que realiza y registra una consulta y ademas devuelve la respuesta
-- drop function estado_vacunacion;
CREATE OR REPLACE FUNCTION estado_vacunacion
(
	cedula         varchar(50), 
	nombre         varchar(50),
	tipo_local     varchar(50),
	nombre_local   varchar(50), 
	tipo_consulta  varchar(50),
	info_adicional varchar(500) 
) 
RETURNS SETOF JSON
AS 
$$
DECLARE
	cant_vacunas smallint;
	p_condicion boolean;
BEGIN
	--Realiza la consulta
	SELECT COUNT(*) FROM vacuna_aplicada WHERE cedula = cedula INTO cant_vacunas;
	
	--Registra la consulta
	IF cant_vacunas = 2 THEN
		p_condicion = true;
	ELSE
		p_condicion = false;
	END IF;
	
	INSERT INTO consultas (consulta, condicion)
	VALUES
	(
		json_build_object
		(
			'fecha', CURRENT_DATE, 
			'cedula', cedula, 
			'local', json_build_object('tipo_Comercio', tipo_local, 'persona_consultada', nombre_local), 
			'tipo_consulta', tipo_consulta, 
			'info_adicional', info_adicional),
		p_condicion
	);
	
	--Retorna la respuesta
	RETURN QUERY 
	SELECT json_build_object('Nombre', nombre, 'cedula', cedula, 'cant_vacunas', cant_vacunas, 'aceptado', p_condicion)
	AS estado_vacunacion;
	
END
$$ 
LANGUAGE PLPGSQL;


SELECT estado_vacunacion('207550366', 'José Solís Barquero', 'Comercio', 'Pali', 'Validación para ingreso por parte del local comercial', '...');

SELECT estado_vacunacion('206950342', 'María Angulo Picado', 'Comercio', 'El Rinconcito de Tita', 'Validación por personeros del Ministerio de salud', '...');
	   
SELECT estado_vacunacion('405889524', 'Martina Socorro Diaz', 'Servicios Públicos', 'Área de salud Naranjo', 'Validación para ingreso por parte del local comercial', '...');

SELECT estado_vacunacion('602350785', 'Melissa Solís Barquero', 'Tienda', 'La Naranjeña', 'Validación para ingreso por parte del local comercial', '...');
	   
SELECT estado_vacunacion('36950741', 'Jesús Sequeira Montes', 'Supermercado', 'CooproNaranjo', 'Validación por personeros del Ministerio de salud', '...');


-- =======================================================================================================================================
-- Creación de el rol y privilegios de la base de datos y la publicación y suscripción
-- =======================================================================================================================================
create role rol_proyecto3_pub_sus with replication login password 'Proye3Ins';

grant all privileges on database consulta_esquema_vacunacion_QR to rol_proyecto3_pub_sus;
grant all privileges on all tables in schema public to rol_proyecto3_pub_sus;


create publication mypub_consultas
	for table public.consultas
	WITH (publish = 'insert, update, delete, truncate');


create subscription mysub 
	connection 'host=localhost port=5436 dbname=ministerio_salud user=rol_proyecto3 password=Proye3Ins'
	publication mypub
	
select * from personas;
SELECT * FROM centro_vacunacion;
SELECT * FROM vacuna_aplicada;
select * from consultas;	
	
	
	