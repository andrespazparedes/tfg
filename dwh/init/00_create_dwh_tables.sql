-- Script de Creación de Tablas del DataMart (DDL) para PostgreSQL 16
-- Base de Datos: Warehouse (Analítica - TFG)
-- Esquema: dwh

-- Creación del Schema de Data Warehouse (dwh)
CREATE SCHEMA IF NOT EXISTS dwh;

-------------------------------------------------------------------------
-- 1. TABLAS DE DIMENSIONES (dwh.dim_*)
-------------------------------------------------------------------------

-- 1.1. DIMENSIÓN ESTUDIANTE (Aplanamiento de ESTUDIANTE y RESPONSABLE_LEGAL con SCD Tipo 2)
CREATE TABLE dwh.dim_estudiante (
    id_estudiante BIGSERIAL,
    num_expediente VARCHAR(15), -- Clave natural origen (EXP2015001...)
    dni VARCHAR(12),
    nombre VARCHAR(150),
    fecha_nacimiento DATE,
    email VARCHAR(100),
    calle_portal TEXT,
    puerta TEXT,
    cp INTEGER,
    ciudad TEXT,
    cod_responsable VARCHAR(15),
    nombre_responsable_1 VARCHAR(100),
    nombre_responsable_2 VARCHAR(100),
    telefono_responsable_1 VARCHAR(20),
    telefono_responsable_2 VARCHAR(20),
    email_responsable_1 VARCHAR(100),
    email_responsable_2 VARCHAR(100),
    monoparental BOOLEAN,
    version INTEGER,
    date_from TIMESTAMP,
    date_to TIMESTAMP
);
CREATE INDEX idx_dim_estudiante_lookup ON dwh.dim_estudiante(num_expediente);
CREATE INDEX idx_dim_estudiante_tk ON dwh.dim_estudiante(id_estudiante);

-- 1.2. DIMENSIÓN CENTRO (Aplanamiento e inyección geográfica de CENTRO)
CREATE TABLE dwh.dim_centro (
    id_centro BIGSERIAL,
    last_update TIMESTAMP,
    cod_centro VARCHAR(10),
    nombre VARCHAR(150),
    ciudad VARCHAR(100),
    cp INTEGER,
    direccion VARCHAR(150),
    email VARCHAR(100),
    telefono VARCHAR(20),
    tipo VARCHAR(50),
    naturaleza VARCHAR(50)
);
CREATE INDEX idx_dim_centro_lookup ON dwh.dim_centro(cod_centro);
CREATE INDEX idx_dim_centro_tk ON dwh.dim_centro(id_centro);

-- 1.3. DIMENSIÓN CURSO (Aplanamiento de CICLO_EDUCATIVO, ESPECIALIDAD y CURSO)
CREATE TABLE dwh.dim_curso (
    id_curso BIGSERIAL,
    last_update TIMESTAMP,
    num_curso SMALLINT,
    cod_especialidad VARCHAR(10),
    cod_ciclo VARCHAR(10),
    num_optativas SMALLINT,
    nombre_especialidad VARCHAR(150),
    nombre_ciclo VARCHAR(150),
    real_decreto VARCHAR(255),
    decreto_autonomico VARCHAR(255),
    edad_ideal DOUBLE PRECISION
);
CREATE INDEX idx_dim_curso_lookup ON dwh.dim_curso(num_curso, cod_especialidad);
CREATE INDEX idx_dim_curso_tk ON dwh.dim_curso(id_curso);

-- 1.4. DIMENSIÓN ASIGNATURA (Catálogo de materias independientes)
CREATE TABLE dwh.dim_asignatura (
    id_asignatura BIGSERIAL,
    last_update TIMESTAMP,
    cod_asignatura VARCHAR(15), -- Clave natural de asignatura
    nombre VARCHAR(150),
    tipo VARCHAR(30), -- 'Obligatoria', 'Optativa', 'Ámbito', 'Taller'
    num_horas SMALLINT,
    ciclo VARCHAR(50),
    especialidad VARCHAR(100), -- 'General', 'Diversificación', etc.
    num_curso SMALLINT -- Nivel en el que se imparte nativamente
);
CREATE INDEX idx_dim_asignatura_lookup ON dwh.dim_asignatura(cod_asignatura);
CREATE INDEX idx_dim_asignatura_tk ON dwh.dim_asignatura(id_asignatura);

-- 1.5. DIMENSIÓN TIEMPO Y EVALUACIONES
CREATE TABLE dwh.dim_tiempo (
    id_tiempo BIGSERIAL,
    curso_academico VARCHAR(9), -- '2024/2025', '2025/2026'
    evaluacion VARCHAR(50), -- '1ª Evaluación', 'Final Ordinaria', 'Final Extraordinaria'
    is_final BOOLEAN
);
CREATE INDEX idx_dim_tiempo_tk ON dwh.dim_tiempo(id_tiempo);
CREATE INDEX idx_dim_tiempo_lookup ON dwh.dim_tiempo(curso_academico, evaluacion);

-- 1.6. DIMENSIÓN DEMOGRAFÍA FAMILIAR (Optimización Kimball de baja cardinalidad)
-- Nota de Diseño (Tramos de Renta per unidad de consumo):
-- Los umbrales están basados en la metodología AROPE (Eurostat) y la Encuesta de Condiciones de Vida (INE).
-- - Muy Baja (0 - 7000€): < 40% mediana nacional. Riesgo de pobreza severa (EAPN).
-- - Baja (7000€ - 11000€): < 60% mediana nacional. Umbral general de riesgo de pobreza (INE).
-- - Media (11000€ - 25000€): Entre el 60% y ~150% de la mediana. Clase media estándar.
-- - Alta (> 25000€): > 150% de la mediana per cápita. Deciles de renta más altos (OCDE).
CREATE TABLE dwh.dim_demografia_familiar (
    id_demografia_familiar BIGSERIAL,
    max_nivel_estudios VARCHAR(23), -- PISA PARED standard
    internet BOOLEAN, -- Mide brecha de acceso
    disponibilidad_ordenadores VARCHAR(255), -- 'Ninguno', 'Menos de 1 por hijo', '1 o más por hijo'
    nivel_renta VARCHAR(50), -- 'Muy Baja', 'Baja', 'Media/Alta'
    riesgo_socioeconomico INT
);
CREATE INDEX idx_dim_demografia_familiar_tk ON dwh.dim_demografia_familiar(id_demografia_familiar);
CREATE INDEX idx_dim_demografia_familiar_lookup ON dwh.dim_demografia_familiar(internet, nivel_renta, disponibilidad_ordenadores, max_nivel_estudios, riesgo_socioeconomico);

-- 1.7. DIMENSIÓN APOYO Y ADAPTACIONES CURRICULARES (Aplanamiento por alumno-curso)
CREATE TABLE dwh.dim_adaptacion (
    id_adaptacion BIGSERIAL,
    tipo TEXT,
    is_discapacidad BOOLEAN,
    is_compensatoria BOOLEAN,
    riesgo_adaptacion DOUBLE PRECISION
);
CREATE INDEX idx_dim_adaptacion_tk ON dwh.dim_adaptacion(id_adaptacion);
CREATE INDEX idx_dim_adaptacion_lookup ON dwh.dim_adaptacion(tipo);



-------------------------------------------------------------------------
-- 2. TABLAS DE HECHOS (dwh.fact_*)
-------------------------------------------------------------------------

-- 2.1. HECHOS: CALIFICACIONES (Granularidad: Estudiante - Asignatura - Evaluación)
CREATE TABLE dwh.fact_calificaciones (
    id_estudiante BIGINT NOT NULL,
    id_centro BIGINT NOT NULL,
    id_curso BIGINT NOT NULL, 
    id_asignatura BIGINT NOT NULL, 
    id_tiempo BIGINT NOT NULL,
    id_demografia_familiar BIGINT NOT NULL,
    id_adaptacion BIGINT NOT NULL,
    nota DECIMAL(4, 2) NOT NULL,
    desfase_edad SMALLINT NOT NULL, 
    renta_unidades_consumo DOUBLE PRECISION,
    PRIMARY KEY (id_estudiante, id_asignatura, id_tiempo)
);

-- 2.2. HECHOS: RENDIMIENTO ANUAL (Granularidad: Estudiante - Curso Académico)
CREATE TABLE dwh.fact_rendimiento_anual (
    id_estudiante BIGINT NOT NULL,
    id_centro DOUBLE PRECISION NOT NULL,
    id_curso DOUBLE PRECISION NOT NULL, 
    id_tiempo DOUBLE PRECISION NOT NULL, 
    id_demografia_familiar DOUBLE PRECISION NOT NULL,
    id_adaptacion DOUBLE PRECISION NOT NULL,
    num_cursadas BIGINT NOT NULL,
    num_aprobadas DOUBLE PRECISION NOT NULL,
    num_suspensas DOUBLE PRECISION NOT NULL,
    tasa_aprobado DOUBLE PRECISION NOT NULL, 
    is_repetidor BOOLEAN NOT NULL DEFAULT FALSE,
    desfase_edad DOUBLE PRECISION NOT NULL,
    renta_unidades_consumo DOUBLE PRECISION,
    riesgo_academico DOUBLE PRECISION NOT NULL,
    riesgo_adaptacion DOUBLE PRECISION NOT NULL,
    riesgo_socioeconomico DOUBLE PRECISION NOT NULL,
    riesgo_abandono DOUBLE PRECISION NOT NULL,
    PRIMARY KEY (id_estudiante, id_tiempo)
);
