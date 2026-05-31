-- CASO DE ESTUDIO 22: CARLOS PINTOS BLANCO (ALUMNO DE CONTROL / RENDIMIENTO MEDIO ESTABLE)
-- Archivo: alumno_22_control_carlos.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Manuel Pintos Blanco e Isabel Blanco Castro)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP022', 'Manuel Pintos Blanco', 'Isabel Blanco Castro', '600220011', NULL, 'manuel.pintos@email.com', NULL, 'Rúa Juan Flórez 55, 4º Der, CP 15004, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos estables de clase media-baja típica y nula brecha digital)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP022', '2023-09-10', 24000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3), -- Encuesta en Primaria
('RESP022', '2025-09-12', 24000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015022', '12341234B', 'Carlos Pintos Blanco', '2012-05-18', 'carlos.pintos@alumno.com', 'RESP022');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015022', '2023-06-15', 6, 'PRI-GEN', 'C005'), -- CEIP Ramón de la Sagra
('EXP2015022', '2024-07-04', 1, 'ESO-GEN', 'I002'); -- IES Fernando Wirtz Suárez

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-CARL2-PRI6', '2023-09-01', '2023/2024', 'EXP2015022', 'C005', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-CARL2-ESO1', '2024-09-02', '2024/2025', 'EXP2015022', 'I002',     1, 'ESO-GEN'),
('MAT-CARL2-ESO2', '2025-09-01', '2025/2026', 'EXP2015022', 'I002',     2, 'ESO-GEN'); -- Curso actual

-- 6. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-CARL2-PRI6', false), ('PRI6-MAT', 'MAT-CARL2-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-CARL2-PRI6', 'Final Ordinaria', 6.00),
('PRI6-MAT', 'MAT-CARL2-PRI6', 'Final Ordinaria', 6.00);

-- B. 1º ESO (2024/2025)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-CARL2-ESO1', false), ('ESO1-MAT', 'MAT-CARL2-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-CARL2-ESO1', 'Final Ordinaria', 6.00),
('ESO1-MAT', 'MAT-CARL2-ESO1', 'Final Ordinaria', 5.50);

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-CARL2-ESO2', false), ('ESO2-MAT', 'MAT-CARL2-ESO2', false), ('ESO2-FQ', 'MAT-CARL2-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-CARL2-ESO2', '1ª Evaluación', 6.00), -- Bien
('ESO2-MAT', 'MAT-CARL2-ESO2', '1ª Evaluación', 6.00), -- Bien
('ESO2-FQ',  'MAT-CARL2-ESO2', '1ª Evaluación', 5.50); -- Aprobado raspado
