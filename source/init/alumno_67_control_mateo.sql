-- CASO DE ESTUDIO 67: MATEO ROMERO VARELA (ALUMNO DE CONTROL / RENDIMIENTO NOTABLE)
-- Archivo: alumno_67_control_mateo.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Sergio Romero Otero y Laura Varela Rey)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP067', 'Sergio Romero Otero', 'Laura Varela Rey', '600670011', '600670022', 'sergio.romero.v2@email.com', 'laura.varela.rey2@email.com', 'Rúa Real 90, CP 15003, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos estables de clase media)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP067', '2024-09-08', 28500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3), -- Encuesta en Primaria
('RESP067', '2025-09-12', 29000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2016067', '78901256G', 'Mateo Romero Varela', '2013-05-18', 'mateo.romero.va@alumno.com', 'RESP067');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2016067', '2024-06-15', 6, 'PRI-GEN', 'C005'), -- CEIP Ramón de la Sagra
('EXP2016067', '2025-07-03', 1, 'ESO-GEN', 'I002'); -- IES Fernando Wirtz Suárez

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-MAT3-PRI6', '2024-09-02', '2024/2025', 'EXP2016067', 'C005', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-MAT3-ESO1', '2025-09-01', '2025/2026', 'EXP2016067', 'I002', 1, 'ESO-GEN'); -- Curso actual

-- 6. Historial de Calificaciones
-- A. 6º PRIMARIA (2024/2025)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-MAT3-PRI6', false), ('PRI6-MAT', 'MAT-MAT3-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-MAT3-PRI6', 'Final Ordinaria', 7.50),
('PRI6-MAT', 'MAT-MAT3-PRI6', 'Final Ordinaria', 7.50);

-- B. 1º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-MAT3-ESO1', false), ('ESO1-MAT', 'MAT-MAT3-ESO1', false), ('ESO1-ING', 'MAT-MAT3-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-MAT3-ESO1', '1ª Evaluación', 7.50), -- Notable
('ESO1-MAT', 'MAT-MAT3-ESO1', '1ª Evaluación', 7.00), -- Notable
('ESO1-ING', 'MAT-MAT3-ESO1', '1ª Evaluación', 7.50); -- Notable alto
