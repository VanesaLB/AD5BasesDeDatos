-- MYSQL
create DATABASE IF NOT exists AD5;
USE AD5;
create table CENTROS (
NUMCE INT(4) NOT NULL,
NOMCE varchar(25),
DIRCE varchar(25)
);

CREATE TABLE DEPARTAMENTOS (
NUMDE INT(3) NOT NULL,
NUMCE INT(4),
DIREC INT(3),
TIDIR CHAR(1),
PRESU numeric (3,1),
DEPDE INT(3),
NOMDE VARCHAR(20)
);

CREATE TABLE EMPLEADOS (
NUMEM INT(3) NOT NULL,
EXTEL INT(3),
FECNA DATE ,
FECIN DATE,
SALAR INT(5),
COMIS INT(3),
NUMHI INT(1),
NOMEM VARCHAR (10),
NUMDE INT(3)
);

-- Primary key de todas las tablas
ALTER TABLE CENTROS
ADD PRIMARY KEY (NUMCE);

ALTER TABLE DEPARTAMENTOS
ADD PRIMARY KEY (NUMDE);

ALTER TABLE EMPLEADOS
ADD PRIMARY KEY (NUMEM);

-- Foreign key
ALTER TABLE DEPARTAMENTOS
ADD CONSTRAINT Empleados_Departamentos_FK
FOREIGN KEY (NUMCE) REFERENCES CENTROS (NUMCE)
ON DELETE SET NULL;
        
ALTER TABLE DEPARTAMENTOS
ADD CONSTRAINT Departamentos_FK
FOREIGN KEY (DEPDE) REFERENCES DEPARTAMENTOS (NUMDE)
ON DELETE SET NULL;

ALTER TABLE EMPLEADOS
ADD CONSTRAINT Departamentos_EmpleadosFK
FOREIGN KEY (NUMDE) REFERENCES DEPARTAMENTOS (NUMDE)
ON DELETE SET NULL;

-- Introducimos datos en la tabla DEPARTAMENTOS
INSERT INTO DEPARTAMENTOS (NUMDE,NUMCE,DIREC,TIDIR,PRESU,DEPDE,NOMDE) VALUES
(100,10,260,'P',72,null,'DIRECCION GENERAL'),
(110,20,180,'P',90,100,'DIRECCION COMERCIAL'),
(111,20,180,'F',66,110,'SECTOR INDUSTRIAL'),
(112,20,270,'P',54,110,'SECTOR SERVICIOS'),
(120,10,150,'F',18,100,'ORGANIZACIÓN'),
(121,10,150,'P',12,120,'PERSONAL'),
(122,10,350,'P',36,120,'PROCESO DE DATOS'),
(130,10,310,'P',12,100,'FINANZAS');

-- ¿Qué ocurre al insertar el primer registro? ¿Por qué? Plantea la solución.
/* La columna NUMCE hace referencia a los centros pero no están metidos los datos, así que primero metemos los datos
de los centros porque hay que insertar primero los datos de las tablas que no tienen FK*/
-- Introducimos datos en la tabla CENTROS
INSERT INTO CENTROS (NUMCE,NOMCE,DIRCE)VALUES
(10,'SEDE CENTRAL','C/ATOCHA ,820,MADRID'),
(20,'RELACION CON CLIENTES','C/ATOCHA,405,MADRID');

-- Inserta los siguientes datos en la tabla EMPLEADOS con un bulk insert:
INSERT INTO EMPLEADOS (NUMEM,EXTEL,FECNA,FECIN,SALAR,COMIS,NUMHI,NOMEM,NUMDE) VALUES 
  (110,350,'1970-11-10','1985-02-15',1800,NULL,3,'CESAR',121),
  (120,840,'1968-06-09','1988-10-01',1900,'110',1,'MARIO',112),
  (130,810,'1965-09-09','1981-02-01',1500,'110',2,'LUCIANO',112),
  (150,340,'1972-08-10','1997-01-15',2600,NULL,0,'JULIO',121),
  (160,740,'1980-07-09','2005-11-11',1800,'110',2,'AUREO',111),
  (180,508,'1974-10-18','1996-03-18',2800,'50',2,'MARCOS',110),
  (190,350,'1972-05-12','1992-02-11',1750,NULL,4,'JULIANA',121),
  (210,200,'1970-09-28','1999-01-22',1910,NULL,2,'PILAR',100),
  (240,760,'1967-02-26','1989-02-24',1700,'100',3,'LAVINIA',111),
  (250,250,'1976-10-27','1997-03-01',2700,NULL,0,'ADRIANA',100),
  (260,220,'1973-12-03','2001-07-12',720,NULL,6,'ANTONIO',100),
  (270,800,'1975-05-21','2003-09-10',1910,'80',3,'OCTAVIO',112),
  (280,410,'1978-01-10','2010-10-08',1500,NULL,5,'DOROTEA',130),
  (285,620,'1979-10-25','2011-02-15',1910,NULL,0,'OTILIA',122),
  (290,910,'1967-11-30','1988-02-14',1790,NULL,3,'GLORIA',120),
  (310,480,'1976-11-21','2001-01-15',1950,NULL,0,'AUGUSTO',130),
  (320,620,'1977-12-25','2003-02-05',2400,NULL,2,'CORNELIO',122),
  (330,850,'1958-08-19','1980-03-01',1700,'90',0,'AMELIA',112),
  (350,610,'1979-04-13','1999-09-10',2700,NULL,1,'AURELIO',122),
  (360,750,'1978-10-29','1998-10-10',1800,'100',2,'DORINDA',111),
  (370,360,'1977-06-22','2000-01-20',1860,NULL,1,'FABIOLA',121),
  (380,880,'1978-03-30','1999-01-01',1100,NULL,0,'MICAELA',112),
  (390,500,'1976-02-19','2010-10-08',1290,NULL,1,'CARMEN',110),
  (400,780,'1979-08-18','2011-11-01',1150,NULL,0,'LUCRECIA',111),
  (410,660,'1968-07-14','1989-10-13',1010,NULL,0,'AZUCENA',122),
  (420,450,'1966-10-22','1988-11-19',2400,NULL,0,'CLAUDIA',130),
  (430,650,'1967-10-26','1988-11-19',1260,NULL,1,'VALERIANA',122),
  (440,760,'1966-09-26','1986-02-28',1260,'100',0,'LIVIA',111),
  (450,880,'1966-10-21','1986-02-28',1260,'100',0,'SABINA',112),
  (480,760,'1965-04-04','1986-02-28',1260,'100',1,'DIANA',111),
  (490,880,'1964-06-06','1988-01-01',1090,'100',0,'HORACIO',112),
  (500,750,'1965-10-08','1987-01-01',1200,'100',0,'HONORIA',111),
  (510,550,'1966-05-04','1986-11-01',1200,NULL,1,'ROMULO',110),
  (550,780,'1970-01-10','1998-01-21',600,120,0,'SANCHO',111);

/* 1. Para cada departamento con presupuesto inferior a 35.000 €,
hallar el nombre del Centro donde está ubicado y el máximo salario de sus empleados
(si dicho máximo excede de 1.500 €). Clasificar alfabéticamente por nombre de departamento.*/
SELECT departamentos.nomde, centros.nomce, MAX(empleados.salar)
FROM departamentos 
INNER JOIN centros ON departamentos.numce = centros.numce
INNER JOIN empleados ON departamentos.numde = empleados.numde
WHERE departamentos.presu < 35
GROUP BY departamentos.nomde, centros.nomce
HAVING MAX(empleados.salar) > 1500
ORDER BY departamentos.nomde ASC;

/* 2. Hallar por orden alfabético los nombres de los departamentos que dependen
de los que tienen un presupuesto inferior a 30.000 €. También queremos conocer
el nombre del departamento del que dependen y su presupuesto.*/
-- REVISAR
SELECT departamentos.nomde AS nombre_departamento, departamentos.depde AS departamento_del_que_depende, presu AS presupuesto
FROM departamentos
WHERE departamentos.presu < 30
ORDER BY departamentos.nomde ASC;

/* 3. Obtener los nombres y los salarios medios de los departamentos cuyo salario medio
supera al salario medio de la empresa.*/




