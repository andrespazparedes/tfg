-- Script de Creación de Tablas Staging (RAW)
-- Esquema: raw
-- Estas tablas son clones exactos del origen (source), pero sin Foreign Keys 
-- para permitir volcados masivos en paralelo sin errores de integridad referencial.

CREATE SCHEMA IF NOT EXISTS raw;
CREATE TABLE raw.ciclo_educativo (
    cod_ciclo VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    real_decreto VARCHAR(255),
    decreto_autonomico VARCHAR(255)
);

CREATE TABLE raw.especialidad (
    cod_especialidad VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    cod_ciclo VARCHAR(10) NOT NULL
);

CREATE TABLE raw.curso (
    num_curso SMALLINT NOT NULL,
    cod_especialidad VARCHAR(10) NOT NULL,
    num_optativas SMALLINT NOT NULL DEFAULT 0,
    PRIMARY KEY (num_curso, cod_especialidad)
);

CREATE TABLE raw.asignatura (
    cod_asignatura VARCHAR(15) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    num_horas SMALLINT NOT NULL,
    num_curso SMALLINT NOT NULL,
    cod_especialidad VARCHAR(10) NOT NULL
);

CREATE TABLE raw.responsable_legal (
    cod_responsable VARCHAR(15) PRIMARY KEY,
    nombre_1 VARCHAR(100) NOT NULL,
    nombre_2 VARCHAR(100),
    telefono_1 VARCHAR(20) NOT NULL,
    telefono_2 VARCHAR(20),
    email_1 VARCHAR(100) NOT NULL,
    email_2 VARCHAR(100),
    direccion VARCHAR(255) NOT NULL,
    monoparental BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE raw.encuesta (
    cod_responsable VARCHAR(15) NOT NULL,
    fecha DATE NOT NULL,
    ingresos DECIMAL(10, 2) NOT NULL,
    internet BOOLEAN NOT NULL DEFAULT TRUE,
    nivel_estudios_1 VARCHAR(100) NOT NULL,
    nivel_estudios_2 VARCHAR(100),
    num_ordenadores SMALLINT NOT NULL DEFAULT 0,
    num_integrantes SMALLINT NOT NULL DEFAULT 1,
    PRIMARY KEY (cod_responsable, fecha)
);

CREATE TABLE raw.estudiante (
    num_expediente VARCHAR(15) PRIMARY KEY,
    dni VARCHAR(12) UNIQUE NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    email VARCHAR(100) UNIQUE,
    cod_responsable VARCHAR(15) NOT NULL
);

CREATE TABLE raw.adaptacion_curricular (
    cod_adaptacion VARCHAR(15) PRIMARY KEY,
    fecha DATE NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    informe TEXT NOT NULL,
    num_expediente VARCHAR(15) NOT NULL
);

CREATE TABLE raw.adaptacion_asignatura (
    cod_adaptacion VARCHAR(15) NOT NULL,
    cod_asignatura VARCHAR(15) NOT NULL,
    PRIMARY KEY (cod_adaptacion, cod_asignatura)
);

CREATE TABLE raw.centro (
    cod_centro VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    email VARCHAR(100),
    tipo VARCHAR(50),
    direccion VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    naturaleza VARCHAR(50)
);

CREATE TABLE raw.admision (
    num_expediente VARCHAR(15) NOT NULL,
    fecha DATE NOT NULL,
    num_curso SMALLINT NOT NULL,
    cod_especialidad VARCHAR(10) NOT NULL,
    cod_centro VARCHAR(10) NOT NULL,
    PRIMARY KEY (num_expediente, fecha)
);

CREATE TABLE raw.matricula (
    cod_matricula VARCHAR(15) PRIMARY KEY,
    fecha DATE NOT NULL,
    curso_academico VARCHAR(9) NOT NULL,
    num_expediente VARCHAR(15) NOT NULL,
    cod_centro VARCHAR(10) NOT NULL,
    num_curso SMALLINT NOT NULL,
    cod_especialidad VARCHAR(10) NOT NULL
);

CREATE TABLE raw.asignatura_matricula (
    cod_asignatura VARCHAR(15) NOT NULL,
    cod_matricula VARCHAR(15) NOT NULL,
    suspenso_curso_anterior BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (cod_asignatura, cod_matricula)
);

CREATE TABLE raw.linea_expediente (
    cod_asignatura VARCHAR(15) NOT NULL,
    cod_matricula VARCHAR(15) NOT NULL,
    evaluacion VARCHAR(50) NOT NULL,
    nota DECIMAL(4, 2),
    PRIMARY KEY (cod_asignatura, cod_matricula, evaluacion)
);
