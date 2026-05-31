-- CASO DE ESTUDIO 12: AITOR IGLESIAS GÓMEZ (ACOGIMIENTO FAMILIAR Y COMPENSATORIA)
-- Archivo: alumno_12_acogimiento.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsable Legal (Familia Acogedora - Carmen Gómez Castro y Roberto Iglesias Otero)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP012', 'Carmen Gómez Castro', 'Roberto Iglesias Otero', '600120011', '600120022', 'carmen.gomez@email.com', 'roberto.iglesias@email.com', 'Rúa Agra do Orzán 28, 2º B, CP 15010, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan estabilidad económica del hogar acogedor protector)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP012', '2020-09-10', 28500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3), -- Encuesta al formalizarse acogimiento en 3º Primaria
('RESP012', '2025-09-12', 28000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3); -- Encuesta en 2º ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2014012', '99001122L', 'Aitor Iglesias Gómez', '2012-04-10', 'aitor.iglesias@alumno.com', 'RESP012');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2014012', '2020-06-15', 3, 'PRI-GEN', 'C004'), -- Admitido en 3º Primaria en CEIP Alborada tras desamparo
('EXP2014012', '2024-07-04', 1, 'ESO-GEN', 'I003'); -- Admitido en 1º ESO en IES Agra do Orzán

-- 5. Historial Longitudinal de Matrículas Anuales (Superación progresiva de desfases de desarrollo)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria (CEIP Alborada)
('MAT-AITO-PRI3', '2020-09-01', '2020/2021', 'EXP2014012', 'C004', 3, 'PRI-GEN'), -- 3º Primaria
('MAT-AITO-PRI6', '2023-09-01', '2023/2024', 'EXP2014012', 'C004', 6, 'PRI-GEN'), -- 6º Primaria
-- Educación Secundaria - ESO (IES Agra do Orzán)
('MAT-AITO-ESO1', '2024-09-02', '2024/2025', 'EXP2014012', 'I003',     1, 'ESO-GEN'), -- 1º ESO
('MAT-AITO-ESO2', '2025-09-01', '2025/2026', 'EXP2014012', 'I003',     2, 'ESO-GEN'); -- 2º ESO (Curso actual, aprobados al límite)

-- 6. Adaptación Curricular / Apoyo por Acogimiento (Asignado en 3º Primaria al dictarse tutela y acogimiento permanente)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP012', '2020-10-15', 'Apoyo Social - Acogimiento Familiar', 'Estudiante en acogimiento familiar permanente en familia ajena por desamparo severo en el hogar biológico. Presenta desfase instrumental y de desarrollo madurativo. Requiere plan compensatorio individual y seguimiento psicopedagógico trimestral con educador de menores.', 'EXP2014012');

-- Asociamos el plan de apoyo con las asignaturas instrumentales básicas donde presentaba desfase en Primaria
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP012', 'PRI3-MAT'),
('ADAP012', 'PRI3-LCL');

-- 7. Historial de Calificaciones
-- A. 3º PRIMARIA (2020/2021 - Superado de forma limpia con plan compensatorio y apoyo familiar)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI3-LCL', 'MAT-AITO-PRI3', false), 
('PRI3-MAT', 'MAT-AITO-PRI3', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI3-LCL', 'MAT-AITO-PRI3', 'Final Ordinaria', 5.00),
('PRI3-MAT', 'MAT-AITO-PRI3', 'Final Ordinaria', 5.00);

-- B. 6º PRIMARIA (2023/2024 - Rendimiento superado a aprobados regulares estables)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-AITO-PRI6', false), 
('PRI6-MAT', 'MAT-AITO-PRI6', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-AITO-PRI6', 'Final Ordinaria', 5.50),
('PRI6-MAT', 'MAT-AITO-PRI6', 'Final Ordinaria', 5.50);

-- C. 1º ESO (2024/2025 - Paso a secundaria superado en junio en el límite ordinario)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-AITO-ESO1', false), 
('ESO1-MAT', 'MAT-AITO-ESO1', false),
('ESO1-GH',  'MAT-AITO-ESO1', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-AITO-ESO1', 'Final Ordinaria', 5.00),
('ESO1-MAT', 'MAT-AITO-ESO1', 'Final Ordinaria', 5.00),
('ESO1-GH',  'MAT-AITO-ESO1', 'Final Ordinaria', 5.00);

-- D. 2º ESO - CURSO ACTUAL (2025/2026 - Mayor regularidad social, pero lagunas en ciencias en 1ª Ev)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-AITO-ESO2', false),
('ESO2-MAT', 'MAT-AITO-ESO2', false),
('ESO2-FQ',  'MAT-AITO-ESO2', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-AITO-ESO2', '1ª Evaluación', 5.00), -- Aprobado raspado
('ESO2-MAT', 'MAT-AITO-ESO2', '1ª Evaluación', 5.00), -- Aprobado raspado
('ESO2-FQ',  'MAT-AITO-ESO2', '1ª Evaluación', 4.50); -- Suspenso leve
