-- CASO DE ESTUDIO 32: LEO PINTOS CASTRO (ALUMNO DE RIESGO MODERADO / APOYO COMPENSATORIO)
-- Archivo: alumno_32_apoyo_leo.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Santiago Pintos Varela y Marta Castro Otero)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP032', 'Santiago Pintos Varela', 'Marta Castro Otero', '600320011', NULL, 'santiago.pintos.c@email.com', NULL, 'Rúa Barcelona 30, CP 15011, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos bajos del sector servicios y nula brecha digital)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP032', '2023-09-10', 13000.00, true, 'Estudios Primarios', 'Estudios Primarios', 1, 3), -- Encuesta en Primaria
('RESP032', '2025-09-12', 12500.00, true, 'Estudios Primarios', 'Estudios Primarios', 1, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015032', '12341234L', 'Leo Pintos Castro', '2012-04-14', 'leo.pintos@alumno.com', 'RESP032');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015032', '2023-06-15', 6, 'PRI-GEN', 'C004'), -- CEIP Alborada
('EXP2015032', '2024-07-02', 1, 'ESO-GEN', 'I003'); -- IES Agra do Orzán

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-LEOP-PRI6', '2023-09-01', '2023/2024', 'EXP2015032', 'C004', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-LEOP-ESO1', '2024-09-02', '2024/2025', 'EXP2015032', 'I003',     1, 'ESO-GEN'),
('MAT-LEOP-ESO2', '2025-09-01', '2025/2026', 'EXP2015032', 'I003',     2, 'ESO-GEN'); -- Curso actual

-- 6. Adaptación Curricular / Apoyo Compensatorio (Activada en 2º ESO por dificultades instrumentales acumuladas)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP032', '2025-10-15', 'Apoyo Educativo - Compensatoria', 'El estudiante registra dificultades de aprendizaje acumuladas en áreas instrumentales por retraso curricular de base. Se asigna plan de apoyo compensatorio con refuerzo en grupos de nivel flexibles en lengua y matemáticas.', 'EXP2015032');

-- Relacionamos la adaptación con las asignaturas instrumentales troncales adaptadas en 2º de ESO
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP032', 'ESO2-LCL'),
('ADAP032', 'ESO2-MAT');

-- 7. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-LEOP-PRI6', false), ('PRI6-MAT', 'MAT-LEOP-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-LEOP-PRI6', 'Final Ordinaria', 5.00),
('PRI6-MAT', 'MAT-LEOP-PRI6', 'Final Ordinaria', 5.00);

-- B. 1º ESO (2024/2025)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-LEOP-ESO1', false), ('ESO1-MAT', 'MAT-LEOP-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-LEOP-ESO1', 'Final Ordinaria', 5.00),
('ESO1-MAT', 'MAT-LEOP-ESO1', 'Final Ordinaria', 5.00);

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-LEOP-ESO2', false), ('ESO2-MAT', 'MAT-LEOP-ESO2', false), ('ESO2-FQ', 'MAT-LEOP-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-LEOP-ESO2', '1ª Evaluación', 5.50), -- Aprobado raspado
('ESO2-MAT', 'MAT-LEOP-ESO2', '1ª Evaluación', 5.00), -- Aprobado raspado
('ESO2-FQ',  'MAT-LEOP-ESO2', '1ª Evaluación', 5.00); -- Aprobado raspado
