-- CASO DE ESTUDIO 50: IRIS ROMERO GÓMEZ (ALUMNA EN RIESGO ALTO / ACOGIMIENTO RESIDENCIAL / ABSENTISMO FLUCTUANTE / APOYO SOCIAL ACTIVO)
-- Archivo: alumno_50_apoyo_iris.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsable Legal (Xunta de Galicia - Centro de Acogimiento Residencial CP Adormideras)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP050', 'Xunta de Galicia (Familia)', 'Centro Acogimiento Adormideras', '981005500', NULL, 'acogimiento.adormideras@xunta.gal', NULL, 'Rúa de la Dársena 2, CP 15002, A Coruña', true);

-- 2. Encuestas Socioeconómicas Históricas (Bajos recursos asignados al expediente de tutela pública)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP050', '2024-09-10', 9500.00, true, 'Estudios Primarios', NULL, 1, 1), -- Tutelada, ingresos simbólicos de manutención
('RESP050', '2025-09-11', 9500.00, true, 'Estudios Primarios', NULL, 1, 1);

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2016050', '78901246W', 'Iris Romero Gómez', '2013-10-09', 'iris.romero@alumno.com', 'RESP050');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2016050', '2024-06-15', 6, 'PRI-GEN', 'C006'), -- CEIP Cidade Vella
('EXP2016050', '2025-07-03', 1, 'ESO-GEN', 'I005'); -- IES Adormideras

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-IRIS-PRI6', '2024-09-02', '2024/2025', 'EXP2016050', 'C006', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-IRIS-ESO1', '2025-09-01', '2025/2026', 'EXP2016050', 'I005', 1, 'ESO-GEN'); -- Curso actual

-- 6. Adaptación Curricular / Plan de Inclusión para Alumnos Tutelados (Activado al ingreso en el centro de acogimiento por inestabilidad emocional y absentismo fluctuante)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP050', '2025-10-10', 'Apoyo Educativo - Acogimiento Residencial', 'Estudiante bajo la tutela legal de la Xunta de Galicia en régimen de acogimiento residencial. Presenta inestabilidad emocional grave reflejada en absentismo escolar fluctuante y problemas de socialización. Se activa plan de compensación educativa y coordinación semanal con el equipo de educadores del centro de menores.', 'EXP2016050');

-- Relacionamos la adaptación con las asignaturas instrumentales troncales adaptadas en 1º de ESO
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP050', 'ESO1-LCL'),
('ADAP050', 'ESO1-MAT');

-- 7. Historial de Calificaciones
-- A. 6º PRIMARIA (2024/2025 - Rendimiento condicionado por el desapego escolar inicial)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-IRIS-PRI6', false), ('PRI6-MAT', 'MAT-IRIS-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-IRIS-PRI6', 'Final Ordinaria', 5.00), -- Aprobado muy justo
('PRI6-MAT', 'MAT-IRIS-PRI6', 'Final Ordinaria', 4.50); -- Aprobado en extraordinaria

-- B. 1º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación - Rendimiento bajo pero estabilizándose con el apoyo activo)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-IRIS-ESO1', false), ('ESO1-MAT', 'MAT-IRIS-ESO1', false), ('ESO1-ING', 'MAT-IRIS-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-IRIS-ESO1', '1ª Evaluación', 5.00), -- Aprobado justo
('ESO1-MAT', 'MAT-IRIS-ESO1', '1ª Evaluación', 4.00), -- Suspenso por inasistencia transitoria
('ESO1-ING', 'MAT-IRIS-ESO1', '1ª Evaluación', 5.00); -- Aprobado justo
