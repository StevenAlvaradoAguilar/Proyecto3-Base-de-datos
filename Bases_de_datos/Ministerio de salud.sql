create database ministerio_salud;

-- Tabla a publicar con registro de personas
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


-- DROP TABLE centro_vacunacion;
create table centro_vacunacion
(
	id 					int primary key,
	nombre				varchar(100) not null,
	num_dosis_asignadas	int null,
	num_dosis_aplicadas	int null
);


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

-- Registro de datos 
insert into personas(id,cedula,nombre,edad,direccion_residencia,centro_salud,fecha_vacunacion,numero_dosis,tipo_vacuna_aplicada,responsable_personal_salud)
values (1, 207550366, 'José Solís Barquero', 15, 'Naranjo', 'Area_Salud_Naranjo', '12-06-2021 08:00:59', 1, 'Pfizer', 'Juan Montes Chavarría');

insert into personas(id,cedula,nombre,edad,direccion_residencia,centro_salud,fecha_vacunacion,numero_dosis,tipo_vacuna_aplicada,responsable_personal_salud)
values (2, 108950785, 'Helena Gutierrez Mora', 25, 'El Rosario', 'Area_Salud_Naranjo', '03-08-2021 11:15:29', 2, 'AstraZeneca', 'Viky Quiros Solano');

insert into personas(id,cedula,nombre,edad,direccion_residencia,centro_salud,fecha_vacunacion,numero_dosis,tipo_vacuna_aplicada,responsable_personal_salud)
values (3, 308995214, 'Alonso Jimenez Salazar', 30, 'Dulce Nombre', 'Area_Salud_Naranjo', '07-15-2021 02:45:59', 1, 'Sputnik V', 'Julieta Barquero Azofeifa');

insert into personas(id,cedula,nombre,edad,direccion_residencia,centro_salud,fecha_vacunacion,numero_dosis,tipo_vacuna_aplicada,responsable_personal_salud)
values (4, 405889524, 'Martin Alfaro Flores', 63, 'El Rosario', 'Area_Salud_Naranjo', '01-03-2021 09:15:03', 1, 'AstraZeneca', 'Juan Montes Chavarría');

insert into personas(id,cedula,nombre,edad,direccion_residencia,centro_salud,fecha_vacunacion,numero_dosis,tipo_vacuna_aplicada,responsable_personal_salud)
values (5, 50360412, 'Marta Lopez Solis', 65, 'Pilas', 'Area_Salud_Naranjo', '05-04-2021 08:15:03', 1, 'Sputnik V', 'Juan Montes Chavarría');

insert into personas(id,cedula,nombre,edad,direccion_residencia,centro_salud,fecha_vacunacion,numero_dosis,tipo_vacuna_aplicada,responsable_personal_salud)
values (6, 206950342, 'María Angulo Picado', 18, 'Pilas', 'Area_Salud_Naranjo', '05-08-2021 09:15:03', 2, 'Pfizer', 'Julieta Barquero Azofeifa');

insert into personas(id,cedula,nombre,edad,direccion_residencia,centro_salud,fecha_vacunacion,numero_dosis,tipo_vacuna_aplicada,responsable_personal_salud)
values (7, 305780788, 'Rosa Solis Barquero', 26, 'El Rosario', 'Area_Salud_Naranjo', '05-08-2021 09:30:03', 1, 'Pfizer', 'Julieta Barquero Azofeifa');

insert into personas(id,cedula,nombre,edad,direccion_residencia,centro_salud,fecha_vacunacion,numero_dosis,tipo_vacuna_aplicada,responsable_personal_salud)
values (8, 405889524, 'Martina Socorro Diaz', 36, 'El Rosario', 'Area_Salud_Naranjo', '09-04-2021 08:30:03', 1, 'Sputnik V', 'Juan Montes Chavarría');

insert into personas(id,cedula,nombre,edad,direccion_residencia,centro_salud,fecha_vacunacion,numero_dosis,tipo_vacuna_aplicada,responsable_personal_salud)
values (9, 602350785, 'Melissa Solís Barquero', 12, 'Pilas', 'Area_Salud_Naranjo', '05-04-2021 08:20:03', 1, 'Pfizer', 'Juan Montes Chavarría');

insert into personas(id,cedula,nombre,edad,direccion_residencia,centro_salud,fecha_vacunacion,numero_dosis,tipo_vacuna_aplicada,responsable_personal_salud)
values (10, 204510369, 'Melani Castro Perez', 21, 'El Llano', 'Area_Salud_Naranjo', '05-08-2021 09:40:03', 2, 'Pfizer', 'Julieta Barquero Azofeifa');

insert into personas(id,cedula,nombre,edad,direccion_residencia,centro_salud,fecha_vacunacion,numero_dosis,tipo_vacuna_aplicada,responsable_personal_salud)
values (11, 208941045, 'Steven Alvarado Rodriguez', 28, 'Pilas', 'Area_Salud_Naranjo', '05-04-2021 08:58:03', 1, 'AstraZeneca', 'Juan Montes Chavarría');

insert into personas(id,cedula,nombre,edad,direccion_residencia,centro_salud,fecha_vacunacion,numero_dosis,tipo_vacuna_aplicada,responsable_personal_salud)
values (12, 36950741, 'Jesús Sequeira Montes', 15, 'El Hoyo', 'Area_Salud_Naranjo', '05-08-2021 010:15:03', 2, 'AstraZeneca', 'Julieta Barquero Azofeifa');

select * from personas;

-- Inserciones de datos en la tabla centro_vacunacion
-- nombre, num_dosis_asignadas, num_dosis_aplicadas
insert into centro_vacunacion(id,nombre,num_dosis_asignadas,num_dosis_aplicadas)
values (240, 'Area de salud Naranjo', 800, 650);

insert into centro_vacunacion(id,nombre,num_dosis_asignadas,num_dosis_aplicadas)
values (241, 'Area de salud Naranjo', 600, 250);

insert into centro_vacunacion(id,nombre,num_dosis_asignadas,num_dosis_aplicadas)
values (242, 'Area de salud Naranjo', 400, 150);

insert into centro_vacunacion(id,nombre,num_dosis_asignadas,num_dosis_aplicadas)
values (243, 'Area de salud Naranjo', 350, 100);

insert into centro_vacunacion(id,nombre,num_dosis_asignadas,num_dosis_aplicadas)
values (244, 'Area de salud Naranjo', 200, 15);

insert into centro_vacunacion(id,nombre,num_dosis_asignadas,num_dosis_aplicadas)
values (245, 'Area de salud Naranjo', 90, 15);

insert into centro_vacunacion(id,nombre,num_dosis_asignadas,num_dosis_aplicadas)
values (246, 'Area de salud Naranjo', 90, 20);

insert into centro_vacunacion(id,nombre,num_dosis_asignadas,num_dosis_aplicadas)
values (247, 'Area de salud Naranjo', 90, 45);

insert into centro_vacunacion(id,nombre,num_dosis_asignadas,num_dosis_aplicadas)
values (248, 'Area de salud Naranjo', 80, 25);

SELECT * FROM centro_vacunacion;


-- ---------------------------------------------------------------------------------------------------------
-- Inserciones de datos en la tabla vacunas_aplicadas
-- id, fecha, num_dosis, centro_vacunacion, paciente
-- ---------------------------------------------------------------------------------------------------------
insert into vacuna_aplicada(id,fecha,num_dosis,centro_vacunacion,paciente)
values (1::int,'01-01-2021 10:15:29'::timestamp,1::smallint,240::int,2::int);

insert into vacuna_aplicada(id,fecha,num_dosis,centro_vacunacion,paciente)
values (2::int,'03-03-2021 11:00:59'::timestamp,2::smallint,241::int,1::int);

insert into vacuna_aplicada(id,fecha,num_dosis,centro_vacunacion,paciente)
values (3::int,'05-05-2021 09:15:03'::timestamp,1::smallint,242::int,4::int);

insert into vacuna_aplicada(id,fecha,num_dosis,centro_vacunacion,paciente)
values (4::int,'06-07-2021 13:00:59'::timestamp,2::smallint,243::int,3::int);

insert into vacuna_aplicada(id,fecha,num_dosis,centro_vacunacion,paciente)
values (5::int,'02-08-2021 09:15:03'::timestamp,1::smallint,244::int,10::int);

insert into vacuna_aplicada(id,fecha,num_dosis,centro_vacunacion,paciente)
values (6::int,'08-04-2021 08:15:03'::timestamp,2::smallint,245::int,9::int);

insert into vacuna_aplicada(id,fecha,num_dosis,centro_vacunacion,paciente)
values (7::int,'02-08-2021 13:00:59'::timestamp,1::smallint,246::int,12::int);

insert into vacuna_aplicada(id,fecha,num_dosis,centro_vacunacion,paciente)
values (8::int,'08-04-2021 09:30:03'::timestamp,2::smallint,247::int,11::int);

insert into vacuna_aplicada(id,fecha,num_dosis,centro_vacunacion,paciente)
values (9::int,'08-04-2021 13:00:59'::timestamp,2::smallint,246::int,5::int);

insert into vacuna_aplicada(id,fecha,num_dosis,centro_vacunacion,paciente)
values (10::int,'02-08-2021 09:30:03'::timestamp,1::smallint,247::int,6::int);

insert into vacuna_aplicada(id,fecha,num_dosis,centro_vacunacion,paciente)
values (11::int,'08-08-2021 13:00:59'::timestamp,2::smallint,246::int,7::int);

insert into vacuna_aplicada(id,fecha,num_dosis,centro_vacunacion,paciente)
values (12::int,'12-04-2021 09:30:03'::timestamp,2::smallint,247::int,8::int);

SELECT * FROM vacuna_aplicada;
-- DELETE FROM vacuna_aplicada WHERE id = 8;


-- =======================================================================================================================================
-- Creación de el rol y privilegios de la base de datos y la publicación y suscripción
-- =======================================================================================================================================
create role rol_proyecto3 with replication login password 'Proye3Ins';

grant all privileges on database ministerio_salud to rol_proyecto3;
grant all privileges on all tables in schema public to rol_proyecto3;


create publication mypub
	FOR ALL TABLES
	WITH (publish = 'insert, update, delete, truncate');

	
