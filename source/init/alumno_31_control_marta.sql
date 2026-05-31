-- CASO DE ESTUDIO 31: MARTA IGLESIAS BLANCO (ALUMNA DE CONTROL / RENDIMIENTO NOTABLE)
-- Archivo: alumno_31_control_marta.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Daniel Iglesias Varela e Isabel Blanco Castro)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP031', 'Daniel Iglesias Varela', 'Isabel Blanco Castro', '600310011', NULL, 'daniel.iglesias.b@email.com', NULL, 'Rúa de la Torre 44, CP 15002, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos estables de clase media y nula brecha digital)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP031', '2023-09-10', 28500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3), -- Encuesta en Primaria
('RESP031', '2025-09-12', 28000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2016031', '12341234K', 'Marta Iglesias Blanco', '2013-03-12', 'marta.iglesias@alumno.com', 'RESP031');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2016031', '2023-06-15', 5, 'PRI-GEN', 'C001'), -- CEIP Emilia Pardo Bazán
('EXP2016031', '2025-07-03', 1, 'ESO-GEN', 'I001'); -- IES Eusebio da Guarda

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-MART3-PRI5', '2023-09-01', '2023/2024', 'EXP2016031', 'C001', 5, 'PRI-GEN'),
('MAT-MART3-PRI6', '2024-09-02', '2024/2025', 'EXP2016031', 'C001', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-MART3-ESO1', '2025-09-01', '2025/2026', 'EXP2016031', 'I001', 1, 'ESO-GEN'); -- Curso actual

-- 6. Historial de Calificaciones
-- A. 5º PRIMARIA (2023/2024)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI5-LCL', 'MAT-MART3-PRI5', false), ('PRI5-MAT', 'MAT-MART3-PRI5', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI5-LCL', 'MAT-MART3-PRI5', 'Final Ordinaria', 7.50),
('PRI5-MAT', 'MAT-MART3-PRI5', 'Final Ordinaria', 7.50);

-- B. 6º PRIMARIA (2024/2025)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-MART3-PRI6', false), ('PRI6-MAT', 'MAT-MART3-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-MART3-PRI6', 'Final Ordinaria', 8.00),
('PRI6-MAT', 'MAT-MART3-PRI6', 'Final Ordinaria', 7.50);

-- C. 1º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-MART3-ESO1', false), ('ESO1-MAT', 'MAT-MART3-ESO1', false), ('ESO1-GH', 'MAT-MART3-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-MART3-ESO1', '1ª Evaluación', 7.50), -- Notable
('ESO1-MAT', 'MAT-MART3-ESO1', '1ª Evaluación', 7.50), -- Notable
('ESO1-GH',  'MAT-MART3-ESO1', '1ª Evaluación', 8.00); -- Notable alto
