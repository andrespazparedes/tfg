-- CASO DE ESTUDIO 23: SOFÍA BLANCO CASTRO (ALUMNA DE CONTROL - ÉXITO ESO Y FP GRADO MEDIO ACTIVO)
-- Archivo: alumno_23_control_sofia.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Santiago Blanco Varela y Marta Castro Otero)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP023', 'Santiago Blanco Varela', 'Marta Castro Otero', '600230011', '600230022', 'santiago.blanco@email.com', 'marta.castro@email.com', 'Rúa Juana de Vega 12, 5º Der, CP 15004, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos estables de clase media-alta y nula brecha digital)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP023', '2020-09-10', 35000.00, true, 'Estudios Universitarios', 'Estudios Universitarios', 2, 3), -- Encuesta en Primaria
('RESP023', '2022-09-12', 34000.00, true, 'Estudios Universitarios', 'Estudios Universitarios', 2, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante (Nacida en 2009 para estar en edad de FP Grado Medio)
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015023', '12341234C', 'Sofía Blanco Castro', '2009-11-05', 'sofia.blanco@alumno.com', 'RESP023');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015023', '2020-06-15', 6, 'PRI-GEN', 'C001'), -- CEIP Emilia Pardo Bazán
('EXP2015023', '2021-07-03', 1, 'ESO-GEN', 'I001'), -- IES Eusebio da Guarda
('EXP2015023', '2025-06-25', 1, 'FPM-SMR', 'I002'); -- IES Fernando Wirtz (Admisión a FP de Grado Medio)

-- 5. Historial Longitudinal de Matrículas Anuales (Trayectoria Excelente hacia FP)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-SOFI-PRI6', '2020-09-01', '2020/2021', 'EXP2015023', 'C001', 6, 'PRI-GEN'),
-- Educación Secundaria (ESO)
('MAT-SOFI-ESO1', '2021-09-02', '2021/2022', 'EXP2015023', 'I001', 1, 'ESO-GEN'),
('MAT-SOFI-ESO2', '2022-09-01', '2022/2023', 'EXP2015023', 'I001', 2, 'ESO-GEN'),
('MAT-SOFI-ESO3', '2023-09-01', '2023/2024', 'EXP2015023', 'I001', 3, 'ESO-GEN'),
('MAT-SOFI-ESO4', '2024-09-01', '2024/2025', 'EXP2015023', 'I001', 4, 'ESO-GEN'), -- Gradúa a los 16 años
-- Formación Profesional Grado Medio (SMR - IES Fernando Wirtz)
('MAT-SOFI-SMR1', '2025-09-01', '2025/2026', 'EXP2015023', 'I002', 1, 'FPM-SMR'); -- 1º Grado Medio (Curso actual)

-- 6. Historial de Calificaciones
-- A. 6º PRIMARIA (2020/2021)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-SOFI-PRI6', false), ('PRI6-MAT', 'MAT-SOFI-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-SOFI-PRI6', 'Final Ordinaria', 9.00),
('PRI6-MAT', 'MAT-SOFI-PRI6', 'Final Ordinaria', 9.50);

-- B. 4º ESO (2024/2025 - Excelente nota de graduación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO4-LCL', 'MAT-SOFI-ESO4', false), ('ESO4-MATE', 'MAT-SOFI-ESO4', false), ('ESO4-ING', 'MAT-SOFI-ESO4', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO4-LCL', 'MAT-SOFI-ESO4', 'Final Ordinaria', 9.00),
('ESO4-MATE', 'MAT-SOFI-ESO4', 'Final Ordinaria', 9.50),
('ESO4-ING',  'MAT-SOFI-ESO4', 'Final Ordinaria', 9.00);

-- C. 1º FP GRADO MEDIO SMR - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('FPM-SMR-SO', 'MAT-SOFI-SMR1', false), ('FPM-SMR-RED', 'MAT-SOFI-SMR1', false), ('FPM-SMR-MON', 'MAT-SOFI-SMR1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('FPM-SMR-SO',  'MAT-SOFI-SMR1', '1ª Evaluación', 8.50), -- Notable alto
('FPM-SMR-RED', 'MAT-SOFI-SMR1', '1ª Evaluación', 8.00), -- Notable
('FPM-SMR-MON', 'MAT-SOFI-SMR1', '1ª Evaluación', 9.00); -- Sobresaliente
