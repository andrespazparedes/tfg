-- CASO DE ESTUDIO 37: JULIA OTERO GÓMEZ (ALUMNA DE CONTROL / RENDIMIENTO NOTABLE ESTABLE)
-- Archivo: alumno_37_control_julia.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsable Legal (Beatriz Gómez Rey)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP037', 'Beatriz Gómez Rey', NULL, '600370011', NULL, 'beatriz.gomez.r@email.com', NULL, 'Rúa Elviña 6, 2º B, CP 15008, A Coruña', true);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan hogar monoparental pero estable)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP037', '2023-09-08', 21500.00, true, 'Estudios Secundarios', NULL, 1, 2), -- Encuesta en Primaria
('RESP037', '2025-09-10', 22000.00, true, 'Estudios Secundarios', NULL, 2, 2); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2016037', '98765432J', 'Julia Otero Gómez', '2013-04-14', 'julia.otero@alumno.com', 'RESP037');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2016037', '2023-06-15', 5, 'PRI-GEN', 'C003'), -- CEIP Salgado Torres
('EXP2016037', '2025-07-03', 1, 'ESO-GEN', 'I004'); -- IES de Monelos

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-JULI-PRI5', '2023-09-01', '2023/2024', 'EXP2016037', 'C003', 5, 'PRI-GEN'),
('MAT-JULI-PRI6', '2024-09-02', '2024/2025', 'EXP2016037', 'C003', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-JULI-ESO1', '2025-09-01', '2025/2026', 'EXP2016037', 'I004', 1, 'ESO-GEN'); -- Curso actual

-- 6. Historial de Calificaciones
-- A. 5º PRIMARIA (2023/2024)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI5-LCL', 'MAT-JULI-PRI5', false), ('PRI5-MAT', 'MAT-JULI-PRI5', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI5-LCL', 'MAT-JULI-PRI5', 'Final Ordinaria', 7.50),
('PRI5-MAT', 'MAT-JULI-PRI5', 'Final Ordinaria', 7.00);

-- B. 6º PRIMARIA (2024/2025)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-JULI-PRI6', false), ('PRI6-MAT', 'MAT-JULI-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-JULI-PRI6', 'Final Ordinaria', 8.00),
('PRI6-MAT', 'MAT-JULI-PRI6', 'Final Ordinaria', 7.50);

-- C. 1º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-JULI-ESO1', false), ('ESO1-MAT', 'MAT-JULI-ESO1', false), ('ESO1-ING', 'MAT-JULI-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-JULI-ESO1', '1ª Evaluación', 7.50), -- Notable
('ESO1-MAT', 'MAT-JULI-ESO1', '1ª Evaluación', 7.00), -- Notable
('ESO1-ING', 'MAT-JULI-ESO1', '1ª Evaluación', 8.00); -- Notable alto
