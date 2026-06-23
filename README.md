# 🎓 Datamart Educativo & Motor de Riesgo de Abandono Escolar

![Estado](https://img.shields.io/badge/Estado-En_Desarrollo-orange)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-blue?logo=postgresql)
![Apache Hop](https://img.shields.io/badge/ETL-Apache_Hop-red?logo=apache)
![FastAPI](https://img.shields.io/badge/Backend-FastAPI-009688?logo=fastapi)

Sistema de inteligencia de negocio (Business Intelligence) integral diseñado para el ámbito educativo. Su núcleo es un **Data Warehouse analítico** alimentado por un **ETL avanzado** que evalúa el rendimiento académico, factores demográficos y adaptaciones curriculares para predecir de forma temprana el **Riesgo de Abandono Escolar** de los estudiantes.

---

## 🏗 Arquitectura del Sistema

El proyecto sigue una arquitectura moderna dividida en 4 grandes capas (End-to-End):

### 1. Data Warehouse (PostgreSQL)
Implementa un diseño dimensional estelar basado en la metodología Kimball, optimizado estrictamente para consultas analíticas masivas de solo lectura (OLAP).
- **Esquema `dwh`**: Aislamiento analítico.
- **Tablas de Hechos (Facts)**:
  - `fact_calificaciones`: Rendimiento atómico a nivel Estudiante $\times$ Asignatura $\times$ Evaluación.
  - `fact_rendimiento_anual`: Motor predictivo y consolidador anual por Estudiante $\times$ Curso. Alberga los indicadores maestros (`riesgo_academico`, `riesgo_socioeconomico`, `riesgo_adaptacion` y `riesgo_abandono`).
- **Tablas de Dimensiones (Dims)**: `dim_estudiante` (SCD2), `dim_tiempo`, `dim_curso`, `dim_centro`, `dim_asignatura`, `dim_demografia_familiar` y `dim_adaptacion`.

### 2. Capa ETL (Apache Hop)
El cerebro matemático del sistema. Las tuberías (Pipelines) ingieren datos transaccionales crudos y los transforman:
- **Sumas Acumuladas (Window Functions)**: Rastrea el histórico de suspensos de un alumno desde su inicio en primaria.
- **Detección de Repetidores**: Uso de `Analytic Query` (LAG) para cruzar matrículas pasadas y determinar repeticiones por tramo educativo.
- **Scoring de Riesgo**: Algoritmos de cálculo de riesgo basados en ponderaciones matemáticas de factores socioeconómicos e historial de fracaso escolar.

### 3. Backend (FastAPI + SQLAlchemy 2.0)
Servidor de ultra-alto rendimiento en Python 3.12:
- **ORM Dual**: Emplea SQLAlchemy para rutear a dos esquemas. El esquema de analítica (`dwh`) está fuertemente bloqueado para **solo lectura**, garantizando la inmutabilidad de los datos calculados por el ETL.
- **Seguridad**: Gestión de configuración robusta vía Pydantic Settings.

### 4. Frontend (Dashboard Analítico)
Interfaz gráfica diseñada con las últimas tendencias de UI/UX para que el equipo directivo/orientadores del centro consuman las métricas. Proporciona vistas en detalle (Drill-down) desde la visión macro del centro hasta el riesgo individual de un estudiante.

---

## 🚀 Estructura del Repositorio

```text
/tfg
├── /api/                # Backend FastAPI (Controladores, Modelos, Cruds, Schemas)
├── /dwh/                # Scripts DDL de base de datos (Ej: 00_create_dwh_tables.sql)
├── /frontend/           # Dashboard Web (React/Vite)
├── /hop/                # Pipelines y Workflows de Apache Hop (.hpl, .hwf)
├── /source/             # Datos crudos de origen (CSVs, Excels)
├── docker-compose.yml   # Orquestación de infraestructura local (BDs)
└── README.md            # Este archivo
```

---

## 🛠 Instalación y Puesta en Marcha

### Prerrequisitos
- Docker y Docker Compose (Docker Desktop en Windows/Mac)
- Apache Hop (Cliente local opcional si deseas modificar los pipelines visualmente, aunque el contenedor de la interfaz web ya viene incluido).

### Despliegue Automatizado (One-Click)
La gran ventaja de este repositorio es que toda la infraestructura está completamente "dockerizada" e interconectada a través de una red virtual (`tfg-network`). 

Para levantar **el proyecto entero por completo** (Bases de Datos, ETL Web, Servidor Backend y Cliente Frontend), solo necesitas ejecutar en la raíz del proyecto:

```bash
docker-compose up -d --build
```

### ¿Qué ocurre al lanzar este comando?
1. **Bases de Datos (`postgres-source` y `postgres-dwh`)**: Se inicializan los motores de Postgres 16 y se ejecutan automáticamente los scripts DDL de creación de tablas (`/dwh/init/` y `/source/init/`).
2. **Apache Hop (`apachehop-web`)**: Se levanta un servidor de Apache Hop Web en el puerto `8080`, conectado directamente a la carpeta `/hop/` y a las bases de datos.
3. **Backend (`api`)**: Se construye la imagen de FastAPI, se instalan sus dependencias (vía `requirements.txt`) y arranca el servidor en el puerto `8000`. (Documentación interactiva disponible en `http://localhost:8000/docs`).
4. **Frontend (`frontend`)**: Se instala el entorno de Node.js, se bajan las dependencias de React/Vite y se expone la web app en el puerto `5173`.

### Siguiente paso: Ejecución del ETL
Una vez levantada toda la infraestructura, la base de datos `dwh` está creada pero vacía. Para poblarla:
1. Abre tu navegador y entra en `http://localhost:8080` (Interfaz de Apache Hop Web).
2. Abre el pipeline maestro (`/orchestration/main.hwf`).
3. Dale al botón de **Ejecutar (Run)** para extraer los datos crudos, realizar los cálculos predictivos e inyectarlos en el Data Warehouse.

---

## 📊 Metodología Analítica de Abandono

El **riesgo de abandono** (`riesgo_abandono`) no es un simple cálculo aleatorio. Es la sumatoria de tres sub-vectores de riesgo:
1. **Riesgo Académico**: Ponderación agresiva por suspensos históricos (con penalizaciones superiores si los suspensos ocurren en 1º y 2º de Primaria) y detección histórica de repeticiones de curso.
2. **Riesgo Socioeconómico**: Matriz de baja cardinalidad que cruza el Nivel de Renta de la unidad de consumo, la conectividad a Internet, la disponibilidad de ordenadores y el nivel de estudios máximo de los tutores legales.
3. **Riesgo por Adaptación**: Evaluación de la necesidad de apoyo curricular significativo o compensatoria.

---
*Proyecto finalizado desarrollado como Trabajo de Fin de Grado (TFG).*
