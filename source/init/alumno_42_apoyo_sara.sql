-- CASO DE ESTUDIO 42: SARA ROMERO CASTRO (ALUMNA DE RIESGO ALTO - FP BÁSICA ACTIVA 2º CURSO EN EDAD OBLIGATORIA)
-- Archivo: alumno_42_apoyo_sara.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Juan Romero Blanco y María Castro Gómez)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP042', 'Juan Romero Blanco', 'María Castro Gómez', '600420011', '600420022', 'juan.romero@email.com', 'maria.castro.g@email.com', 'Rúa Agra do Orzán 50, N/A, CP 15010, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Hogar vulnerable con muy bajos ingresos y sin equipamiento digital)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP042', '2019-09-10', 11500.00, false, 'Estudios Primarios', 'Estudios Primarios', 0, 5), -- Encuesta en Primaria
('RESP042', '2021-09-12', 12000.00, false, 'Estudios Primarios', 'Estudios Primarios', 0, 5); -- Encuesta en ESO

-- 3. Expediente del Estudiante (Nacida en 2009 para estar en edad obligatoria de 16 años en 2º Grado Básico)
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2014042', '78901238M', 'Sara Romero Castro', '2009-08-14', 'sara.romero@alumno.com', 'RESP042');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2014042', '2019-06-15', 6, 'PRI-GEN', 'C004'), -- CEIP Alborada
('EXP2014042', '2020-07-04', 1, 'ESO-GEN', 'I003'), -- IES Agra do Orzán (ESO Ordinaria)
('EXP2014042', '2024-07-03', 3, 'ESO-GB',  'I003'); -- Redirección a FP Básica

-- 5. Historial Longitudinal de Matrículas Anuales (Desfase instrumental y retención en Grado Básico)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('M42-PRI6', '2019-09-01', '2019/2020', 'EXP2014042', 'C004', 6, 'PRI-GEN'),
-- Educación Secundaria Ordinaria
('M42-ESO1', '2020-09-02', '2020/2021', 'EXP2014042', 'I003', 1, 'ESO-GEN'),
('M42-ESO2', '2021-09-01', '2021/2022', 'EXP2014042', 'I003', 2, 'ESO-GEN'), -- Repite 2º ESO por lagunas curriculares
('M42-ESO2R','2022-09-01', '2022/2023', 'EXP2014042', 'I003', 2, 'ESO-GEN'),
-- FP Básica (Grado Básico - IES Agra do Orzán)
('M42-GB1',  '2024-09-01', '2024/2025', 'EXP2014042', 'I003', 3, 'ESO-GB'), -- 1º Grado Básico (Supera con éxito)
('M42-GB2',  '2025-09-01', '2025/2026', 'EXP2014042', 'I003', 4, 'ESO-GB'); -- 2º Grado Básico (Curso actual - Retención)

-- 6. Adaptación Curricular / Plan Gitano - FPB (Plan de Mediación y Derivación Temprana)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP042', '2021-10-15', 'Plan de Integración Social y Apoyo Curricular', 'Estudiante de etnia gitana con desfase escolar instrumental acumulado y absentismo recurrente en la transición. Se incorpora al programa de mediación y se propone su derivación al Ciclo Formativo de Grado Básico (FP Básica) por su marcada aptitud manipulativa y práctica, para potenciar el éxito y evitar el abandono temprano.', 'EXP2014042');

-- Vinculamos la adaptación con las asignaturas del Grado Básico
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP042', 'ESOGB1-ACT'),
('ADAP042', 'ESOGB1-PRAC');

-- 7. Historial de Calificaciones
-- A. 6º PRIMARIA (2019/2020)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'M42-PRI6', false), ('PRI6-MAT', 'M42-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'M42-PRI6', 'Final Ordinaria', 5.00),
('PRI6-MAT', 'M42-PRI6', 'Final Ordinaria', 5.00);

-- B. 1º GRADO BÁSICO (2024/2025 - Excelente adaptación al enfoque práctico)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESOGB1-ACT', 'M42-GB1', false), ('ESOGB1-ALS', 'M42-GB1', false), ('ESOGB1-PRAC', 'M42-GB1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESOGB1-ACT',  'M42-GB1', 'Final Ordinaria', 6.00),
('ESOGB1-ALS',  'M42-GB1', 'Final Ordinaria', 6.50),
('ESOGB1-PRAC', 'M42-GB1', 'Final Ordinaria', 7.50);

-- C. 2º GRADO BÁSICO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESOGB2-ACT', 'M42-GB2', false), ('ESOGB2-ALS', 'M42-GB2', false), ('ESOGB2-PRAC', 'M42-GB2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESOGB2-ACT',  'M42-GB2', '1ª Evaluación', 6.00), -- Ámbito Científico
('ESOGB2-ALS',  'M42-GB2', '1ª Evaluación', 5.50), -- Ámbito Comunicación
('ESOGB2-PRAC', 'M42-GB2', '1ª Evaluación', 8.00); -- Taller Práctico (¡Sobresaliente motivación!)
