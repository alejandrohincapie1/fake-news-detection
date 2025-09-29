-- lIMPIEZA DE DATOS

USE fake_news;

/* ---------------------------------------------------------------------------------------------------------------------------------------------------------------
 1. AUTOR: En el EDA inicial detectamos que el campo autor contenía datos nulos, datos con valor -1 y datos vacios. Durante la creación de nuestras tablas SQL los campos vacíos han pasado a ser valores 'Nan'.
		  Sabiendo esto vamos a reemplazar los valores 'NaN' y valores '-1' por el valor 'Desconocido'. */


SELECT COUNT(*) AS Nº_valores # Comprobamos el nuemro de datos 'NaN' y '-1'.   
FROM noticia	
WHERE autor IN (
	SELECT codigo_autor 
    FROM fija_autor
    WHERE nombres_autor IN ('NaN' ,-1));

# Ahora sustituimos los 919 valores por 'Desconocido'

UPDATE noticia  # Cambiamos de nuestra tabla noticias el campo autor con valor -1 (NaN) para asignarle valor 0.
SET autor = 0
WHERE autor = -1;

UPDATE fija_autor # Ahora cambiamos en nuestra tabla fija_autor el codigo_autor = 0. Ahora el codigo_autor = 0 corresponde al nombre del autor 'Desconocido'.
SET nombres_autor = 'Desconocido'
WHERE codigo_autor = 0;

DELETE FROM fija_autor  # Eliminamos de la tabla fija_autor, la fila codigo_autor = -1, ya que ya no hay valores 'Nan'.
WHERE codigo_autor = -1;


/* --------------------------------------------------------------------------------------------------------------------------------------------------------------- 
2. TIPO: En el EDA inicial detectamos que el campo tipo contenía datos 'NaN'. Sabiendo esto vamos a reemplazar los valores 'NaN' por el valor 'Desconocido'. */
          
# Comprobamos el nuemro de datos 'NaN'. 

SELECT COUNT(*) AS Nº_valores_NaN   
FROM noticia	
WHERE tipo IN (
	SELECT codigo_tipo 
    FROM fija_tipo
    WHERE nombres_tipo = 'NaN');

# Ahora sustituimos los 306 valores por 'Desconocido'

UPDATE fija_tipo # Ahora cambiamos en nuestra tabla fija_autor el codigo_autor = 0. Ahora el codigo_autor = 0 corresponde al nombre del autor 'Desconocido'.
SET nombres_tipo = 'Desconocido'
WHERE codigo_tipo = -1;


/* --------------------------------------------------------------------------------------------------------------------------------------------------------------- 
3. VISITAS : En el EDA inicial detectamos que el campo visitas contenía datos Nulos. En este caso vamos a sustituir los valores nulos por la  media. 
			 Tambien descubrimos que habian 1 registro con valor decirmal (3.1) y 10 registros con valores negativos. Los sustituiremos todos por la media de los datos.*/
             
## TRATAMIENTO VALORES NULOS
SELECT COUNT(*) AS Nº_valores_Nulos  # Comprobamos el numero de valores nulos
FROM noticia	
WHERE visitas IS NULL;
   
SET @mediaVisitas = (SELECT AVG(visitas) # Creamos una variable con la media de visitas.
					 FROM noticia 
                     WHERE visitas IS NOT NULL);   
                     
SET SQL_SAFE_UPDATES = 0; # Desactivo el safe update mode

UPDATE noticia
SET visitas = @mediaVisitas
WHERE visitas IS NULL;

SET SQL_SAFE_UPDATES = 1; # Activo el safe update mode


##TRATAMIENTO VALORES DECIMALES: al crear nuestra tablas, asignamos un tipo de dato al campo visitas que no contemplaba los decimales por los cual el valor 3.1 ha sido redondeado a 3.
SELECT COUNT(*) AS Nº_valores_Decimales  # Comprobamos el numero de valores decimales
FROM noticia	
WHERE visitas = 3;

SET SQL_SAFE_UPDATES = 0; # Desactivo el safe update mode

UPDATE noticia
SET visitas = @mediaVisitas
WHERE visitas = 3;

SET SQL_SAFE_UPDATES = 1; # Activo el safe update mode

## TRATAMIENTO VALORES NEGATIVOS.
SELECT COUNT(*) AS Nº_valores_Decimales  # Comprobamos el numero de valores negativos.
FROM noticia	
WHERE visitas < 0;

SET SQL_SAFE_UPDATES = 0; # Desactivo el safe update mode

UPDATE noticia
SET visitas = @mediaVisitas
WHERE visitas < 0;

SET SQL_SAFE_UPDATES = 1; # Activo el safe update mode


/* --------------------------------------------------------------------------------------------------------------------------------------------------------------- 
4. COMPARTIR : En el EDA inicial detectamos que el campo compartir contenía datos Nulos. En este caso vamos a sustituir los valores nulos por la  media. 
			   Tambien descubrimos que hay 12 registros con valores decimales 72.5 y 10 valores negativos (-10)*/

## TRATAMIENTO VALORES NULOS
SELECT COUNT(*) AS Nº_nulos_compartir  # Comprobamos el numero de valores nulos
FROM noticia
WHERE compartir IS NULL;

SET @mediaCompartir = (SELECT AVG(compartir) # Creamos una variable con la media de compartir.
					 FROM noticia 
                     WHERE compartir IS NOT NULL);

SET SQL_SAFE_UPDATES = 0; # Desactivo el safe update mode

UPDATE noticia
SET compartir = @mediaCompartir
WHERE compartir IS NULL;

SET SQL_SAFE_UPDATES = 1; # Activo el safe update mode


## TRATAMIENTO VALORES DECIMALES: al crear nuestra tablas, asignamos un tipo de dato al campo compartir que no contemplaba los decimales por los cual el valor 72.5 ha sido redondeado a 73.
SELECT COUNT(*) AS Nº_nulos_compartir  # Comprobamos el numero de valores decimales
FROM noticia
WHERE compartir = 73;

SET SQL_SAFE_UPDATES = 0; # Desactivo el safe update mode

UPDATE noticia
SET compartir = @mediaCompartir
WHERE compartir = 73;

SET SQL_SAFE_UPDATES = 1; # Activo el safe update mode


## TRATAMIENTO VALORES NEGATIVOS
SELECT COUNT(*) AS Nº_negativos_compartir  # Comprobamos el numero de valores decimales
FROM noticia
WHERE compartir < 0;

SET SQL_SAFE_UPDATES = 0; # Desactivo el safe update mode

UPDATE noticia
SET compartir = @mediaCompartir
WHERE compartir < 0;

SET SQL_SAFE_UPDATES = 1; # Activo el safe update mode



/* --------------------------------------------------------------------------------------------------------------------------------------------------------------- 
5. FAVORITO : En el EDA inicial detectamos que el campo favorito contenía 234 datos Nulos. En este caso vamos a sustituir los valores nulos por la  media. 
			  Tambien descubrimos que habian 126 valores decimales, lo cual no tenia sendito en este campo, asi que los sustituiremos por la media.*/
    
    
## TRATAMIENTO DE NULOS.
SELECT COUNT(*) AS Nº_nulos_favoritos # Comprobamos el numero de datos nulos.
FROM noticia
WHERE favorito IS NULL;

SET @mediaFavorito = (SELECT AVG(favorito) # Creamos una variable con la media de favorito.
					 FROM noticia 
                     WHERE favorito IS NOT NULL);

SET SQL_SAFE_UPDATES = 0; # Desactivo el safe update mode

UPDATE noticia
SET favorito = @mediaFavorito
WHERE favorito IS NULL;

SET SQL_SAFE_UPDATES = 1; # Activo el safe update mode


## TRATAMIENTO DE VALORES DECIMALES: Al crear nuestras tablas, asignamos un tipo de dato al campo favorito que no contemplaba los decimales por los cual el valor 0.73 ha sido redondeado a 1.
SELECT COUNT(*) AS Nº_valores_decimales # Comprobamos el numero de datos decimales.
FROM noticia
WHERE favorito = 1 AND t_id != 305; # todos los valores 1 eran valores 0.73 menos el valor con el t_id 305  que originalmente ya era un 1. visto en EDA.

SET SQL_SAFE_UPDATES = 0; # Desactivo el safe update mode

UPDATE noticia
SET favorito = @mediaFavorito
WHERE favorito = 1 AND t_id != 305;

SET SQL_SAFE_UPDATES = 1; # Activo el safe update mode


/* --------------------------------------------------------------------------------------------------------------------------------------------------------------- 
6. DURACION : En el EDA inicial detectamos que el campo duracion contenía 693 datos negativos. En este caso vamos a sustituir los valores negativos por la  media. */

SELECT COUNT(*) AS Nº_nulos_favoritos # Comprobamos el numero de datos negativos.
FROM noticia
WHERE duracion < 0;

SET @mediaDuracion = (SELECT AVG(duracion) # Creamos una variable con la media de duracion.
					 FROM noticia 
                     WHERE duracion IS NOT NULL);
                     
SET SQL_SAFE_UPDATES = 0; # Desactivo el safe update mode

UPDATE noticia
SET duracion = @mediaDuracion
WHERE duracion < 0;

SET SQL_SAFE_UPDATES = 1; # Activo el safe update mode
                     
                     
/* --------------------------------------------------------------------------------------------------------------------------------------------------------------- 
7. TITULO : En el EDA inicial detectamos que el campo titulo contenía un valor con el simbolo ':' unicamente, asi que, vamos a sustituirlo por 'No registra'. */

SELECT * # Comprobamos el registro con el valor ':'
FROM titulo
WHERE titulo = ':';

SET SQL_SAFE_UPDATES = 0; # Desactivo el safe update mode

UPDATE titulo   # Sustituimos el valor ':' por 'No registra'
SET titulo = 'No registra'
WHERE titulo = ':';

SET SQL_SAFE_UPDATES = 1; # Activo el safe update mode


/* --------------------------------------------------------------------------------------------------------------------------------------------------------------- 
8. TEXTO : En el EDA inicial detectamos que el campo texto contenía 36 registros con el ' ', asi que, vamos a sustituirlo por 'No registra'. */

SELECT COUNT(*) AS Nº_valores_vacios # Comprobamos los registros con el
FROM texto
WHERE texto = ' '
ORDER BY codigo_texto ASC;

SET SQL_SAFE_UPDATES = 0; # Desactivo el safe update mode

UPDATE texto   # Sustituimos el valor ':' por 'No registra'
SET texto = 'No registra'
WHERE texto = ' ';

SET SQL_SAFE_UPDATES = 1; # Activo el safe update mode