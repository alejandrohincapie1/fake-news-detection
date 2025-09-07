# Proyecto – Detección de Fake News  
Máster en Data Analytics & Science  

## Contexto  
La empresa **Pontiapp**, dedicada a mensajería instantánea, necesita un sistema para detectar *fake news*.  
Cada minuto se comparten millones de artículos, pero carecen de herramientas para:  
- Identificar noticias falsas.  
- Gestionar y almacenar datos de manera adecuada.  
- Extraer métricas y KPIs que apoyen la toma de decisiones.  

El proyecto busca cubrir todo el ciclo: **almacenamiento → procesamiento → análisis → visualización**.

---

## Objetivos  
1. **Modelo de datos relacional**:  
   - Diseñar un esquema SQL que permita almacenar, consultar y auditar las noticias.  
   - Calcular métricas y responder preguntas de negocio.  

2. **Identificación de errores e incidencias**:  
   - Detectar datos erróneos, nulos, duplicados y aplicar reglas de negocio.  

3. **Detección automática de fake news**:  
   - Conectar Python con la BBDD.  
   - Realizar EDA, limpieza, técnicas de NLP (TF-IDF, etc.).  
   - Entrenar modelos de Machine Learning y Deep Learning.  
   - Comparar resultados y generar predicciones para noticias no etiquetadas.  

4. **Propuesta de IA Generativa**:  
   - Definir casos de uso para optimizar procesos de Pontiapp.  
   - Proponer una arquitectura técnica y justificar su impacto.  

5. **Presentación de resultados**:  
   - Dashboard en Power BI con KPIs clave.  
   - Informe ejecutivo con resumen de equipo, objetivos, modelo relacional, limpieza, metodología ML y comparación de modelos.  

---

## Tecnologías utilizadas  
- **SQL / MySQL** → modelado relacional, limpieza y consultas.  
- **Python (Pandas, Numpy, Matplotlib, Scikit-learn, TensorFlow, Keras)** → análisis, ML y DL.  
- **Power BI** → visualización de resultados y KPIs.  

---

## Dataset  
Los datos provienen de **archivos JSON** extraídos en septiembre de 2022. Cada artículo contiene:  

- ***t_id:*** identificador único de la noticia.
  
- ***tiempo:*** unidad de tiempo (número entero) que representa el momento en que se publica
   el artículo periodístico contando el número de horas que han pasado desde las 07:00 del
   1 de septiembre de 2022. Por ejemplo, si este campo indica un 8 significa que la noticia
   se publicó a las 15:00 (07:00 más 8 horas) del 1 de septiembre; mientras que si indica
   un 25 significa que se publicó a las 08:00 del 2 de septiembre de 2022 (25 horas después
   del momento de referencia).
- ***titulo:*** título con el que se identifica la noticia.
- ***texto:*** texto íntegro de la noticia.
- ***fake:*** naturaleza de la noticia clasificada como: fake new (FAKE) o noticia veraz
(REAL).
- ***autor:*** autor que redacte la noticia.
- ***fuente:*** periódico o página web que publique el artículo bajo su firma.
- ***tipo:*** tipo de noticia (columna, carta al editor, artículo de opinión, ...).
- ***visitas:*** número de visualizaciones que ha recibido la noticia.
- ***compartir:*** número de veces que se ha compartido el enlace de la noticia en redes
sociales.
- ***compartir_tiempo:*** al igual que en el campo de tiempo, unidad de tiempo (número
entero) que representa el momento en el que se comparte el artículo periodístico.
- ***duracion:*** tiempo de lectura del usuario.
- ***favorito:*** número de veces que un usuario ha marcado el artículo como favorito.
- ***pais:*** país donde se publica la noticia.
- ***idioma:*** idioma en el que se redacta la noticia.  


-----------------------
