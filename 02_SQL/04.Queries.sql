-- QUERIES

-- Calcular la longitud media de los textos.

SELECT 
AVG(char_length(texto))
FROM texto;


-- ¿Qué día del mes se han publicado más noticias, cuántas y de qué tipo son?

SELECT 
    DAY(n.fecha_tiempo) AS dia,
    ft.nombres_tipo,
    COUNT(n.t_id) AS conteo
FROM fake_news.noticia AS n
JOIN fija_tipo AS ft 
    ON n.tipo = ft.codigo_tipo
WHERE DAY(n.fecha_tiempo) = (
    SELECT DAY(fecha_tiempo)
    FROM fake_news.noticia
    GROUP BY DAY(fecha_tiempo)
    ORDER BY COUNT(t_id) DESC
    LIMIT 1
)
GROUP BY dia, ft.nombres_tipo
ORDER BY conteo DESC;


-- ¿Qué dias del mes se han compartido más noticias, cuántas y de qué tipo son?

(SELECT 
	COUNT(DAY(fecha_compartir_tiempo)) AS Nº_noticias_compartidas, 
	DAY(fecha_compartir_tiempo) AS Dia
FROM noticia
GROUP BY DAY(fecha_compartir_tiempo)
ORDER BY Nº_noticias_compartidas DESC
LIMIT 1);

SELECT 
	DAY(n.fecha_compartir_tiempo) AS Dia,
    ft.nombres_tipo AS Tipo,
    COUNT(*) AS Total
FROM noticia AS n
INNER JOIN fija_tipo AS ft 
    ON n.tipo = ft.codigo_tipo 
WHERE DAY(n.fecha_compartir_tiempo) = (
    SELECT DAY(fecha_compartir_tiempo)
    FROM noticia
    GROUP BY DAY(fecha_compartir_tiempo)
    ORDER BY COUNT(*) DESC
    LIMIT 1
)
GROUP BY Dia, Tipo
ORDER BY Total DESC;


-- ¿A qué hora del día se han compartido más noticias?

SELECT 
	HOUR(fecha_compartir_tiempo) AS Hora_compartir,
    COUNT(*) AS Nº_noticias_compartidas
FROM noticia
GROUP BY Hora_compartir
ORDER BY Nº_noticias_compartidas DESC
LIMIT 1;


-- ¿Cuántas noticias publicadas han sido fake news?

SELECT 
	COUNT(fake) AS Nº_noticias
FROM noticia AS n
INNER JOIN fija_fake AS ff
ON n.fake = ff.codigo_fake
WHERE ff.nombres_fake = 'FAKE';


-- ¿Qué tipo de noticia tiene mayor porcentaje de ser fake new? 

SELECT 
	nombres_tipo,	
	ROUND((SUM(CASE WHEN fake = 0 THEN 1 ELSE 0 END) * 100.0/ COUNT(*)), 2) AS porcentaje_fake_news
FROM noticia AS n
JOIN fija_tipo AS ft 
	ON n.tipo = ft.codigo_tipo
GROUP BY ft.nombres_tipo
ORDER BY porcentaje_fake_news DESC
LIMIT 1;


-- ¿Cuál es el porcentaje de compartición y publicación de las fake news frente al porcentaje de las noticias reales?

SELECT
    ROUND(SUM(CASE WHEN fake = 1 THEN compartir ELSE 0 END) * 100.0 / SUM(compartir), 2) AS porcentaje_compartir_real,
    ROUND(SUM(CASE WHEN fake = 0 THEN compartir ELSE 0 END) * 100.0 / SUM(compartir), 2) AS porcentaje_compartir_fake
FROM noticia;

SELECT
    ROUND(SUM(CASE WHEN fake = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS porcentaje_noticias_reales,
    ROUND(SUM(CASE WHEN fake = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS porcentaje_noticias_fake
FROM noticia;


-- ¿Qué porcentaje de visitas recibe una fake new frente a una noticia real?

SELECT 
	ROUND(sum(n.visitas) / (SELECT SUM(visitas) FROM noticia) * 100,2) AS porcentaje_visitas,
    ff.nombres_fake
FROM noticia n
INNER JOIN fija_fake ff
	ON fake = codigo_fake
GROUP BY 
	nombres_fake;


-- ¿Qué tipo de noticia recibe la mayor cantidad de visitas?

SELECT 
	ft.nombres_tipo, 
	SUM(n.visitas) AS Total_visitas
FROM noticia n
INNER JOIN fija_tipo ft
	ON n.tipo = ft.codigo_tipo
GROUP BY 
	ft.nombres_tipo
ORDER BY 
	Total_visitas DESC
LIMIT 1;


-- Las 5 noticias que han sido marcadas más veces como favoritas por los lectores, ¿de qué tipo son? ¿Son fake o son reales?

SELECT 
	n.t_id,
    n.favorito, 
    ft.nombres_tipo, 
    ff.nombres_fake
FROM noticia n
INNER JOIN fija_tipo ft
	ON n.tipo = ft.codigo_tipo
INNER JOIN fija_fake ff
	ON n.fake = ff.codigo_fake
ORDER BY 
	favorito DESC
LIMIT 5;


-- ¿Coinciden los identificadores de las 5 noticias marcadas más veces como favoritas con las 5 más compartidas?

WITH mas_compartidos AS (
	SELECT 
		t_id
	FROM noticia
	ORDER BY  compartir DESC
	LIMIT 5
),
mas_favoritos AS (
	SELECT 
		t_id
	FROM noticia
	ORDER BY  favorito DESC
	LIMIT 5
)
SELECT
	mc.t_id AS id_compartidos,
    mf.t_id AS id_favoritos,
    CASE
		WHEN mc.t_id = mf.t_id THEN 'COINCIDE'
        ELSE 'NO COINCIDE'
	END AS comparacion
FROM mas_compartidos mc
LEFT JOIN mas_favoritos mf
	ON mc.t_id = mf.t_id
    
UNION

SELECT
	mc.t_id AS id_compartidos,
    mf.t_id AS id_favoritos,
    CASE
		WHEN mc.t_id = mf.t_id THEN 'COINCIDE'
        ELSE 'NO COINCIDE'
	END AS comparacion
FROM mas_compartidos mc
RIGHT JOIN mas_favoritos mf
	ON mc.t_id = mf.t_id;


-- ¿Qué países publican la mayor cantidad de fake news? ¿Y la menor?

SELECT 
	fp.nombres_pais,
	COUNT(*) AS numero_noticias
FROM noticia n 
INNER JOIN fija_pais fp
	ON n.pais = fp.codigo_pais
INNER JOIN fija_fake ff
	ON n.fake = ff.codigo_fake
WHERE ff.nombres_fake  = 'FAKE'
GROUP BY fp.nombres_pais
ORDER BY numero_noticias DESC
LIMIT 3;

SELECT 
	fp.nombres_pais,
	COUNT(*) AS numero_noticias
FROM noticia n 
INNER JOIN fija_pais fp
	ON n.pais = fp.codigo_pais
INNER JOIN fija_fake ff
	ON n.fake = ff.codigo_fake
WHERE ff.nombres_fake  = 'FAKE'
GROUP BY fp.nombres_pais
ORDER BY numero_noticias ASC
LIMIT 3;


-- Las 5 noticias que más tardan en leer los lectores, ¿son fake o son reales? ¿De qué tipo son? ¿Sobrepasan la media de longitud?

SELECT 
	n.duracion, 
    ff.nombres_fake AS 'FAKE', 
    ft.nombres_tipo AS 'Tipo noticia',
    CHAR_LENGTH(texto) AS 'Numero caracteres',
    CASE 
		WHEN CHAR_LENGTH(texto) > (SELECT SUM(CHAR_LENGTH(texto)) / COUNT(*) FROM texto) THEN 'SUPERIOR MEDIA'
		ELSE 'NO SUPERIOR MEDIA'
	END AS Media_caracteres
FROM noticia n
INNER JOIN fija_fake ff
	ON n.fake = ff.codigo_fake
INNER JOIN fija_tipo ft
	ON n.tipo = ft.codigo_tipo
INNER JOIN texto t
	ON n.t_id = t.codigo_texto
ORDER BY n.duracion DESC
LIMIT 5;


-- ¿Coinciden los identificadores de las 5 noticias que más tardan en leer los lectores con las 5 más visitadas?

WITH mas_duracion AS (
	SELECT 
		t_id,
		duracion
	FROM noticia 
	ORDER BY duracion DESC
	LIMIT 5
),
mas_visitadas AS (
	SELECT t_id, visitas
    FROM noticia
    ORDER BY visitas DESC
    LIMIT 5
)
SELECT 
	d.t_id AS id_duracion,
    v.t_id AS id_visitadas,
    CASE
		WHEN d.t_id = v.t_id THEN 'COINCIDE'
        ELSE 'NO COINCIDE'
        END AS Comparacion
FROM mas_duracion d
LEFT JOIN mas_visitadas v
	ON d.t_id = v.t_id
UNION
SELECT 
	d.t_id AS id_duracion,
    v.t_id AS id_visitadas,
    CASE
		WHEN d.t_id = v.t_id THEN 'COINCIDE'
        ELSE 'NO COINCIDE'
        END AS Comparacion
FROM mas_duracion d
RIGHT JOIN mas_visitadas v
	ON d.t_id = v.t_id;
 
 
-- ¿Quién es el autor que más aparece en las fake news?

SELECT 
	fa.nombres_autor, 
    COUNT(*) AS Nº_noticias
FROM noticia n
INNER JOIN fija_autor fa
	ON n.autor = fa.codigo_autor
INNER JOIN fija_fake ff
	ON n.fake = ff.codigo_fake
WHERE ff.nombres_fake = 'FAKE'
GROUP BY fa.nombres_autor
ORDER BY Nº_noticias DESC
LIMIT 1;


-- ¿Qué fuente es la que más publica fake news?

SELECT 
	f.nombres_fuente,
    COUNT(*) AS Nº_noticias_publicadas
FROM noticia n
INNER JOIN fija_fuente f
	ON n.fuente = f.codigo_fuente
INNER JOIN fija_fake ff
	ON n.fake = ff.codigo_fake
WHERE ff.nombres_fake = 'FAKE'
GROUP BY f.nombres_fuente
HAVING COUNT(*) = (
	SELECT MAX(subconsulta.conteo)
    FROM(
		SELECT COUNT(*) AS conteo
		FROM noticia n
		INNER JOIN fija_fuente f
		ON n.fuente = f.codigo_fuente
		INNER JOIN fija_fake ff
		ON n.fake = ff.codigo_fake
		WHERE ff.nombres_fake = 'FAKE'
		GROUP BY f.nombres_fuente) AS subconsulta
);


-- ¿Qué fuente es la que posee la mayor cantidad de noticias más compartidas?

SELECT 
	ff.nombres_fuente,
    SUM(compartir) AS Total_compartidos
FROM noticia n
INNER JOIN fija_fuente ff
	ON n.fuente = ff.codigo_fuente
GROUP BY ff.nombres_fuente
ORDER BY Total_compartidos DESC
LIMIT 1;


-- ¿Qué autor es el que recibe el mayor número de visitas y compartición en sus noticias?

SELECT 
	fa.nombres_autor,
    SUM(visitas) AS Total_visitas
FROM noticia n
INNER JOIN fija_autor fa
	ON n.autor = fa.codigo_autor
GROUP BY fa.nombres_autor
ORDER BY Total_visitas DESC
LIMIT 1;

SELECT 
	fa.nombres_autor,
    SUM(compartir) AS Total_compartidos
FROM noticia n
INNER JOIN fija_autor fa
	ON n.autor = fa.codigo_autor
GROUP BY fa.nombres_autor
ORDER BY Total_compartidos DESC
LIMIT 1;


-- Para cada texto, calcular la relación entre la longitud del título y la longitud del texto.

SELECT
	n.t_id AS ID,
	char_length(tt.titulo) As Longitud_titulo,
	char_length(t.texto) AS Longitud_texto,
    ROUND(char_length(tt.titulo)/char_length(t.texto),2) as Relacion_titulo_texto
FROM texto t
INNER JOIN noticia n
	ON n.t_id = t.codigo_texto
INNER JOIN titulo tt
	ON n.t_id = tt.codigo_titulo
ORDER BY Relacion_titulo_texto DESC;