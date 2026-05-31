-- CASO DE ESTUDIO 41: HUGO BLANCO OTERO (ALUMNO DE CONTROL / RENDIMIENTO NOTABLE ESTABLE)
-- Archivo: alumno_41_control_hugo.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Sergio Blanco Castro y Elena Otero Varela)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP041', 'Sergio Blanco Castro', 'Elena Otero Varela', '600410011', '600410022', 'sergio.blanco@email.com', 'elena.otero@email.com', 'Rúa Adelaida Muro 15, 2º A, CP 15002, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos estables de clase media)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP041', '2023-09-08', 28500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3), -- Encuesta en Primaria
('RESP041', '2025-09-12', 29000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2016041', '78901237L', 'Hugo Blanco Otero', '2013-06-20', 'hugo.blanco@alumno.com', 'RESP041');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2016041', '2023-06-15', 5, 'PRI-GEN', 'C001'), -- CEIP Emilia Pardo Bazán
('EXP2016041', '2025-07-03', 1, 'ESO-GEN', 'I005'); -- IES Adormideras

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-HUGO-PRI5', '2023-09-01', '2023/2024', 'EXP2016041', 'C001', 5, 'PRI-GEN'),
('MAT-HUGO-PRI6', '2024-09-02', '2024/2025', 'EXP2016041', 'C001', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-HUGO-ESO1', '2025-09-01', '2025/2026', 'EXP2016041', 'I005', 1, 'ESO-GEN'); -- Curso actual

-- 6. Historial de Calificaciones
-- A. 5º PRIMARIA (2023/2024)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI5-LCL', 'MAT-HUGO-PRI5', false), ('PRI5-MAT', 'MAT-HUGO-PRI5', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI5-LCL', 'MAT-HUGO-PRI5', 'Final Ordinaria', 7.00),
('PRI5-MAT', 'MAT-HUGO-PRI5', 'Final Ordinaria', 7.50);

-- B. 6º PRIMARIA (2024/2025)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-HUGO-PRI6', false), ('PRI6-MAT', 'MAT-HUGO-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-HUGO-PRI6', 'Final Ordinaria', 7.50),
('PRI6-MAT', 'MAT-HUGO-PRI6', 'Final Ordinaria', 8.00);

-- C. 1º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-HUGO-ESO1', false), ('ESO1-MAT', 'MAT-HUGO-ESO1', false), ('ESO1-ING', 'MAT-HUGO-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-HUGO-ESO1', '1ª Evaluación', 7.50), -- Notable
('ESO1-MAT', 'MAT-HUGO-ESO1', '1ª Evaluación', 7.00), -- Notable
('ESO1-ING', 'MAT-HUGO-ESO1', '1ª Evaluación', 7.50); -- Notable
