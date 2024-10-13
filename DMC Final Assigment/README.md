# SQL Final Assignment - PEA Data Engineer

In the final assignment of the SQL course within the PEA Data Engineer program, conducted by DMC, the following instructions were provided:

## Instructions

1. **Database Creation (0 pts)**: 
   - Create a database named "bd_evaluacion" using SQL.
   - Import the file used in previous sessions named "pea_privada" with the following command:
     ```sql
     BULK INSERT pea_privada
     FROM '<YOUR_PATH>\PEA-PRIVADA-2021-MUESTRA.csv'
     WITH (FORMAT = 'CSV', FIELDTERMINATOR = '|', FIRSTROW = 2);
     ```
---
2. **Job Creation (2 pts)**: 
   - Create a job called "jb_test" that performs the following steps:
     - If the second of the time (`getdate()`) matches the last digit of the "UUID" from the "pea_privada" table.
     - Return a table ordered by the lowercase "departamento" name, with the average "remuneracion" in the format "#,#.00".
     - Save this ordered table in the "LogQuery" table with the columns (id_trans, departamento, promedio_salario, fecha_hora_ejecucion).
     - This job should be executed every 3 minutes.
---
3. **Text Processing (1 pt)**: 
   - Perform text treatment on the columns `actividad_economica` and `departamento`, abbreviating names as necessary using an UPDATE statement.
---
4. **Dynamic SQL / PIVOT (2 or 3 pts)**: 
   - Using dynamic SQL (3 pts) or simple PIVOT (2 pts), create a query that generates average salaries by department and economic activity, where the economic activity is in the columns and the department is in the rows.
---
5. **Data Standardization (5 pts)**: 
   - Standardize the names from the provided JSON called "pokedex" and store them in a table called "tbl_pokemones" with the following mappings:
     - id: Identification Number → id_pokemon 
     - num: Number of the Pokémon in the official Pokédex → num_pokemon
     - name: Pokémon name → nombre
     - img: URL to an image of this Pokémon → url_imagen
     - type: Pokémon type → tipo_pokemon
     - height: Pokémon height → altura
     - weight: Pokémon weight → peso
     - weakness: Types of Pokémon this Pokémon is weak to → debilidades
     - next_evolution: Number and Name of successive evolutions of Pokémon → evolucion
     - prev_evolution: Number and Name of previous evolutions of Pokémon → evolucion_previa
---
6. **Evolution Analysis (9 pts)**:
   - (2 pts) a. Filter the latest evolutions of Pokémon, checking the evolution hierarchy level.
   - (3 pts) b. Count how many next and previous evolutions the Pokémon has (using functions).
   - (2 pts) c. Evaluate the number of types the Pokémon is weak against.
   - (2 pts) d. Show the top 20 tallest Pokémon of a given type through a stored procedure (SP).

   - **Example Read Command**:
     ```sql
     SELECT c.*
     FROM openrowset(bulk '<your_path>\pokedex.json', single_clob) AS j
     CROSS APPLY openjson(BulkColumn) AS r
     CROSS APPLY openjson(r.[value]) AS c
     ```
