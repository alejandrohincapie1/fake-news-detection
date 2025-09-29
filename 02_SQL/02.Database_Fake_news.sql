CREATE DATABASE IF NOT EXISTS fake_news;
USE fake_news;


CREATE TABLE fake_news.fija_tipo(						### TABLA FIJA TIPO
codigo_tipo TINYINT PRIMARY KEY NOT NULL,
nombres_tipo VARCHAR(26));

CREATE TABLE fake_news.fija_pais(						### TABLA FIJA PAIS
codigo_pais TINYINT PRIMARY KEY NOT NULL,
nombres_pais VARCHAR(14));


CREATE TABLE fake_news.fija_autor(						### TABLA FIJA AUTOR
codigo_autor TINYINT PRIMARY KEY NOT NULL,
nombres_autor VARCHAR(15));


CREATE TABLE fake_news.fija_fuente(						### TABLA FIJA FUENTE
codigo_fuente TINYINT PRIMARY KEY NOT NULL,
nombres_fuente VARCHAR(50));

CREATE TABLE fake_news.texto(							### TABLA TEXT		
codigo_texto SMALLINT PRIMARY KEY NOT NULL,
texto MEDIUMTEXT);


CREATE TABLE fake_news.titulo(							### TABLA TITLE	
codigo_titulo SMALLINT PRIMARY KEY NOT NULL,
titulo VARCHAR(289));



CREATE TABLE fake_news.noticia(							### TABLA PRINCIPAL NOTICIA
t_id SMALLINT PRIMARY KEY NOT NULL,
fake BIT(1),
tipo TINYINT,
visitas MEDIUMINT,
compartir MEDIUMINT,
duracion SMALLINT,
favorito SMALLINT,
autor TINYINT, 
fuente TINYINT,                                    	
pais TINYINT,
texto SMALLINT,
titulo smallint,
fecha_tiempo TIMESTAMP,
fecha_compartir_tiempo TIMESTAMP,
CONSTRAINT fk_news_pais FOREIGN KEY (pais) REFERENCES fija_pais(codigo_pais),
CONSTRAINT fk_news_autor FOREIGN KEY (autor) REFERENCES fija_autor(codigo_autor),
CONSTRAINT fk_news_tipo FOREIGN KEY(tipo) REFERENCES fija_tipo(codigo_tipo),
CONSTRAINT fk_news_fuente FOREIGN KEY (fuente) REFERENCES fija_fuente(codigo_fuente),
CONSTRAINT fk_news_texto FOREIGN KEY (texto) REFERENCES texto(codigo_texto),
CONSTRAINT fk_news_titulo FOREIGN KEY (titulo) REFERENCES titulo(codigo_titulo)
);															



