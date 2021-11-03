create database consulta_esquema_vacunación_QR;


create role rol_proyecto3_pub_sus with replication login password 'Proye3Ins';

grant all privileges on database consulta_esquema_vacunación_QR to rol_proyecto3_pub_sus;
grant all privileges on all tables in schema public to rol_proyecto3_pub_sus;
