-- CASO DE ESTUDIO 21: LUCÍA IGLESIAS GÓMEZ (ALUMNA DE CONTROL / RENDIMIENTO ALTO-MEDIO)
-- Archivo: alumno_21_control_lucia.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Daniel Iglesias Varela y Beatriz Gómez Castro)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP021', 'Daniel Iglesias Varela', 'Beatriz Gómez Castro', '600210011', '600210022', 'daniel.iglesias@email.com', 'beatriz.gomez@email.com', 'Rúa Riego de Agua 18, 3º A, CP 15001, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos estables de clase media de A Coruña y nula brecha digital)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP021', '2023-09-10', 29000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3), -- Encuesta en Primaria
('RESP021', '2025-09-12', 28500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2016021', '12341234A', 'Lucía Iglesias Gómez', '2013-04-12', 'lucia.iglesias@alumno.com', 'RESP021');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2016021', '2023-06-15', 5, 'PRI-GEN', 'C001'), -- CEIP Emilia Pardo Bazán
('EXP2016021', '2025-07-03', 1, 'ESO-GEN', 'I001'); -- IES Eusebio da Guarda

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-LUCI-PRI5', '2023-09-01', '2023/2024', 'EXP2016021', 'C001', 5, 'PRI-GEN'),
('MAT-LUCI-PRI6', '2024-09-02', '2024/2025', 'EXP2016021', 'C001', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-LUCI-ESO1', '2025-09-01', '2025/2026', 'EXP2016021', 'I001', 1, 'ESO-GEN'); -- Curso actual

-- 6. Historial de Calificaciones
-- A. 5º PRIMARIA (2023/2024)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI5-LCL', 'MAT-LUCI-PRI5', false), ('PRI5-MAT', 'MAT-LUCI-PRI5', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI5-LCL', 'MAT-LUCI-PRI5', 'Final Ordinaria', 7.50),
('PRI5-MAT', 'MAT-LUCI-PRI5', 'Final Ordinaria', 7.00);

-- B. 6º PRIMARIA (2024/2025)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-LUCI-PRI6', false), ('PRI6-MAT', 'MAT-LUCI-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-LUCI-PRI6', 'Final Ordinaria', 8.00),
('PRI6-MAT', 'MAT-LUCI-PRI6', 'Final Ordinaria', 7.50);

-- C. 1º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-LUCI-ESO1', false), ('ESO1-MAT', 'MAT-LUCI-ESO1', false), ('ESO1-GH', 'MAT-LUCI-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-LUCI-ESO1', '1ª Evaluación', 7.50), -- Notable
('ESO1-MAT', 'MAT-LUCI-ESO1', '1ª Evaluación', 7.00), -- Notable
('ESO1-GH',  'MAT-LUCI-ESO1', '1ª Evaluación', 8.00); -- Notable alto
