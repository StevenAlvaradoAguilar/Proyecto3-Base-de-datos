create database estadisticas;

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


-- DROP TABLE centro_vacunacion;
create table centro_vacunacion
(
	id 					int primary key,
	nombre				varchar(100) not null,
	num_dosis_asignadas	int null,
	num_dosis_aplicadas	int null
);
select * from centro_vacunacion;


-- DROP TABLE vacuna_aplicada;
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
-- drop table consultas;
CREATE TABLE consultas
(
	id        serial,
    consulta  json NOT NULL,
	condicion boolean,
    CONSTRAINT PK_consultas PRIMARY KEY (id)
);

select * from consultas;

-- Tabla para registrar los datos necesarios para las estadisticas
CREATE TABLE estadisticas
(
	id_consulta   int NOT NULL,
	fecha         date NOT NULL,
	tipo_local    varchar(50) NOT NULL,
	nombre_local  varchar(100) NOT NULL, 
	tipo_consulta varchar(50) NULL,
    id_aceptado   int NULL,
	id_rechazado  int NULL,
	CONSTRAINT PK_estadisticas PRIMARY KEY (id_consulta),
	CONSTRAINT FK_estadisticas_consultas FOREIGN KEY (id_consulta) references consultas,
	CONSTRAINT FK_estadisticas_personas FOREIGN KEY (id_aceptado) references personas
);
select * from estadisticas;

-- Creación de indice sobre el atributo tipo de comercio de la tabla consultas 
CREATE INDEX idx_tipo_local ON estadisticas USING hash (tipo_local);

-- Creación de índice sobre el tipo de consulta de la tabla consultas 
CREATE INDEX idx_tipo_consulta ON estadisticas USING hash (tipo_consulta);

-- =======================================================================================================================================
-- Creación de procedimientos necesarios para la obtención de datos
-- =======================================================================================================================================
--Funcion para llenar la tabla de estadisticas a partir de las consultas
CREATE OR REPLACE FUNCTION insertar_estadisticas() 
RETURNS VOID
AS 
$$
DECLARE
	c_consultas REFCURSOR;
	id_aceptado     int;
	id_rechazado    int;
	p_identificador int;
	p_consulta      json;
	p_condicion     boolean;
BEGIN
	OPEN c_consultas FOR 
	SELECT id, consulta, condicion 
	FROM consultas;
	FETCH c_consultas INTO p_identificador, p_consulta, p_condicion;
	LOOP
		IF FOUND THEN
			id_aceptado = NULL;
			id_rechazado = NULL;
			
			IF p_condicion IS TRUE THEN
				SELECT CAST(p_consulta ->> 'id' AS int) INTO id_aceptado;
			ELSE
				SELECT CAST(p_consulta ->> 'id' AS int) INTO id_rechazado;
			END IF;
			
			INSERT INTO estadisticas(id_consulta, fecha, tipo_local, nombre_local, tipo_consulta, id_aceptado, id_rechazado)
			VALUES 
			(
				p_identificador, 
				CAST(p_consulta ->> 'fecha' AS date),
				CAST(p_consulta -> 'local' ->> 'tipo' AS varchar(50)),
				CAST(p_consulta -> 'local' ->> 'nombre' AS varchar(100)),
				CAST(p_consulta ->> 'tipo_consulta' AS varchar(50)),
				id_aceptado,
				id_rechazado
			);
		ELSE
			EXIT;
		END IF;
		FETCH c_consultas INTO p_identificador, p_consulta, p_condicion;
	END LOOP;
END
$$ 
LANGUAGE PLPGSQL;


SELECT insertar_estadisticas();

--Reporte de la cantidad de personas aceptadas y rechazadas por tipo de local comercial.
CREATE OR REPLACE FUNCTION estadisticas_tipo_local(tipo varchar(50)) 
RETURNS SETOF JSON
AS 
$$
DECLARE 
	aceptadas int;
	rechazadas int;
BEGIN
	SELECT count(*) FROM estadisticas WHERE tipo_local = tipo AND id_aceptado IS NOT NULL INTO aceptadas;
	SELECT count(*) FROM estadisticas WHERE tipo_local = tipo AND id_rechazado IS NOT NULL INTO rechazadas;
	
	RETURN QUERY 
	SELECT json_build_object('Aceptadas', aceptadas, 'Rechazadas', rechazadas)
	AS estado_vacunacion;
END
$$ 
LANGUAGE PLPGSQL;

--Para un local comercial específico determinar la cantidad de personas aceptadas y 
--rechazadas en un período de fecha establecidas
CREATE OR REPLACE FUNCTION estadisticas_fecha(nombre varchar(100), inicio date, fin date) 
RETURNS SETOF JSON
AS 
$$
DECLARE 
	aceptadas int;
	rechazadas int;
BEGIN
	SELECT count(*) FROM estadisticas WHERE id_aceptado IS NOT NULL AND nombre_local = nombre AND fecha BETWEEN inicio AND fin INTO aceptadas;
	SELECT count(*) FROM estadisticas WHERE id_rechazado IS NOT NULL AND nombre_local = nombre AND fecha BETWEEN inicio AND fin INTO rechazadas;
	
	RETURN QUERY 
	SELECT json_build_object('Aceptadas', aceptadas, 'Rechazadas', rechazadas)
	AS estado_vacunacion;
END
$$ 
LANGUAGE PLPGSQL;

--Para un local comercial específico determinar el total de personas aceptadas y rechazadas 
--por personeros del ministerio de salud.
CREATE OR REPLACE FUNCTION estadisticas_personal_MinisterioSalud(nombre varchar(100)) 
RETURNS SETOF json
AS 
$$
DECLARE 
	aceptadas int;
	rechazadas int;
BEGIN
	SELECT count(*) FROM estadisticas WHERE id_aceptado IS NOT NULL AND nombre_local = nombre AND tipo_consulta = 'Ministerio de salud' INTO aceptadas;
	SELECT count(*) FROM estadisticas WHERE id_rechazado IS NOT NULL AND nombre_local = nombre AND tipo_consulta = 'Ministerio de salud' INTO rechazadas;

	RETURN QUERY 
	SELECT json_build_object('Aceptadas', aceptadas, 'Rechazadas', rechazadas)
	AS estado_vacunacion;
END
$$ 
LANGUAGE PLPGSQL;

-- =======================================================================================================================================
-- Creación de suscripción de la base de datos
-- =======================================================================================================================================
create subscription mysub3 
	connection 'host=localhost port=5436 dbname=ministerio_salud user=rol_proyecto3 password=Proye3Ins'
	publication mypub
	
	
create subscription mysub4
	connection 'host=localhost port=5437 dbname=consulta_esquema_vacunacion_qr user=rol_proyecto3_pub_sus password=Proye3Ins'
	publication mypub_consultas
	
	