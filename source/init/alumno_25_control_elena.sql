-- CASO DE ESTUDIO 25: ELENA ROMERO VARELA (ALUMNA DE CONTROL - ÉXITO ESO Y FP GRADO MEDIO ACTIVO)
-- Archivo: alumno_25_control_elena.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Carlos Romero Vázquez e Irene Varela Sanz)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP025', 'Carlos Romero Vázquez', 'Irene Varela Sanz', '600250011', '600250022', 'carlos.romero@email.com', 'irene.varela@email.com', 'Rúa Barcelona 12, 1º Der, CP 15011, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos estables de clase media-baja y nula brecha digital)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP025', '2019-09-10', 23500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3), -- Encuesta en Primaria
('RESP025', '2021-09-12', 23000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante (Nacida en 2009 para estar en edad de FP Grado Medio)
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2016025', '12341234E', 'Elena Romero Varela', '2009-05-14', 'elena.romero@alumno.com', 'RESP025');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2016025', '2019-06-15', 5, 'PRI-GEN', 'C004'), -- CEIP Alborada
('EXP2016025', '2021-07-02', 1, 'ESO-GEN', 'I003'), -- IES Agra do Orzán (ESO)
('EXP2016025', '2025-06-25', 1, 'FPM-SMR', 'I002'); -- IES Fernando Wirtz (Admisión a FP de Grado Medio)

-- 5. Historial Longitudinal de Matrículas Anuales (Trayectoria Notable hacia FP)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-ELEN-PRI5', '2019-09-01', '2019/2020', 'EXP2016025', 'C004', 5, 'PRI-GEN'),
('MAT-ELEN-PRI6', '2020-09-02', '2020/2021', 'EXP2016025', 'C004', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-ELEN-ESO1', '2021-09-01', '2021/2022', 'EXP2016025', 'I003', 1, 'ESO-GEN'),
('MAT-ELEN-ESO2', '2022-09-01', '2022/2023', 'EXP2016025', 'I003', 2, 'ESO-GEN'),
('MAT-ELEN-ESO3', '2023-09-01', '2023/2024', 'EXP2016025', 'I003', 3, 'ESO-GEN'),
('MAT-ELEN-ESO4', '2024-09-02', '2024/2025', 'EXP2016025', 'I003', 4, 'ESO-GEN'), -- Gradúa a los 16 años
-- Formación Profesional Grado Medio (SMR)
('MAT-ELEN-SMR1', '2025-09-01', '2025/2026', 'EXP2016025', 'I002', 1, 'FPM-SMR'); -- 1º Grado Medio (Curso actual)

-- 6. Historial de Calificaciones
-- A. 5º PRIMARIA (2019/2020)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI5-LCL', 'MAT-ELEN-PRI5', false), ('PRI5-MAT', 'MAT-ELEN-PRI5', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI5-LCL', 'MAT-ELEN-PRI5', 'Final Ordinaria', 7.00),
('PRI5-MAT', 'MAT-ELEN-PRI5', 'Final Ordinaria', 7.50);

-- B. 4º ESO (2024/2025 - Notable en graduación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO4-LCL', 'MAT-ELEN-ESO4', false), ('ESO4-MATE', 'MAT-ELEN-ESO4', false), ('ESO4-ING', 'MAT-ELEN-ESO4', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO4-LCL', 'MAT-ELEN-ESO4', 'Final Ordinaria', 7.50),
('ESO4-MATE', 'MAT-ELEN-ESO4', 'Final Ordinaria', 7.00),
('ESO4-ING',  'MAT-ELEN-ESO4', 'Final Ordinaria', 8.00);

-- C. 1º FP GRADO MEDIO SMR - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('FPM-SMR-SO', 'MAT-ELEN-SMR1', false), ('FPM-SMR-RED', 'MAT-ELEN-SMR1', false), ('FPM-SMR-MON', 'MAT-ELEN-SMR1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('FPM-SMR-SO',  'MAT-ELEN-SMR1', '1ª Evaluación', 7.00), -- Notable
('FPM-SMR-RED', 'MAT-ELEN-SMR1', '1ª Evaluación', 7.50), -- Notable alto
('FPM-SMR-MON', 'MAT-ELEN-SMR1', '1ª Evaluación', 8.00); -- Sobresaliente
