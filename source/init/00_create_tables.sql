-- Script de Creación de Tablas (DDL) para PostgreSQL 16
-- Base de Datos: Source (Simulación Origen - TFG)

-- Habilitar extensión para limpiar/reiniciar si fuera necesario en el entorno de desarrollo
-- DROP TABLE IF EXISTS LINEA_EXPEDIENTE CASCADE;
-- DROP TABLE IF EXISTS ASIGNATURA_MATRICULA CASCADE;
-- DROP TABLE IF EXISTS MATRICULA CASCADE;
-- DROP TABLE IF EXISTS ADMISION CASCADE;
-- DROP TABLE IF EXISTS CENTRO CASCADE;
-- DROP TABLE IF EXISTS ADAPTACION_ASIGNATURA CASCADE;
-- DROP TABLE IF EXISTS ADAPTACION_CURRICULAR CASCADE;
-- DROP TABLE IF EXISTS ESTUDIANTE CASCADE;
-- DROP TABLE IF EXISTS ENCUESTA CASCADE;
-- DROP TABLE IF EXISTS RESPONSABLE_LEGAL CASCADE;
-- DROP TABLE IF EXISTS ASIGNATURA CASCADE;
-- DROP TABLE IF EXISTS CURSO CASCADE;
-- DROP TABLE IF EXISTS ESPECIALIDAD CASCADE;
-- DROP TABLE IF EXISTS CICLO_EDUCATIVO CASCADE;

-- 1. CICLO_EDUCATIVO
CREATE TABLE CICLO_EDUCATIVO (
    cod_ciclo VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    real_decreto VARCHAR(255),
    decreto_autonomico VARCHAR(255)
);

-- 2. ESPECIALIDAD
CREATE TABLE ESPECIALIDAD (
    cod_especialidad VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    cod_ciclo VARCHAR(10) NOT NULL,
    CONSTRAINT fk_especialidad_ciclo FOREIGN KEY (cod_ciclo) 
        REFERENCES CICLO_EDUCATIVO(cod_ciclo) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 3. CURSO (Entidad débil de ESPECIALIDAD)
CREATE TABLE CURSO (
    num_curso SMALLINT NOT NULL,
    cod_especialidad VARCHAR(10) NOT NULL,
    num_optativas SMALLINT NOT NULL DEFAULT 0,
    PRIMARY KEY (num_curso, cod_especialidad),
    CONSTRAINT fk_curso_especialidad FOREIGN KEY (cod_especialidad) 
        REFERENCES ESPECIALIDAD(cod_especialidad) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 4. ASIGNATURA
CREATE TABLE ASIGNATURA (
    cod_asignatura VARCHAR(15) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    tipo VARCHAR(30) NOT NULL, -- 'Obligatoria' o 'Optativa'
    num_horas SMALLINT NOT NULL,
    num_curso SMALLINT NOT NULL,
    cod_especialidad VARCHAR(10) NOT NULL,
    CONSTRAINT fk_asignatura_curso FOREIGN KEY (num_curso, cod_especialidad) 
        REFERENCES CURSO(num_curso, cod_especialidad) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 5. RESPONSABLE_LEGAL
CREATE TABLE RESPONSABLE_LEGAL (
    cod_responsable VARCHAR(15) PRIMARY KEY,
    nombre_1 VARCHAR(100) NOT NULL,
    nombre_2 VARCHAR(100),
    telefono_1 VARCHAR(20) NOT NULL,
    telefono_2 VARCHAR(20),
    email_1 VARCHAR(100) NOT NULL,
    email_2 VARCHAR(100),
    direccion VARCHAR(255) NOT NULL, -- Atributo compuesto aplanado
    monoparental BOOLEAN NOT NULL DEFAULT FALSE
);

-- 6. ENCUESTA (Entidad débil de RESPONSABLE_LEGAL)
CREATE TABLE ENCUESTA (
    cod_responsable VARCHAR(15) NOT NULL,
    fecha DATE NOT NULL,
    ingresos DECIMAL(10, 2) NOT NULL,
    internet BOOLEAN NOT NULL DEFAULT TRUE,
    nivel_estudios_1 VARCHAR(100) NOT NULL,
    nivel_estudios_2 VARCHAR(100),
    num_ordenadores SMALLINT NOT NULL DEFAULT 0,
    num_integrantes SMALLINT NOT NULL DEFAULT 1,
    PRIMARY KEY (cod_responsable, fecha),
    CONSTRAINT fk_encuesta_responsable FOREIGN KEY (cod_responsable) 
        REFERENCES RESPONSABLE_LEGAL(cod_responsable) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 7. ESTUDIANTE
CREATE TABLE ESTUDIANTE (
    num_expediente VARCHAR(15) PRIMARY KEY,
    dni VARCHAR(12) UNIQUE NOT NULL,
    nombre VARCHAR(150) NOT NULL, -- Atributo compuesto aplanado
    fecha_nacimiento DATE NOT NULL,
    email VARCHAR(100) UNIQUE,
    cod_responsable VARCHAR(15) NOT NULL,
    CONSTRAINT fk_estudiante_responsable FOREIGN KEY (cod_responsable) 
        REFERENCES RESPONSABLE_LEGAL(cod_responsable) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 8. ADAPTACION_CURRICULAR
CREATE TABLE ADAPTACION_CURRICULAR (
    cod_adaptacion VARCHAR(15) PRIMARY KEY,
    fecha DATE NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    informe TEXT NOT NULL,
    num_expediente VARCHAR(15) NOT NULL,
    CONSTRAINT fk_adaptacion_estudiante FOREIGN KEY (num_expediente) 
        REFERENCES ESTUDIANTE(num_expediente) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 9. ADAPTACION_ASIGNATURA (Relación N:M)
CREATE TABLE ADAPTACION_ASIGNATURA (
    cod_adaptacion VARCHAR(15) NOT NULL,
    cod_asignatura VARCHAR(15) NOT NULL,
    PRIMARY KEY (cod_adaptacion, cod_asignatura),
    CONSTRAINT fk_adap_asig_curricular FOREIGN KEY (cod_adaptacion) 
        REFERENCES ADAPTACION_CURRICULAR(cod_adaptacion) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_adap_asig_asignatura FOREIGN KEY (cod_asignatura) 
        REFERENCES ASIGNATURA(cod_asignatura) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 10. CENTRO
CREATE TABLE CENTRO (
    cod_centro VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    email VARCHAR(100),
    tipo VARCHAR(50), -- 'Público', 'Concertado', 'Privado'
    direccion VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    naturaleza VARCHAR(50) -- 'IES', 'Colegio', etc.
);

-- 11. ADMISION (Entidad débil de ESTUDIANTE)
CREATE TABLE ADMISION (
    num_expediente VARCHAR(15) NOT NULL,
    fecha DATE NOT NULL,
    num_curso SMALLINT NOT NULL,
    cod_especialidad VARCHAR(10) NOT NULL,
    cod_centro VARCHAR(10) NOT NULL,
    PRIMARY KEY (num_expediente, fecha),
    CONSTRAINT fk_admision_estudiante FOREIGN KEY (num_expediente) 
        REFERENCES ESTUDIANTE(num_expediente) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_admision_curso FOREIGN KEY (num_curso, cod_especialidad) 
        REFERENCES CURSO(num_curso, cod_especialidad) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_admision_centro FOREIGN KEY (cod_centro) 
        REFERENCES CENTRO(cod_centro) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 12. MATRICULA
CREATE TABLE MATRICULA (
    cod_matricula VARCHAR(15) PRIMARY KEY,
    fecha DATE NOT NULL,
    curso_academico VARCHAR(9) NOT NULL, -- Formato: '2025/2026'
    num_expediente VARCHAR(15) NOT NULL,
    cod_centro VARCHAR(10) NOT NULL,
    num_curso SMALLINT NOT NULL,
    cod_especialidad VARCHAR(10) NOT NULL,
    CONSTRAINT fk_matricula_estudiante FOREIGN KEY (num_expediente) 
        REFERENCES ESTUDIANTE(num_expediente) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_matricula_centro FOREIGN KEY (cod_centro) 
        REFERENCES CENTRO(cod_centro) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_matricula_curso FOREIGN KEY (num_curso, cod_especialidad) 
        REFERENCES CURSO(num_curso, cod_especialidad) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 13. ASIGNATURA_MATRICULA (Relación N:M)
CREATE TABLE ASIGNATURA_MATRICULA (
    cod_asignatura VARCHAR(15) NOT NULL,
    cod_matricula VARCHAR(15) NOT NULL,
    suspenso_curso_anterior BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (cod_asignatura, cod_matricula),
    CONSTRAINT fk_asig_matr_asignatura FOREIGN KEY (cod_asignatura) 
        REFERENCES ASIGNATURA(cod_asignatura) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_asig_matr_matricula FOREIGN KEY (cod_matricula) 
        REFERENCES MATRICULA(cod_matricula) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 14. LINEA_EXPEDIENTE (Entidad débil de la agregación ASIGNATURA_MATRICULA)
CREATE TABLE LINEA_EXPEDIENTE (
    cod_asignatura VARCHAR(15) NOT NULL,
    cod_matricula VARCHAR(15) NOT NULL,
    evaluacion VARCHAR(50) NOT NULL, -- '1ª Evaluación', 'Final Ordinaria', etc.
    nota DECIMAL(4, 2) CHECK (nota >= 0.00 AND nota <= 10.00),
    PRIMARY KEY (cod_asignatura, cod_matricula, evaluacion),
    CONSTRAINT fk_linea_exp_agregacion FOREIGN KEY (cod_asignatura, cod_matricula) 
        REFERENCES ASIGNATURA_MATRICULA(cod_asignatura, cod_matricula) ON DELETE CASCADE ON UPDATE CASCADE
);
