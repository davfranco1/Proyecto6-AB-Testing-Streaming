

<div style="text-align: center;">
  <img src="https://github.com/Hack-io-Data/Imagenes/blob/main/01-LogosHackio/logo_naranja@4x.png?raw=true" alt="esquema" />
</div>

# Proyecto6-AB-Testing-Streaming

## Contexto

Nos ha contratado una popular plataforma de streaming que ofrece una amplia variedad de contenido, desde series y películas hasta documentales y programas en vivo. Esta plataforma cuenta con millones de usuarios alrededor del mundo, cada uno con distintos gustos y preferencias. Para maximizar la satisfacción del usuario y el tiempo que pasan en la plataforma, han implementado diversas funcionalidades a lo largo del tiempo, como listas de reproducción, recomendaciones basadas en historial de visualización y colecciones destacadas.

Ahora han incluido una nueva funcionalidad de recomendaciones personalizadas. La funcionalidad en prueba es una nueva sección, diseñada para mostrar a los usuarios contenido que probablemente les interese en función de sus hábitos de visualización, género preferido, y otros patrones de comportamiento. Este enfoque busca hacer más efectiva la experiencia de usuario, aumentando la probabilidad de que encuentren contenido de su interés rápidamente, lo cual, en teoría, debería incrementar el tiempo de visualización (tiempo de sesión) y el *engagement* general con la plataforma.

El tiempo de visualización y el *engagement* son métricas clave para la plataforma de streaming. Un mayor tiempo de visualización indica que los usuarios están más satisfechos con el contenido y que es probable que continúen usando la plataforma, renovando sus suscripciones o incluso subiendo de nivel en sus planes. El engagement, que incluye interacciones como los clics en recomendaciones y la frecuencia de sesiones, permite entender qué tan involucrados están los usuarios con la plataforma y si están encontrando contenido atractivo y relevante.


## Objetivo del Proyecto

Tu objetivo será evaluar si la nueva funcionalidad de recomendaciones personalizadas tiene un impacto significativo en el comportamiento de los usuarios, específicamente en términos de tiempo de visualización y *engagement*. Deberás analizar y comparar estas métricas entre el grupo de control (A), que no tiene acceso a la funcionalidad, y el grupo experimental (B), que sí la tiene.


Deberás calcular y comparar métricas clave entre ambos grupos para analizar el efecto de la nueva funcionalidad. Algunas de las métricas que puedes calcular son el promedio de tiempo por sesión, tasa de clics en recomendaciones, etc. (esto son solo recomendaciones, pero valoraremos positivamente que penséis en nuevas métricas)

Además, para confirmar que las diferencias observadas no son producto del azar, se llevará a cabo un análisis estadístico de A/B testing. Este paso es crucial para fundamentar una recomendación final sobre la implementación de la funcionalidad.

Por último, basándote en los resultados del análisis y del A/B test, deberás concluir si la funcionalidad de recomendaciones personalizadas genera un impacto positivo. Si se observan mejoras significativas en las métricas clave,podrás recomendar que esta funcionalidad se mantenga y se amplíe a todos los usuarios.


## Fases del Proyecto

1. Creación e Inserción de los Datos en la Base de Datos usando el código que os compartimos. 


2. La estructura de la Base de Datos es:

    - Tabla: users

        - id: Identificador único del usuario (clave primaria).

        - username: Nombre de usuario, único y requerido.

        - email: Correo electrónico del usuario, único y requerido.

        - password: Contraseña del usuario, almacenada como hash.

        - date_of_registration: Fecha de registro del usuario en la plataforma.

        - country: País de residencia del usuario.

        - preferences: Preferencias de género del usuario, opcional.

        - user_type: Tipo de usuario, puede ser 'consumidor', 'creador de contenido', 'moderador', o 'administrador'.

        - recommendation_system: Sistema de recomendación que impacta al usuario, 'Recomendeitor' o 'Recomendeitor_Plus'.

    - Tabla: content

        - id: Identificador único del contenido (clave primaria).

        - title: Título del contenido.

        - release_date: Fecha de lanzamiento del contenido.

        - duration: Duración del contenido en minutos.
        
        - content_type: Tipo de contenido, como 'películas', 'series', 'documentales', 'shorts', o 'transmisiones en vivo'.

        - rating: Calificación del contenido.

    - Tabla: genres

        - id: Identificador único del género (clave primaria).

        - name: Nombre del género.

    - Tabla: content_genres

        - content_id: Referencia al contenido (clave foránea).

        - genre_id: Referencia al género (clave foránea).

    - Tabla: views
        - id: Identificador único de la visualización (clave primaria).

        - user_id: Referencia al usuario que realizó la visualización (clave foránea).

        - content_id: Referencia al contenido visualizado (clave foránea).

        - view_date: Fecha de la visualización.

        - duration_viewed: Duración de la visualización en minutos.

        - recommendation_system: Sistema de recomendación que influyó en la visualización.

    - Tabla: recommendations
        - id: Identificador único de la recomendación (clave primaria).

        - user_id: Referencia al usuario que recibió la recomendación (clave foránea).

        - content_id: Referencia al contenido recomendado (clave foránea).

        - recommended_by: Sistema de recomendación que hizo la recomendación.

        - recommendation_date: Fecha de la recomendación.

    - Tabla: user_interactions

        - id: Identificador único de la interacción (clave primaria).

        - user_id: Referencia al usuario que realizó la interacción (clave foránea).

        - content_id: Referencia al contenido con el que se interactuó (clave foránea).

        - interaction_type: Tipo de interacción, como 'like', 'comment', 'share', o 'favorite'.

        - interaction_date: Fecha de la interacción.

    - Tabla: search_history

        - id: Identificador único del término de búsqueda (clave primaria).

        - user_id: Referencia al usuario que realizó la búsqueda (clave foránea).

        - search_term: Término de búsqueda utilizado.

        - search_date: Fecha de la búsqueda.

    - Tabla: favorites

        - user_id: Referencia al usuario que marcó el contenido como favorito (clave foránea).

        - content_id: Referencia al contenido marcado como favorito (clave foránea).

    - Tabla: comments

        - id: Identificador único del comentario (clave primaria).

        - user_id: Referencia al usuario que hizo el comentario (clave foránea).

        - content_id: Referencia al contenido comentado (clave foránea).

        - comment_text: Texto del comentario.

        - comment_date: Fecha del comentario.

    - Tabla: awards

        - id: Identificador único del premio (clave primaria).

        - content_id: Referencia al contenido que recibió el premio (clave foránea).

        - award_name: Nombre del premio.

        - award_date: Fecha en que se otorgó el premio.

    - Tabla: tags
    
        - id: Identificador único de la etiqueta (clave primaria).

        - name: Nombre de la etiqueta.

        - Tabla: content_tags. 

        - content_id: Referencia al contenido etiquetado (clave foránea).

        - tag_id: Referencia a la etiqueta (clave foránea).

3. Transformación de Datos (ETL)

    - Realizar las queries necesarias para hacer tu análisis. 

    - Debes revisar valores faltantes en session_duration y clicks_on_recommendations. Si faltan valores en estas columnas, elige una estrategia de imputación o descarta esas filas.

    - Asegúrate de que las columnas tengan el tipo de dato adecuado. 

    - Organiza los datos a nivel de usuario para que cada fila represente a un usuario en lugar de una sesión. 

    - Calcula métricas semanales o promedio para cada usuario, por ejemplo:

        - Promedio de session_duration por semana.

        - Promedio de clicks_on_recommendations por semana.
        
        - Frecuencia semanal (number_of_sessions_weekly).
        
        - Porcentaje de contenido completado (content_completed) como el total de contenidos completados dividido entre el total de sesiones.

4. Cálculo de Métricas Clave

    Para cada usuario en los grupos A y B, calcula las siguientes métricas y visualizalas usando Python:

    - Promedio de Tiempo de Sesión (avg_session_duration): Calcular la duración promedio de sesión por semana. Comparar el tiempo promedio entre los grupos A y B.

    - Tasa de Clics en Recomendaciones (click_rate): Calcular la tasa de clics como el total de clics en recomendaciones dividido entre el número de sesiones. Puedes comparar la tasa de clics entre los grupos para ver si la funcionalidad de recomendaciones personalizadas mejora esta métrica.

    - Frecuencia de Sesiones (weekly_frequency): Debes determinar si los usuarios del grupo B vuelven con mayor frecuencia a la plataforma.

    - Ratio de Contenido Completo (completion_rate): En este punto tienes que determinar si los usuarios que reciben recomendaciones personalizadas completan el contenido con más frecuencia.

4. Realización del A/B Testing

    Una vez que hayas calculado las métricas clave (tiempo promedio de sesión, tasa de clics en recomendaciones, frecuencia de sesiones y ratio de contenido completado) para cada usuario en ambos grupos, el siguiente paso es realizar un análisis A/B para evaluar si la nueva funcionalidad de recomendaciones personalizadas tuvo un impacto significativo en estas métricas.

    Tu tarea será decidir qué tipo de A/B testing realizar para cada métrica. Esto significa que debes considerar:

    - La naturaleza de cada métrica: ¿Es una métrica continua (como el tiempo de sesión promedio) o una métrica de conteo/proporción (como el ratio de contenido completado)?

    - ¿Las métricas presentan distribuciones normales? (Considera realizar un análisis exploratorio de las distribuciones).

    - El tipo de prueba estadística más adecuado para comparar los grupos A y B en función de la métrica.


    **Pasos a Seguir:**

    - Definir las hipótesis para cada métrica:

        - Hipótesis nula (H₀): No hay diferencia en la métrica entre los grupos A y B.

        - Hipótesis alternativa (H₁): Existe una diferencia significativa en la métrica entre los grupos A y B.

    - Seleccionar y justificar el test de A/B adecuado para cada métrica:

        - Tiempo de sesión promedio: ¿Qué prueba estadística usarías y por qué?

        - Tasa de clics en recomendaciones: ¿Cuál prueba consideras apropiada?

        - Frecuencia de sesiones: ¿Qué prueba emplearías y con qué justificación?

        - Ratio de contenido completado: ¿Qué método es adecuado para comparar estas proporciones entre los grupos?

    - Calcular el p-valor.

    - Interpretación de resultados: Redacta un breve análisis para cada métrica, indicando si la funcionalidad de recomendaciones personalizadas generó o no un impacto significativo en comparación con el grupo control.


5. Visualización y Conclusiones

    - Visualización de resultados: Utiliza gráficos para mostrar las diferencias entre los grupos. Puedes usar gráficos de barras o boxplots para cada métrica.


## Como Entregar el Proyecto

La entrega del proyecto se realizará a través de una **issue en GitHub**, trabajando en un repositorio propio en tu cuenta personal. Los pasos que deberás seguir para hacer la entrega del proyecto son:


- **Crear un nuevo repositorio en tu cuenta de GitHub:**

   - Crea un nuevo repositorio llamado `Proyecto6-NombreProyecto`. Este nombre es obligatorio, no podremos llamarlo de otra forma. 

   - Configuralo como público. 


- **Desarrolla el proyecto:**

   - Implementa el código de los juegos según las especificaciones y guías proporcionadas.

   - Recuerda hacer commits regulares mientras avanzas en el desarrollo:

     ```bash
     git add .
     git commit -m "Descripción del avance"
     git push
     ```


- **Crear una issue en el repositorio original del curso:**

   - Ve al repositorio original del curso y dirígete a la pestaña de **Issues**.

- **Abrir una nueva issue para tu entrega:**

   - Haz clic en **New Issue** y llena los siguientes campos:

     - **Título:** Usa el formato "Entrega Proyecto: ProyectoABTesting - [Tu Nombre]".

     - **Descripción:** En la descripción, incluye:

       - Una breve explicación de tu proyecto.

       - Instrucciones para ejecutar tu código (si aplica).

       - Un enlace a tu repositorio personal donde está alojado el proyecto.


## 🚀 Entrega del Proyecto 🚀

**Fecha y hora límite:**

🗓️ **Lunes a las 9:00 AM.**


**Nota importante:**

⚠️ **Todos los proyectos que sean entregados o modificados después de la hora límite (lunes a las 9:00 AM) se considerarán como no entregados.** Por favor, asegúrate de completar y enviar tu trabajo a tiempo para evitar problemas.


# 🎤 Presentación de Proyectos 🎤

El lunes tendremos las **presentaciones de los proyectos**. La dinámica será la siguiente:

- De forma **aleatoria**, seleccionaremos entre **3 y 5 alumnos** para presentar su proyecto.

- Cada alumno tendrá **5 minutos** para explicar su proyecto y hacer una demo en vivo. Durante este tiempo podrán mostrar cómo funciona su juego y resaltar las características principales.

**Detalles importantes:**

- Es importante que lleguéis puntuales, ya que comenzaremos las presentaciones de inmediato.

- Asegúrate de que tu código esté listo y funcional para la demo.

- Todos debemos estar preparados para presentar, ya que la selección será completamente aleatoria.
