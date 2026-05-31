-- CASO DE ESTUDIO 39: DANIEL IGLESIAS CASTRO (ALUMNO DE CONTROL / RENDIMIENTO MEDIO ESTABLE)
-- Archivo: alumno_39_control_daniel.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Alberto Iglesias Otero y Clara Castro Blanco)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP039', 'Alberto Iglesias Otero', 'Clara Castro Blanco', '600390011', '600390022', 'alberto.iglesias@email.com', 'clara.castro@email.com', 'Rúa Juan Flórez 45, 3º D, CP 15004, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan estabilidad económica de clase media)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP039', '2023-09-07', 24000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 4), -- Encuesta en Primaria
('RESP039', '2025-09-12', 24500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 4); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015039', '78901235H', 'Daniel Iglesias Castro', '2012-11-18', 'daniel.iglesias@alumno.com', 'RESP039');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015039', '2023-06-15', 6, 'PRI-GEN', 'C005'), -- CEIP Ramón de la Sagra
('EXP2015039', '2024-07-03', 1, 'ESO-GEN', 'I002'); -- IES Fernando Wirtz Suárez

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-DANI-PRI6', '2023-09-01', '2023/2024', 'EXP2015039', 'C005', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-DANI-ESO1', '2024-09-02', '2024/2025', 'EXP2015039', 'I002', 1, 'ESO-GEN'),
('MAT-DANI-ESO2', '2025-09-01', '2025/2026', 'EXP2015039', 'I002', 2, 'ESO-GEN'); -- Curso actual

-- 6. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024 - Rendimiento medio)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-DANI-PRI6', false), ('PRI6-MAT', 'MAT-DANI-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-DANI-PRI6', 'Final Ordinaria', 6.00),
('PRI6-MAT', 'MAT-DANI-PRI6', 'Final Ordinaria', 6.50);

-- B. 1º ESO (2024/2025 - Rendimiento estable en transición)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-DANI-ESO1', false), ('ESO1-MAT', 'MAT-DANI-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-DANI-ESO1', 'Final Ordinaria', 6.25),
('ESO1-MAT', 'MAT-DANI-ESO1', 'Final Ordinaria', 6.00);

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-DANI-ESO2', false), ('ESO2-MAT', 'MAT-DANI-ESO2', false), ('ESO2-FQ', 'MAT-DANI-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-DANI-ESO2', '1ª Evaluación', 6.00), -- Aprobado medio
('ESO2-MAT', 'MAT-DANI-ESO2', '1ª Evaluación', 6.00), -- Aprobado medio
('ESO2-FQ',  'MAT-DANI-ESO2', '1ª Evaluación', 6.25); -- Aprobado medio
