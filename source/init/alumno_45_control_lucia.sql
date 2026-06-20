-- CASO DE ESTUDIO 45: LUCÍA IGLESIAS GÓMEZ (ALUMNA DE CONTROL / RENDIMIENTO EXCELENTE)
-- Archivo: alumno_45_control_lucia.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Adrián Iglesias Blanco y Paula Gómez Romero)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP045', 'Adrián Iglesias Blanco', 'Paula Gómez Romero', '600450011', '600450022', 'adrian.iglesias@email.com', 'paula.gomez.r@email.com', 'Rúa Pato 4, 3º D, CP 15002, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan alto nivel socioeconómico)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP045', '2023-09-09', 34500.00, true, 'Estudios Universitarios', 'Estudios Universitarios', 2, 3), -- Encuesta en Primaria
('RESP045', '2025-09-12', 35000.00, true, 'Estudios Universitarios', 'Estudios Universitarios', 3, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2016045', '78901241Q', 'Lucía Iglesias Gómez', '2013-05-24', 'lucia45.iglesias@alumno.com', 'RESP045');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2016045', '2023-06-15', 5, 'PRI-GEN', 'C006'), -- CEIP Cidade Vella
('EXP2016045', '2025-07-03', 1, 'ESO-GEN', 'I006'); -- IES Ramón Menéndez Pidal (Zalaeta)

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('M45-PRI5', '2023-09-01', '2023/2024', 'EXP2016045', 'C006', 5, 'PRI-GEN'),
('M45-PRI6', '2024-09-02', '2024/2025', 'EXP2016045', 'C006', 6, 'PRI-GEN'),
-- Educación Secundaria
('M45-ESO1', '2025-09-01', '2025/2026', 'EXP2016045', 'I006', 1, 'ESO-GEN'); -- Curso actual

-- 6. Historial de Calificaciones
-- A. 5º PRIMARIA (2023/2024 - Excelente)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI5-LCL', 'M45-PRI5', false), ('PRI5-MAT', 'M45-PRI5', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI5-LCL', 'M45-PRI5', 'Final Ordinaria', 8.50),
('PRI5-MAT', 'M45-PRI5', 'Final Ordinaria', 9.00);

-- B. 6º PRIMARIA (2024/2025 - Excelente continuo)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'M45-PRI6', false), ('PRI6-MAT', 'M45-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'M45-PRI6', 'Final Ordinaria', 9.00),
('PRI6-MAT', 'M45-PRI6', 'Final Ordinaria', 9.50);

-- C. 1º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'M45-ESO1', false), ('ESO1-MAT', 'M45-ESO1', false), ('ESO1-ING', 'M45-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'M45-ESO1', '1ª Evaluación', 9.00), -- Sobresaliente
('ESO1-MAT', 'M45-ESO1', '1ª Evaluación', 9.50), -- Sobresaliente
('ESO1-ING', 'M45-ESO1', '1ª Evaluación', 9.00); -- Sobresaliente
