-- CASO DE ESTUDIO 16: IRIS SEOANE OTERO (NEAE - DISLEXIA MIXTA Y ADAPTACIÓN DE ACCESO)
-- Archivo: alumno_16_dislexia.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Ángel Seoane Fraga y Laura Otero Díaz)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP016', 'Ángel Seoane Fraga', 'Laura Otero Díaz', '600160011', '600160022', 'angel.seoane@email.com', 'laura.otero@email.com', 'Rúa Emilia Pardo Bazán 16, 2º Der, CP 15005, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan clase media estable con nivel educativo secundario)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP016', '2023-09-10', 23000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3), -- Encuesta en Primaria
('RESP016', '2025-09-12', 22500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015016', '99887766N', 'Iris Seoane Otero', '2012-12-05', 'iris.seoane@alumno.com', 'RESP016');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015016', '2015-06-12', 1, 'INF-GEN', 'C005'), -- Admitida en Infantil en CEIP Ramón de la Sagra
('EXP2015016', '2024-07-03', 1, 'ESO-GEN', 'I001'); -- Admitida en 1º ESO en IES Eusebio da Guarda

-- 5. Historial Longitudinal de Matrículas Anuales (Historial de aprobados con alto esfuerzo y remontada en ESO)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Infantil (CEIP Ramón de la Sagra)
('MAT-IRIS-INF3', '2017-09-01', '2017/2018', 'EXP2015016', 'C005', 3, 'INF-GEN'), -- 3º Infantil
-- Educación Primaria (CEIP Ramón de la Sagra)
('MAT-IRIS-PRI6', '2023-09-01', '2023/2024', 'EXP2015016', 'C005', 6, 'PRI-GEN'), -- 6º Primaria
-- Educación Secundaria - ESO (IES Eusebio da Guarda)
('MAT-IRIS-ESO1', '2024-09-02', '2024/2025', 'EXP2015016', 'I001', 1, 'ESO-GEN'), -- 1º ESO (Crisis en 1ª Ev, diagnóstico en 2ª Ev)
('MAT-IRIS-ESO2', '2025-09-01', '2025/2026', 'EXP2015016', 'I001', 2, 'ESO-GEN'); -- 2º ESO (Curso actual, consolidado)

-- 6. Adaptación Curricular / Apoyo Dislexia (Asignado en el segundo trimestre de 1º ESO tras evaluación psicopedagógica)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP016', '2025-02-18', 'Apoyo Educativo - Dislexia / Lectoescritura', 'Estudiante diagnosticada con Dislexia Evolutiva mixta severa en Secundaria. Se activa Adaptación de Acceso: flexibilización de la penalización ortográfica (máximo 1 punto por examen), pruebas impresas en OpenDyslexic con 30% más de tiempo y fomento de evaluaciones orales.', 'EXP2015016');

-- Relacionamos la adaptación con las asignaturas instrumentales troncales adaptadas en 1º de ESO
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP016', 'ESO1-LCL'),
('ADAP016', 'ESO1-MAT');

-- 7. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024 - Aprobados regulares con gran sobreesfuerzo sin diagnosticar)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-IRIS-PRI6', false), 
('PRI6-MAT', 'MAT-IRIS-PRI6', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-IRIS-PRI6', 'Final Ordinaria', 5.50),
('PRI6-MAT', 'MAT-IRIS-PRI6', 'Final Ordinaria', 6.00);

-- B. 1º ESO (2024/2025 - Remontada tras adaptaciones en el segundo trimestre)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-IRIS-ESO1', false), 
('ESO1-MAT', 'MAT-IRIS-ESO1', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-IRIS-ESO1', 'Final Ordinaria', 6.00), -- Notable bajo en Lengua Castellana
('ESO1-MAT', 'MAT-IRIS-ESO1', 'Final Ordinaria', 6.50); -- Notable bajo en Matemáticas

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - Rendimiento notable y equilibrado en 1ª Ev)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-IRIS-ESO2', false),
('ESO2-MAT', 'MAT-IRIS-ESO2', false),
('ESO2-GH',  'MAT-IRIS-ESO2', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-IRIS-ESO2', '1ª Evaluación', 6.50), -- Notable (con exención parcial ortográfica)
('ESO2-MAT', 'MAT-IRIS-ESO2', '1ª Evaluación', 7.00), -- Notable alto en razonamiento lógico
('ESO2-GH',  'MAT-IRIS-ESO2', '1ª Evaluación', 6.00); -- Aprobado holgado (superada la barrera comprensiva escrita)
