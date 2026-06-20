-- CASO DE ESTUDIO 21: LUCÍA IGLESIAS GÓMEZ (ALUMNA DE CONTROL - BACHILLERATO HUMANIDADES ACTIVO)
-- Archivo: alumno_21_control_lucia.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Daniel Iglesias Varela y Beatriz Gómez Castro)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP021', 'Daniel Iglesias Varela', 'Beatriz Gómez Castro', '600210011', '600210022', 'daniel.iglesias@email.com', 'beatriz.gomez@email.com', 'Rúa Riego de Agua 18, 3º A, CP 15001, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Clase media con conectividad completa y sin brecha digital)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP021', '2019-09-10', 29000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3), -- Encuesta en Primaria
('RESP021', '2021-09-12', 28500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante (Nacida en 2009 para estar en edad de Bachillerato)
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2016021', '12341234A', 'Lucía Iglesias Gómez', '2009-04-12', 'lucia.iglesias@alumno.com', 'RESP021');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2016021', '2019-06-15', 5, 'PRI-GEN', 'C001'), -- CEIP Emilia Pardo Bazán
('EXP2016021', '2021-07-03', 1, 'ESO-GEN', 'I001'), -- IES Eusebio da Guarda
('EXP2016021', '2025-06-26', 1, 'BAC-HCS', 'I001'); -- IES Eusebio da Guarda (Admisión a Bachillerato de Letras)

-- 5. Historial Longitudinal de Matrículas Anuales (Rendimiento Alto-Medio)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-LUCI-PRI5', '2019-09-01', '2019/2020', 'EXP2016021', 'C001', 5, 'PRI-GEN'),
('MAT-LUCI-PRI6', '2020-09-02', '2020/2021', 'EXP2016021', 'C001', 6, 'PRI-GEN'),
-- Educación Secundaria (ESO)
('MAT-LUCI-ESO1', '2021-09-01', '2021/2022', 'EXP2016021', 'I001', 1, 'ESO-GEN'),
('MAT-LUCI-ESO2', '2022-09-01', '2022/2023', 'EXP2016021', 'I001', 2, 'ESO-GEN'),
('MAT-LUCI-ESO3', '2023-09-01', '2023/2024', 'EXP2016021', 'I001', 3, 'ESO-GEN'),
('MAT-LUCI-ESO4', '2024-09-02', '2024/2025', 'EXP2016021', 'I001', 4, 'ESO-GEN'), -- Titulación Ordinaria
-- Bachillerato (Itinerario Humanidades)
('MAT-LUCI-BAC1', '2025-09-01', '2025/2026', 'EXP2016021', 'I001', 1, 'BAC-HCS'); -- Curso actual (Letras)

-- 6. Historial de Calificaciones
-- A. 5º PRIMARIA (2019/2020)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI5-LCL', 'MAT-LUCI-PRI5', false), ('PRI5-MAT', 'MAT-LUCI-PRI5', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI5-LCL', 'MAT-LUCI-PRI5', 'Final Ordinaria', 7.50),
('PRI5-MAT', 'MAT-LUCI-PRI5', 'Final Ordinaria', 7.00);

-- B. 6º PRIMARIA (2020/2021)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-LUCI-PRI6', false), ('PRI6-MAT', 'MAT-LUCI-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-LUCI-PRI6', 'Final Ordinaria', 8.00),
('PRI6-MAT', 'MAT-LUCI-PRI6', 'Final Ordinaria', 7.50);

-- C. 4º ESO (2024/2025)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO4-LCL', 'MAT-LUCI-ESO4', false), ('ESO4-LAT', 'MAT-LUCI-ESO4', false), ('ESO4-ING', 'MAT-LUCI-ESO4', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO4-LCL', 'MAT-LUCI-ESO4', 'Final Ordinaria', 7.50),
('ESO4-LAT', 'MAT-LUCI-ESO4', 'Final Ordinaria', 8.00),
('ESO4-ING',  'MAT-LUCI-ESO4', 'Final Ordinaria', 8.00);

-- D. 1º BACHILLERATO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('BAC1-LCL-H', 'MAT-LUCI-BAC1', false), ('BAC1-LAT1', 'MAT-LUCI-BAC1', false), ('BAC1-ING1-H', 'MAT-LUCI-BAC1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('BAC1-LCL-H', 'MAT-LUCI-BAC1', '1ª Evaluación', 8.00), -- Notable
('BAC1-LAT1',  'MAT-LUCI-BAC1', '1ª Evaluación', 8.50), -- Notable alto
('BAC1-ING1-H', 'MAT-LUCI-BAC1', '1ª Evaluación', 8.00); -- Notable
