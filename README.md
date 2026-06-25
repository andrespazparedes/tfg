# 🎓 Sistema de Inteligencia Educativa para la Prevención del Abandono Escolar

![Estado](https://img.shields.io/badge/Estado-Finalizado-success)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-blue?logo=postgresql)
![Apache Hop](https://img.shields.io/badge/ETL-Apache_Hop-red?logo=apache)
![FastAPI](https://img.shields.io/badge/Backend-FastAPI-009688?logo=fastapi)
![React](https://img.shields.io/badge/Frontend-React-61DAFB?logo=react)

Sistema integral de **Business Intelligence Educativo** orientado a la detección temprana del riesgo de abandono escolar y al apoyo en la toma de decisiones por parte de las administraciones educativas.

La solución combina un **Data Warehouse analítico**, procesos **ETL desarrollados en Apache Hop**, una **API REST con FastAPI** y un **dashboard interactivo** que permite analizar tanto indicadores agregados a nivel de centro como factores de riesgo individuales de los estudiantes.

---

# 🚀 Características principales

* Modelo dimensional en estrella orientado al análisis educativo.
* Motor de cálculo de riesgo de abandono escolar.
* Procesos ETL automatizados mediante Apache Hop.
* API REST desarrollada con FastAPI y SQLAlchemy.
* Dashboard interactivo desarrollado con React.
* Sistema de autenticación basado en JWT.
* Gestión de usuarios con control de roles.
* Navegación Macro → Micro mediante drill-down.
* Arquitectura completamente dockerizada.

---

# 🏗 Arquitectura del sistema

La solución sigue una arquitectura de cuatro capas:

## 1. Data Warehouse (PostgreSQL)

Implementa un modelo dimensional basado en la metodología Kimball.

### Tablas de hechos

* `fact_calificaciones`

  * Rendimiento académico a nivel Estudiante × Asignatura × Evaluación.

* `fact_rendimiento_anual`

  * Consolidación anual por Estudiante × Curso.
  * Incluye los indicadores:

    * `riesgo_academico`
    * `riesgo_socioeconomico`
    * `riesgo_adaptacion`
    * `riesgo_abandono`

### Tablas de dimensiones

* `dim_estudiante` (SCD Tipo 2)
* `dim_tiempo`
* `dim_curso`
* `dim_centro`
* `dim_asignatura`
* `dim_demografia_familiar`
* `dim_adaptacion`

---

## 2. Procesos ETL (Apache Hop)

Los pipelines transforman los datos operacionales en información analítica mediante:

* Cálculo histórico de suspensos acumulados.
* Detección automática de repetidores.
* Consolidación de indicadores por curso académico.
* Cálculo de puntuaciones de riesgo.
* Cargas incrementales por año académico.

El workflow principal (`main.hwf`) orquesta la carga completa de dimensiones y tablas de hechos.

---

## 3. Backend (FastAPI)

API REST desarrollada con:

* Python 3.12
* FastAPI
* SQLAlchemy 2.0
* Pydantic Settings

Características:

* Autenticación JWT.
* Gestión de usuarios y roles.
* Acceso seguro al Data Warehouse.
* Endpoints para indicadores Macro y Micro.
* Configuración mediante variables de entorno.

---

## 4. Frontend (React)

Dashboard analítico diseñado para responsables educativos.

Incluye:

* Visualizaciones interactivas.
* Filtros globales.
* KPIs en tiempo real.
* Mapas geográficos.
* Drill-down desde centro educativo hasta alumno.
* Gestión de usuarios para administradores.

---

# 📦 Infraestructura Docker

El sistema se despliega mediante Docker Compose y está compuesto por seis contenedores:

1. PostgreSQL (Base de datos origen)
2. PostgreSQL (Data Warehouse)
3. Apache Hop Web
4. FastAPI
5. React Frontend
6. Nginx (Proxy inverso)

---

# 📁 Estructura del repositorio

```text
/tfg
├── api/                 # Backend FastAPI
├── dwh/                 # Scripts DDL y modelo dimensional
├── frontend/            # Aplicación React
├── hop/                 # Pipelines y workflows Apache Hop
├── source/              # Datos de origen
├── nginx/               # Configuración del proxy inverso
├── docker-compose.yml
├── .env.example
└── README.md
```

---

# 🛠 Instalación y despliegue

## Requisitos previos

* Docker
* Docker Compose

## Clonar el repositorio

```bash
git clone https://github.com/andrespazparedes/tfg.git
cd tfg
```

## Configuración

Crear un archivo `.env` a partir de:

```bash
cp .env.example .env
```

Configurar las credenciales y puertos necesarios.

---

## Levantar la infraestructura

```bash
docker-compose up -d --build
```

Este comando construye y levanta todos los servicios del sistema.

---

## Acceso a las aplicaciones

Una vez iniciado el despliegue:

| Servicio       | URL                       |
| -------------- | ------------------------- |
| Dashboard      | http://localhost          |
| Apache Hop Web | http://localhost:8080     |
| API REST       | http://localhost/api      |
| Swagger        | http://localhost/api/docs |

---

# 🔄 Carga de datos

El Data Warehouse se crea automáticamente pero inicialmente está vacío.

Para cargar la información:

1. Acceder a Apache Hop Web.
2. Abrir el proyecto ETL.
3. Ejecutar el workflow principal:

```text
main.hwf
```

Este workflow:

* Extrae los datos de la base operacional.
* Calcula los indicadores históricos.
* Evalúa los factores de riesgo.
* Carga las dimensiones.
* Actualiza las tablas de hechos.

En modo incremental, únicamente procesa el curso académico seleccionado, manteniendo el histórico acumulado.

---

# 📊 Metodología de cálculo del riesgo

La puntuación de abandono escolar se construye a partir de tres componentes:

## Riesgo académico

Considera:

* Suspensos acumulados.
* Repetición de curso.
* Penalización adicional en 1.º y 2.º de Primaria.

## Riesgo socioeconómico

Basado en:

* Nivel de renta familiar.
* Acceso a Internet.
* Disponibilidad de dispositivos.
* Nivel educativo familiar.

## Riesgo por adaptación

Evalúa:

* Adaptaciones curriculares.
* Necesidades específicas de apoyo educativo.

La combinación de estos factores genera el indicador final:

```text
riesgo_abandono
```

---

# 🖥 Uso del dashboard

## Autenticación

El acceso requiere:

* Correo electrónico
* Contraseña

La sesión se mantiene mediante tokens JWT.

---

## Filtros globales

Todas las visualizaciones comparten:

* Curso académico
* Tipo de centro
* Ciclo educativo
* Centros seleccionados

Los cambios se aplican automáticamente a toda la aplicación.

---

# 🌍 Vista Macro

Permite identificar centros prioritarios.

Incluye:

### KPIs principales

* Total de centros
* Centros críticos
* Riesgo medio

### Alertas institucionales

* Riesgo alto de abandono
* Suspensos
* Repetidores
* Brecha digital
* Riesgo socioeconómico
* Adaptaciones curriculares
* Otros indicadores críticos

### Mapa geográfico

Representación visual de centros según nivel de riesgo.

### Análisis agregado

* Evolución temporal del riesgo
* Comparativa por tipo de centro
* Matriz de asignación de recursos

### Ranking de centros

Ordenados según índice de riesgo.

---

# 🔍 Vista Micro

Permite analizar las causas del riesgo en un centro concreto.

Incluye:

### KPIs de alumnado

* Riesgo alto
* Suspensos
* Repetidores
* Brecha digital
* Adaptaciones curriculares
* Variaciones respecto al curso anterior

### Gráficos analíticos

* Evolución histórica
* Distribución de suspensos
* Distribución del riesgo
* Riesgo por ciclo educativo
* Distribución de renta
* Renta vs suspensos
* Brecha digital vs rendimiento
* Nivel educativo familiar

### Directorio de alumnos

Tabla con:

* Expediente
* Centro
* Ciclo
* Tasa de aprobado
* Puntuación de riesgo
* Alertas activas

---

# 👥 Gestión de usuarios

Disponible únicamente para administradores.

Permite:

* Crear usuarios
* Editar usuarios
* Eliminar usuarios
* Gestionar roles

La cuenta superadministradora está protegida para garantizar la existencia permanente de un usuario con privilegios totales.

---

# 🎯 Flujo de trabajo recomendado

1. Analizar la situación general desde la Vista Macro.
2. Identificar centros prioritarios mediante alertas y rankings.
3. Acceder a la Vista Micro mediante drill-down.
4. Diagnosticar las causas del riesgo.
5. Proponer medidas de intervención basadas en evidencias objetivas.

---

# 🔧 Personalización

Las reglas de negocio pueden modificarse mediante:

* Pipelines de Apache Hop.
* Código del backend.
* Configuración de umbrales e indicadores.

Tras cualquier modificación es suficiente con reconstruir los contenedores:

```bash
docker-compose up -d --build
```

---

# 📚 Trabajo Fin de Grado

Proyecto desarrollado como Trabajo de Fin de Grado (TFG) en Ingeniería Informática.

Su objetivo es proporcionar una herramienta de apoyo a la toma de decisiones para la prevención temprana del abandono escolar mediante técnicas de Business Intelligence, modelado dimensional y analítica educativa.
