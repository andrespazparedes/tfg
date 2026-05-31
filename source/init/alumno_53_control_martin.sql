-- CASO DE ESTUDIO 53: MARTÍN VARELA GÓMEZ (ALUMNO DE CONTROL / RENDIMIENTO MEDIO ESTABLE)
-- Archivo: alumno_53_control_martin.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Alberto Varela Castro y María Gómez Rey)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP053', 'Alberto Varela Castro', 'María Gómez Rey', '600530011', '600530022', 'alberto.varela.c@email.com', 'maria.gomez.rey@email.com', 'Rúa Juan Flórez 80, 5º A, CP 15004, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan estabilidad económica de clase media)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP053', '2024-09-08', 24000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 4), -- Encuesta en Primaria
('RESP053', '2025-09-12', 24500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 4); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2016053', '78901249Z', 'Martín Varela Gómez', '2013-11-14', 'martin.varela@alumno.com', 'RESP053');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2016053', '2024-06-15', 6, 'PRI-GEN', 'C005'), -- CEIP Ramón de la Sagra
('EXP2016053', '2025-07-03', 1, 'ESO-GEN', 'I002'); -- IES Fernando Wirtz Suárez

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-MARTI2-PRI6', '2024-09-02', '2024/2025', 'EXP2016053', 'C005', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-MARTI2-ESO1', '2025-09-01', '2025/2026', 'EXP2016053', 'I002', 1, 'ESO-GEN'); -- Curso actual

-- 6. Historial de Calificaciones
-- A. 6º PRIMARIA (2024/2025 - Rendimiento medio)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-MARTI2-PRI6', false), ('PRI6-MAT', 'MAT-MARTI2-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-MARTI2-PRI6', 'Final Ordinaria', 6.00),
('PRI6-MAT', 'MAT-MARTI2-PRI6', 'Final Ordinaria', 6.00);

-- B. 1º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-MARTI2-ESO1', false), ('ESO1-MAT', 'MAT-MARTI2-ESO1', false), ('ESO1-ING', 'MAT-MARTI2-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-MARTI2-ESO1', '1ª Evaluación', 6.00), -- Aprobado regular
('ESO1-MAT', 'MAT-MARTI2-ESO1', '1ª Evaluación', 6.00), -- Aprobado regular
('ESO1-ING', 'MAT-MARTI2-ESO1', '1ª Evaluación', 6.50); -- Aprobado regular
