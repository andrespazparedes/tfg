-- CASO DE ESTUDIO 28: ADRIÁN CASTRO OTERO (ALUMNO DE CONTROL / RENDIMIENTO NOTABLE)
-- Archivo: alumno_28_control_adrian.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Carlos Castro Varela y Beatriz Otero Castro)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP028', 'Carlos Castro Varela', 'Beatriz Otero Castro', '600280011', '600280022', 'carlos.castro@email.com', 'beatriz.otero@email.com', 'Rúa Monelos 18, 2º Der, CP 15009, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos estables de clase media y nula brecha digital)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP028', '2023-09-10', 27500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3), -- Encuesta en Primaria
('RESP028', '2025-09-12', 27000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2016028', '12341234H', 'Adrián Castro Otero', '2013-09-14', 'adrian.castro@alumno.com', 'RESP028');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2016028', '2023-06-16', 5, 'PRI-GEN', 'C003'), -- CEIP Salgado Torres
('EXP2016028', '2025-07-04', 1, 'ESO-GEN', 'I004'); -- IES de Monelos

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-ADRI2-PRI5', '2023-09-01', '2023/2024', 'EXP2016028', 'C003', 5, 'PRI-GEN'),
('MAT-ADRI2-PRI6', '2024-09-02', '2024/2025', 'EXP2016028', 'C003', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-ADRI2-ESO1', '2025-09-01', '2025/2026', 'EXP2016028', 'I004', 1, 'ESO-GEN'); -- Curso actual

-- 6. Historial de Calificaciones
-- A. 5º PRIMARIA (2023/2024)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI5-LCL', 'MAT-ADRI2-PRI5', false), ('PRI5-MAT', 'MAT-ADRI2-PRI5', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI5-LCL', 'MAT-ADRI2-PRI5', 'Final Ordinaria', 7.50),
('PRI5-MAT', 'MAT-ADRI2-PRI5', 'Final Ordinaria', 7.00);

-- B. 6º PRIMARIA (2024/2025)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-ADRI2-PRI6', false), ('PRI6-MAT', 'MAT-ADRI2-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-ADRI2-PRI6', 'Final Ordinaria', 7.00),
('PRI6-MAT', 'MAT-ADRI2-PRI6', 'Final Ordinaria', 7.50);

-- C. 1º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-ADRI2-ESO1', false), ('ESO1-MAT', 'MAT-ADRI2-ESO1', false), ('ESO1-GH', 'MAT-ADRI2-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-ADRI2-ESO1', '1ª Evaluación', 7.00), -- Notable
('ESO1-MAT', 'MAT-ADRI2-ESO1', '1ª Evaluación', 7.50), -- Notable alto
('ESO1-GH',  'MAT-ADRI2-ESO1', '1ª Evaluación', 7.00); -- Notable
