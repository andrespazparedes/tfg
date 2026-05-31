-- CASO DE ESTUDIO 47: MATEO VEIGA OTERO (ALUMNO DE CONTROL / RENDIMIENTO MEDIO-ALTO)
-- Archivo: alumno_47_control_mateo.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Sergio Veiga Blanco e Isabel Otero Gómez)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP047', 'Sergio Veiga Blanco', 'Isabel Otero Gómez', '600470011', '600470022', 'sergio.veiga@email.com', 'isabel.otero@email.com', 'Rúa Juan Castro 14, 4º B, CP 15005, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan estabilidad económica de clase media)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP047', '2023-09-08', 29500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 4), -- Encuesta en Primaria
('RESP047', '2025-09-12', 30000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 4); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015047', '78901243S', 'Mateo Veiga Otero', '2012-08-11', 'mateo.veiga@alumno.com', 'RESP047');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015047', '2023-06-15', 6, 'PRI-GEN', 'C005'), -- CEIP Ramón de la Sagra
('EXP2015047', '2024-07-03', 1, 'ESO-GEN', 'I002'); -- IES Fernando Wirtz Suárez

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-MATI-PRI6', '2023-09-01', '2023/2024', 'EXP2015047', 'C005', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-MATI-ESO1', '2024-09-02', '2024/2025', 'EXP2015047', 'I002', 1, 'ESO-GEN'),
('MAT-MATI-ESO2', '2025-09-01', '2025/2026', 'EXP2015047', 'I002', 2, 'ESO-GEN'); -- Curso actual

-- 6. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024 - Rendimiento notable)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-MATI-PRI6', false), ('PRI6-MAT', 'MAT-MATI-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-MATI-PRI6', 'Final Ordinaria', 7.50),
('PRI6-MAT', 'MAT-MATI-PRI6', 'Final Ordinaria', 8.00);

-- B. 1º ESO (2024/2025 - Notable estable)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-MATI-ESO1', false), ('ESO1-MAT', 'MAT-MATI-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-MATI-ESO1', 'Final Ordinaria', 7.50),
('ESO1-MAT', 'MAT-MATI-ESO1', 'Final Ordinaria', 7.00);

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-MATI-ESO2', false), ('ESO2-MAT', 'MAT-MATI-ESO2', false), ('ESO2-FQ', 'MAT-MATI-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-MATI-ESO2', '1ª Evaluación', 7.00), -- Notable
('ESO2-MAT', 'MAT-MATI-ESO2', '1ª Evaluación', 7.00), -- Notable
('ESO2-FQ',  'MAT-MATI-ESO2', '1ª Evaluación', 7.25); -- Notable
