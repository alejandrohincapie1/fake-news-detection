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
- **Python (Scikit-learn, TensorFlow, Keras)** → análisis, ML y DL.  
- **Power BI / Tableau** → visualización de resultados y KPIs.  

---

## Dataset  
Los datos provienen de **archivos JSON** extraídos en septiembre de 2022. Cada artículo contiene:  

- `t_id` → identificador único  
- `titulo`, `texto`, `autor`, `fuente`  
- `fake` → etiqueta (FAKE / REAL)  
- `tipo` → tipo de noticia  
- `visitas`, `compartir`, `favorito`  
- `tiempo`, `compartir_tiempo`, `duracion`  
- `pais`, `idioma`  

---

## 📈 KPIs y preguntas de negocio (ejemplos)  
- ¿Qué día se publicaron más noticias y de qué tipo?  
- ¿Qué porcentaje de noticias compartidas son fake vs reales?  
- ¿Qué fuentes y autores publican más fake news?  
- Relación entre la longitud de título y texto.  
- Países e idiomas con mayor incidencia de fake news.  
- Noticias más visitadas, compartidas y favoritas.  

-----------------------
