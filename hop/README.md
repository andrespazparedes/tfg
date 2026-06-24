# DataMart ETL Project (Apache Hop)

Este directorio contiene el ecosistema completo de extracción, transformación y carga (ETL) desarrollado con **Apache Hop**. El proyecto se encarga de volcar la base de datos transaccional educativa en un Data Warehouse analítico multidimensional optimizado.

## Arquitectura de la Solución

El pipeline ETL está diseñado en dos capas principales:
1. **Staging Area (`raw`)**: Extracción pura sin transformaciones. Se clonan las tablas transaccionales a un esquema intermedio temporal libre de restricciones lógicas y claves foráneas, garantizando un volcado masivo ultrarrápido y sin bloqueos en producción.
2. **Data Warehouse (`dwh`)**: Transformación y consolidación de los datos en un modelo de estrella compuesto por Dimensiones y Tablas de Hechos.

### Capacidades CDC (Change Data Capture)

El ETL cuenta con una arquitectura dual capaz de soportar recargas históricas masivas y ejecuciones periódicas eficientes (por evaluación):
- **Carga Full:** Procesa la totalidad del histórico volcando todo en memoria RAM. Utilizado para inicializar el DataMart.
- **Carga Incremental:** Diseñada para las operaciones periódicas. Utiliza el parámetro `CURSO_ACTUAL` para leer exclusivamente el año lectivo en curso. Mediante componentes transaccionales (`Insert / Update`) e interrogaciones históricas (`Database Join`), recalcula los datos analíticos de todo el curso actual de manera aislada. Esto soluciona posibles rectificaciones de actas de evaluaciones previas dentro del mismo año, sin necesidad de destruir o recalcular el historial intacto de los años anteriores.

## Estructura de Directorios

El código de Apache Hop está organizado de manera modular:

*   `extract/`: Pipelines (`.hpl`) encargados del movimiento de datos hacia la Staging Area.
    *   Ejemplo: `extract_all_to_staging.hpl`
*   `transform/`: Pipelines (`.hpl`) que implementan la lógica de negocio para cargar Dimensiones y Hechos.
    *   `dim_*.hpl`: Carga de dimensiones estáticas y de Tipo 2 (SCD).
    *   `fact_calificaciones.hpl`: Hecho atómico a nivel de calificación.
    *   `fact_rendimiento_anual_full.hpl`: Agregación de riesgo predictivo (Carga histórica masiva).
    *   `fact_rendimiento_anual_incremental.hpl`: Agregación de riesgo predictivo adaptada (Modelo CDC Híbrido).
*   `orchestration/`: Workflows (`.hwf`) responsables del control de ejecución.
    *   `main.hwf`: Orquestador principal (Punto de entrada).
    *   `dimensions.hwf`: Sub-flujo de carga paralela de dimensiones.
    *   `facts.hwf`: Sub-flujo secuencial de hechos con enrutamiento inteligente.
*   `metadata/`: Configuraciones de entornos y conexiones a bases de datos relacionales.
*   `lib/`: Drivers JDBC y librerías externas.

## Ejecución y Parámetros

El proyecto está diseñado para orquestarse exclusivamente desde el flujo **`main.hwf`**, que maneja automáticamente las dependencias y la captura de errores multinivel jerárquica.

Para alterar el comportamiento matemático de los cálculos sin tocar código (evitando variables *hardcoded*), el ecosistema entero se apoya en el paso dinámico del parámetro global **`CURSO_ACTUAL`**.

### Flujo Top-Down del Parámetro:
1. Al lanzar el proyecto (vía CLI `hop-run` o Docker), se debe proveer el parámetro `CURSO_ACTUAL` (ej. `2023-2024`).
2. El `main.hwf` transfiere en cascada esta variable a los sub-workflows mediante la directiva *Pass parameter values to sub-workflow*.
3. El sub-flujo `facts.hwf` utiliza un nodo de evaluación lógica:
    - Si `CURSO_ACTUAL` está **vacío**, el sistema asume que es una recarga total y enruta la ejecución hacia la rama **Full**.
    - Si contiene un año, el sistema enruta la ejecución hacia la rama **Incremental**, inyectando dinámicamente la variable en las consultas SQL atómicas para conseguir la máxima eficiencia operativa.

## Instrucciones de Uso

Para ejecutar el ecosistema ETL de forma segura y mantener la integridad referencial, **solo debes ejecutar el orquestador principal**. Nunca ejecutes los pipelines (`.hpl`) de forma aislada en producción.

**Ruta del orquestador:** `hop/orchestration/main.hwf`

### Opción A: Ejecución mediante interfaz gráfica (Hop GUI)
1. Abre Apache Hop GUI y asegúrate de estar en el entorno de este proyecto.
2. Navega hasta la carpeta `orchestration` y abre el archivo `main.hwf`.
3. Haz clic en el icono de **Run** (Play) en la barra superior del workflow.
4. En la ventana modal de configuración, dirígete a la pestaña **Parameters**.
5. Configura el parámetro `CURSO_ACTUAL`:
   - Para una **Carga Inicial Completa (Full)**: Deja la columna *Value* completamente vacía.
   - Para una **Carga Periódica (Incremental)**: Introduce el año lectivo en la columna *Value* (por ejemplo, `2023-2024`).
6. Haz clic en **Launch**.

### Opción B: Ejecución mediante línea de comandos (CLI)
Para entornos de producción o tareas automatizadas (cron), utiliza el binario `hop-run` inyectando el parámetro directamente:

**Modo Incremental (Ejemplo):**
```bash
./hop-run.sh -j tu_nombre_proyecto -r local -f hop/orchestration/main.hwf -p CURSO_ACTUAL="2023-2024"
```

**Modo Full (Carga inicial masiva):**
```bash
./hop-run.sh -j tu_nombre_proyecto -r local -f hop/orchestration/main.hwf -p CURSO_ACTUAL=""
```

## Stack Tecnológico

- **Apache Hop**: Plataforma de orquestación de datos visual.
- **PostgreSQL**: Motor de base de datos relacional dual (fuente transaccional y destino analítico DWH).
