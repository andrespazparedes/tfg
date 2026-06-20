-- CASO DE ESTUDIO 3: CLARA SUÁREZ BLANCO (ALUMNA DE CONTROL - ÉXITO POSTOBLIGATORIO Y FP SUPERIOR)
-- Archivo: alumno_3_intervencion.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsable Legal (Manuel Suárez Otero y Elena Blanco Sanz)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP003', 'Manuel Suárez Otero', 'Elena Blanco Sanz', '622333444', '633444555', 'manuel.suarez@email.com', 'elena.blanco@email.com', 'Rúa Ancha 7, 2ºA, CP 15001, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Clase media con excelentes recursos informáticos)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP003', '2017-09-12', 24500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 4), -- Encuesta en Primaria
('RESP003', '2019-09-12', 26500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 3, 4); -- Encuesta en ESO

-- 3. Expediente del Estudiante (Nacida en 2007, ha finalizado Bachillerato con éxito)
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2014003', '56781234C', 'Clara Suárez Blanco', '2007-02-12', 'clara.suarez@alumno.com', 'RESP003');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2014003', '2017-06-15', 5, 'PRI-GEN', 'C005'), -- CEIP Ramón de la Sagra
('EXP2014003', '2019-07-03', 1, 'ESO-GEN', 'I002'), -- IES Fernando Wirtz Suárez
('EXP2014003', '2023-06-25', 1, 'BAC-CIEN', 'I002'), -- Bachillerato
('EXP2014003', '2025-06-28', 1, 'FPS-DAW', 'I002');  -- FP Grado Superior

-- 5. Historial Longitudinal de Matrículas Anuales (Trayectoria de Éxito hasta Grado Superior)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-CLAR3-PRI5', '2017-09-01', '2017/2018', 'EXP2014003', 'C005', 5, 'PRI-GEN'),
('MAT-CLAR3-PRI6', '2018-09-02', '2018/2019', 'EXP2014003', 'C005', 6, 'PRI-GEN'),
-- Educación Secundaria Obligatoria (ESO)
('MAT-CLAR3-ESO1', '2019-09-01', '2019/2020', 'EXP2014003', 'I002', 1, 'ESO-GEN'),
('MAT-CLAR3-ESO2', '2020-09-01', '2020/2021', 'EXP2014003', 'I002', 2, 'ESO-GEN'),
('MAT-CLAR3-ESO3', '2021-09-01', '2021/2022', 'EXP2014003', 'I002', 3, 'ESO-GEN'),
('MAT-CLAR3-ESO4', '2022-09-01', '2022/2023', 'EXP2014003', 'I002', 4, 'ESO-GEN'), -- Gradúa con 16 años
-- Educación Bachillerato (Ciencias)
('MAT-CLAR3-BAC1', '2023-09-01', '2023/2024', 'EXP2014003', 'I002', 1, 'BAC-CIEN'),
('MAT-CLAR3-BAC2', '2024-09-02', '2024/2025', 'EXP2014003', 'I002', 2, 'BAC-CIEN'), -- Gradúa en Bachillerato con 18 años
-- FP Grado Superior (DAW)
('MAT-CLAR3-DAW1', '2025-09-01', '2025/2026', 'EXP2014003', 'I002', 1, 'FPS-DAW'); -- Curso actual (FP Superior)

-- 6. Historial de Calificaciones
-- A. 2º BACHILLERATO (2024/2025 - Éxito con notas notables)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('BAC2-LCL', 'MAT-CLAR3-BAC2', false), ('BAC2-MAT2', 'MAT-CLAR3-BAC2', false), ('BAC2-HIS', 'MAT-CLAR3-BAC2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('BAC2-LCL', 'MAT-CLAR3-BAC2', 'Final Ordinaria', 7.50),
('BAC2-MAT2', 'MAT-CLAR3-BAC2', 'Final Ordinaria', 7.00),
('BAC2-HIS',  'MAT-CLAR3-BAC2', 'Final Ordinaria', 8.00);

-- B. 1º FP GRADO SUPERIOR (DAW) - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('FPS-DAW-PROG', 'MAT-CLAR3-DAW1', false), ('FPS-DAW-BD', 'MAT-CLAR3-DAW1', false), ('FPS-DAW-ED', 'MAT-CLAR3-DAW1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('FPS-DAW-PROG', 'MAT-CLAR3-DAW1', '1ª Evaluación', 8.00), -- Notable
('FPS-DAW-BD',   'MAT-CLAR3-DAW1', '1ª Evaluación', 8.50), -- Notable alto
('FPS-DAW-ED',   'MAT-CLAR3-DAW1', '1ª Evaluación', 9.00); -- Sobresaliente
