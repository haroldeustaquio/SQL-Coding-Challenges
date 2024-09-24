
/*
Instrucciones
Realiza esta evaluacion en un solo archivo ".sql", este archivo tienen que tener este nombre "<PRIMER_APELLIDO>_<PRIMER_NOMBRE>.sql", 
este archivo tiene que ser comprimido y subido al aula virtual, no es necesario referenciar o subir los datos

	0. (0 pts)
		Crea una base de datos llamada "bd_evaluacion" usando sql, donde importes el archivo usado en sesiones pasadas con el nombre de "pea_privada" mediante 
		BULK INSERT pea_privada
		FROM '<TU PROPIA RUTA>\PEA-PRIVADA-2021-MUESTRA.csv'
		WITH ( FORMAT = 'CSV',FIELDTERMINATOR = '|',FIRSTROW = 2);
	1.(2 pts)
		Crea un JOB llamado "jb_test" que realice los sgtes pasos:
		- Si del segundo del tiempo(getdate()) que consultes coincide con el último dígito del "UUID" de la tabla "pea_privada"
		- Retornaras un tabla ordenada por nombre  del "departamento" en minuscula, el promedio de la "remuneracion" en este formato "#,#.00"
		- Esta tabla ordenada la guardaras en la tabla llamada "LogQuery" en la misma base de datos de la pea_privada, 
		  con las columnas (id_trans,departamento,promedio_salario,fecha_hora_ejecucion)
		- Este job tiene que ser ejecutado cada 3 minutos
	2. (1 pts) 
		Realiza un tratamiento de texto a las columnas actividad_economica,departamento abreviando los nombres a criterio, usando update
	3. (2 o 3 pts)
		Usando SQL dinámico(3 pts) / PIVOT simple (2 pts) crea un query que genere, los promedios de salarios por departamento y actividad_economica,
		donde la actividad economica sean las columnas y el departameto las filas
	4. (5pts)
		Estandariza los nombres del json proveido llamado "pokedex" y guardalos en una tabla llamada "tbl_pokemones"
		id: Identification Number -> id_pokemon 
		num: Number of the Pokémon in the official Pokédex ->num_pokemon
		name: Pokémon name -> nombre
		img: URL to an image of this Pokémon -> url_imagen
		type: Pokémon type -> tipo_pokemon
		height: Pokémon height -> altura
		weight: Pokémon weight -> peso
		weakness: Types of Pokémon this Pokémon is weak to -> debilidades
		next_evolution: Number and Name of successive evolutions of Pokémon -> evolucion
		prev_evolution: Number and Name of previous evolutions of Pokémon -> evolucion_previa
	5. (9 pts)
		(2pt) a. Filtra cuales son las últimas evoluciones de los pokemos, revisa el nivel de jerarquia de la evolución
		(3pt) b. Cuantas evoluciones siguientes y previas tiene el pokemon (Usando funciones)
		(2pt) c. Evalua la cantidad de tipos con los cuales el pokemon tiene debilidad
		(2pt) d. Muestrame el top 20 de los pokemones más altos, dado el tipo que le pasas en un SP (stored procedure)

		--Ejemplo de lectura
		select c.*
		from openrowset(bulk '<tu_ruta>\pokedex.json', single_clob) as j
		cross apply openjson(BulkColumn) as r
			cross apply openjson(r.[value]) as c

*/



--	0. (0 pts)
--	Crea una base de datos llamada "bd_evaluacion" usando sql, donde importes el archivo usado en sesiones pasadas con el nombre de "pea_privada" mediante 
--	BULK INSERT pea_privada
--	FROM '<TU PROPIA RUTA>\PEA-PRIVADA-2021-MUESTRA.csv'
--	WITH ( FORMAT = 'CSV',FIELDTERMINATOR = '|',FIRSTROW = 2);

if exists
	(select name from sys.databases where name = 'bd_evaluacion')
drop database bd_evaluacion
create database bd_evaluacion
go

use bd_evaluacion
go

if exists
	(select name from sys.tables where name = 'pea_privada') 
drop table pea_privada
CREATE TABLE pea_privada (
	[MES] [varchar](20),
	[REMUNERACION] varchar(20),
	[RANGO_EDAD] [nvarchar](50),
	[NIVEL_EDUCATIVO] [nvarchar](100),
	[TAMAÑO_EMPRESA] [nvarchar](50),
	[SEXO] [nvarchar](50),
	[DEPARTAMENTO] [nvarchar](50),
	[ACTIVIDAD_ECONOMICA] [nvarchar](100) ,
	[UUID] [varchar](20)
)
go

BULK INSERT pea_privada
FROM 'K:\DMC\SQL for Data Engineering\Sesión 2\PEA-PRIVADA-2021-MUESTRA.csv'
WITH ( FORMAT = 'CSV',FIELDTERMINATOR = '|',FIRSTROW = 2);

/*
1.(2 pts)
	Crea un JOB llamado "jb_test" que realice los sgtes pasos:
	Si del segundo del tiempo(getdate()) que consultes coincide con el último dígito del "UUID" de la tabla "pea_privada"
	Retornaras un tabla ordenada por nombre  del "departamento" en minuscula, el promedio de la "remuneracion" en este formato "#,#.00"
	Esta tabla ordenada la guardaras en la tabla llamada "LogQuery" en la misma base de datos de la pea_privada, 
	con las columnas (id_trans,departamento,promedio_salario,fecha_hora_ejecucion)
	Este job tiene que ser ejecutado cada 3 minutos */

if exists
	(select name from sys.tables where name = 'LogQuery') 
drop table LogQuery
CREATE TABLE LogQuery (
	id_trans int identity,
	departamento nvarchar(50),
	promedio_salario nvarchar(50),
	fecha_hora_ejecucion datetime
)

use msdb
go

exec sp_add_job @job_name = N'jb_test',
	@owner_login_name='sa';

exec sp_add_jobstep
    @job_name = 'jb_test',
    @step_name = 'actualizar_datos',
    @subsystem = 'tsql',
    @command = N'
		truncate table LogQuery
		insert into LogQuery(departamento, promedio_salario, fecha_hora_ejecucion)
		select 
		lower(departamento) as departamento,
		format(avg(cast(remuneracion as float)),"#,#.0") as promedio_salario,
		getdate() as fecha_hora_ejecucion  
		from pea_privada
		where right(uuid,1) like (SELECT right(DATEPART(SECOND, GETDATE()),1))
		group by departamento',
	@database_name=N'bd_evaluacion',
    @on_success_action = 1;

EXEC dbo.sp_add_jobschedule
    @job_name = 'jb_test',
    @name = 'cada_3_minutos',
    @enabled = 1,
    @freq_type = 4,  -- Frecuencia diaria
    @freq_interval = 1,  -- Todos los días
    @freq_subday_type = 4,  -- Por intervalos de tiempo
    @freq_subday_interval = 3, -- Cada 3 minutos
	@active_start_date = 20240512;  -- fecha de inicio


exec sp_add_jobserver
    @job_name = 'jb_test',
    @server_name = '(local)';


use bd_evaluacion
go

select * from LogQuery
-- Como dice que retorna una tabla, se asume que al inicio LogQuery está vacío
-- Si se ejecuta cada 3 minutos, el segundo de la fecha_hora_ejecucion no va a cambiar



--2. (1 pts) 
--	Realiza un tratamiento de texto a las columnas actividad_economica,departamento abreviando los nombres a criterio, usando update

update pea_privada
set departamento  = 
					case
						when DEPARTAMENTO like '%UAN%' then left(REPLACE(DEPARTAMENTO,'UAN',''),3)
						when departamento = replace(departamento,' ','') then left(departamento,3)
						else left(replace(departamento,' ',''),3)
					end 

update pea_privada
set actividad_economica =  left(replace(ACTIVIDAD_ECONOMICA,' ',''),4) 


-- Arreglamos los errores que se generan por las tildes en DEPARTAMENTO

UPDATE pea_privada
SET
    DEPARTAMENTO = CASE
                    WHEN DEPARTAMENTO like '%CASH' THEN 'ANCASH'
                    WHEN DEPARTAMENTO like '%MAC' THEN 'APURIMAC'
                    WHEN DEPARTAMENTO like '%NUCO' THEN 'HUANUCO'
                    WHEN DEPARTAMENTO like 'JUN%' THEN 'JUNIN'
                    WHEN DEPARTAMENTO like 'SAN%' THEN 'SAN MARTIN'
					ELSE DEPARTAMENTO
                END

--3. (2 o 3 pts)
--	Usando SQL dinámico(3 pts) / PIVOT simple (2 pts) crea un query que genere, los promedios de salarios por departamento y actividad_economica,
--	donde la actividad economica sean las columnas y el departameto las filas

DECLARE @cols AS NVARCHAR(MAX),
		@query  AS NVARCHAR(MAX);

-- Creado tabla @pivot
drop table if exists #pivot;
create table #pivot (
    Departamento varchar(50),
	[ACTI] float,[ADMI] float,[AGRI] float,[COME] float,[CONS] float,[ENSE] float,
	[EXPL] float,[HOGA] float,[HOTE] float,[INDU] float,[INTE] float,[NODE] float,
	[ORGA] float,[OTRA] float,[PESC] float,[SERV] float,[SUMI] float,[TRAN] float
);

-- Lista de las actividad_economica única presentes en la tabla
SELECT @cols = STUFF((SELECT distinct ',' + QUOTENAME(ACTIVIDAD_ECONOMICA)
            FROM pea_privada
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')

SET @query = 'insert into #pivot(Departamento, [ACTI],[ADMI],[AGRI],[COME],[CONS],[ENSE],[EXPL],[HOGA],[HOTE],[INDU],[INTE],[NODE],[ORGA],[OTRA],[PESC],[SERV],[SUMI],[TRAN])
			SELECT Departamento, ' + @cols + '
            FROM 
            (
				SELECT departamento, actividad_economica, round(AVG(CAST(REMUNERACION AS FLOAT)),2) AS promedio
				FROM pea_privada
				GROUP BY DEPARTAMENTO, ACTIVIDAD_ECONOMICA
            ) AS x
            PIVOT 
            (
                MAX(promedio)
                FOR actividad_economica IN (' + @cols + ')
            ) AS p';

exec(@query);
go

select * from #pivot


--4. (5pts)
--	Estandariza los nombres del json proveido llamado "pokedex" y guardalos en una tabla llamada "tbl_pokemones"
--	id: Identification Number -> id_pokemon 
--	num: Number of the Pokémon in the official Pokédex ->num_pokemon
--	name: Pokémon name -> nombre
--	img: URL to an image of this Pokémon -> url_imagen
--	type: Pokémon type -> tipo_pokemon
--	height: Pokémon height -> altura
--	weight: Pokémon weight -> peso
--	weakness: Types of Pokémon this Pokémon is weak to -> debilidades
--	next_evolution: Number and Name of successive evolutions of Pokémon -> evolucion
--	prev_evolution: Number and Name of previous evolutions of Pokémon -> evolucion_previa

if exists(select name from sys.tables where name = 'tbl_pokemones')
drop table tbl_pokemones
(select * 
into tbl_pokemones
from 
(select f.id_pokemon, f.num_pokemon, f.nombre, f.url_imagen, f.tipo_pokemon, f.altura, f.peso, f.debilidades, f.evolucion_previa, f.evolucion
from
	(SELECT 
		ROW_NUMBER() OVER (PARTITION BY p.id order by cast(ne.num AS INT) asc, CAST(pe.num AS INT) desc) AS ranke,
		p.id as id_pokemon,
		p.num as num_pokemon,
		p.name as nombre,
		p.img as url_imagen,
		p.type as tipo_pokemon,
		p.height as altura,
		p.weight as peso,
		p.weaknesses as debilidades,
		ne.num +' ' + ne.name AS evolucion,
		pe.num + ' ' + pe.name as evolucion_previa 
	FROM 
		OPENROWSET(BULK 'K:\DMC\SQL for Data Engineering\Sesión 6\data\pokedex.json', SINGLE_CLOB) AS j
	CROSS APPLY 
		OPENJSON(BulkColumn) WITH (
			pokemon NVARCHAR(MAX) '$.pokemon' AS JSON
		) AS r
	CROSS APPLY 
		OPENJSON(r.pokemon) WITH (
			id INT '$.id',
			num NVARCHAR(10) '$.num',
			name NVARCHAR(100) '$.name',
			img NVARCHAR(500) '$.img',
			height NVARCHAR(20) '$.height',
			weight NVARCHAR(20) '$.weight',
			weaknesses NVARCHAR(MAX) '$.weaknesses' AS JSON,
			prev_evolution NVARCHAR(MAX) '$.prev_evolution'  AS JSON,    
			next_evolution NVARCHAR(MAX) '$.next_evolution' AS JSON,  
			[type] NVARCHAR(MAX) '$.type' AS JSON
		) AS p
	OUTER APPLY 
		OPENJSON(p.next_evolution) WITH (
			num NVARCHAR(10) '$.num',
			name NVARCHAR(100) '$.name'
		) AS ne
	OUTER APPLY 
		OPENJSON(p.prev_evolution) WITH (
			num NVARCHAR(10) '$.num',
			name NVARCHAR(100) '$.name'
		) AS pe
	) AS F
WHERE f.ranke = 1) as a)

select * from tbl_pokemones

--5. (9 pts)
--	(2pt) a. Filtra cuales son las últimas evoluciones de los pokemos, revisa el nivel de jerarquia de la evolución

with jerarquia as (
	select id_pokemon,num_pokemon,nombre,evolucion,0 as nivel
	from tbl_pokemones
	where evolucion_previa is null
	union all 
	select 
		e.id_pokemon, e.num_pokemon,e.nombre,e.evolucion,j.nivel + 1
   from tbl_pokemones e
   inner join jerarquia j  on cast(left(e.evolucion_previa,3) AS INT) = j.id_pokemon)

select id_pokemon,nombre,nivel
from jerarquia
where evolucion is null
order by id_pokemon
go

--	(3pt) b. Cuantas evoluciones siguientes y previas tiene el pokemon (Usando funciones)

	--COMO DICE EL POKEMON, ASUMIMOS QUE SOLO SE DESEA VER PARA 1 POKEMON

create or alter function dbo.fn_tbl_ver_evol(
	@id_pokemon int
) returns table as return
select tbl_1.id_pokemon,tbl_1.nombre, tbl_1.evol_sigu, tbl_2.evol_prev
from 
(select a.id_pokemon,a.nombre,
	case
	when b.evolucion is null and a.evolucion is not null then 1
	when a.evolucion is null and b.evolucion is not null then 1
	when a.evolucion is null and b.evolucion is null then 0
	else 2
	end as evol_sigu
from tbl_pokemones as a
left join tbl_pokemones as b
on left(a.evolucion,3) like b.num_pokemon) as tbl_1
inner join 
(select a.id_pokemon,a.nombre,
	case
	when a.evolucion_previa is null and b.evolucion_previa is null then 0
	when a.evolucion_previa is not null and b.evolucion_previa is null then 1
	else 2
	end as evol_prev
from tbl_pokemones as a
left join tbl_pokemones as b
on left(a.evolucion_previa,3) like b.num_pokemon) as tbl_2
on tbl_1.id_pokemon = tbl_2.id_pokemon
where @id_pokemon = tbl_1.id_pokemon
go

select * from  dbo.fn_tbl_ver_evol(5)
go

--	(2pt) c. Evalua la cantidad de tipos con los cuales el pokemon tiene debilidad

SELECT 
    t.id_pokemon,
	t.nombre,
    count(r.type ) as cant_debilidades
FROM 
    tbl_pokemones t
CROSS APPLY 
    OPENJSON(t.debilidades) WITH (type NVARCHAR(MAX) '$') AS r
group by  t.id_pokemon,t.nombre
order by id_pokemon asc
go

--	(2pt) d. Muestrame el top 20 de los pokemones más altos, dado el tipo que le pasas en un SP (stored procedure)

create or alter proc sp_top_poke_altos(@tipo varchar(max))
as
begin
	select top 20 id_pokemon,nombre,tipo_pokemon,altura from tbl_pokemones
	where tipo_pokemon like '%'+@tipo+'%'
	order by altura desc
end
go

exec sp_top_poke_altos 'Water'
go