<p align="center">
  <img src="assets/banner.png" alt="Descripción" width="1000">
</p>


# Proyecto de Detección de fake news (En construcción)
Este repositorio contiene mi Proyecto de final de master en analisis y ciencia de datos, enfocado en la **detección de fake news** mediante análisis de datos, SQL, Machine Learning, Deep Learning y visualización con Power BI.

---

## Estado del proyecto
Actualmente estoy subiendo y organizando las distintas fases del proyecto.  

Las fases previstas son:  
1. EDA (Exploratory Data Analysis)  
2. SQL (Consultas en MySQL)  
3. Machine Learning  
4. Deep Learning
5. Propuestas IA generativa  
6. Dashboard en Power BI

---

## Tecnologías principales
- **Python** (pandas,numpy, scikit-learn, TensorFlow/Keras, matplotlib, seaborn)  
- **SQL / MySQL**  
- **Power BI**  
- **Jupyter Notebook**  

---

## Estructura inicial del repositorio
```plaintext
Fake-news-detection/
│
├── data/                        # Archivos con los datos brutos (Json) y archivos generados (csv).
│
│
├── docs/                        # Documentación del proyecto: enunciado.
│      └── enunciado.md
│
│
├── 01_EDA/                      # Notebook con lectura de archivos json y analisis exploratorio de datos.
│
│
├── 02_SQL/                      # Archivos relacionados con la base de datos y las consultas en MySQL.
│      │                   
│      ├── 01.Integracion_SQL.ipynb   # Notebook de jupyter donde se realiza la migracion de los datos desde python a nuestra base de datos SQL.
│      ├── 02.Database_Dake_news.sql  # Script SQL para la creacion de la base de datos incluyendo sus tablas y las relaciones entre ellas.
│      ├── 03.Limpieza_datos.sql      # Script SQL para la limpieza y transformación de los datos dentro de la base de datos.
│      ├── 04.Queries.sql             # Script SQL que contiene las consultas realizadas a nuestra base de datos para extraer información relevante del proyecto.
│      └── 05.Esquema.mwb             # Archivo de MySQL que contiene el esquema relacional completo de la base de datos.
│
│
│
│
│   # En construcción...
│
│
│
├── 05_Popuestas_IA_generativa/  # Notebooks con soliciones de IA generativa aplicadas al proyecto.
│      │  
│      ├── Generacion_columna_tematica.ipynb     # Notebook en donde se clasifican las noticias por tematicas automaticamente.  
│      ├── Generacion_imagenes_noticias.ipynb    # Notebook en donde se Generan imagenes automaticas de las noticias.
│      ├── Generacion_imagenes_noticias_2.ipynb  # Notebook en donde se Generan imagenes automaticas de las noticias.
│      └── Generacion_resumen.ipynb              # Notebook en donde se Generan resumenes automaticos de las noticias.
│
└── README.md                    # Presentación y extructura del proyecto
