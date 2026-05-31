-- CASO DE ESTUDIO 38: GABRIEL ROMERO BLANCO (ALUMNO CON ENFERMEDAD PROLONGADA Y AUSENCIA DE APOYO SAED TEMPRANO - RIESGO TRANSITORIO)
-- Archivo: alumno_38_apoyo_gabriel.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Pedro Romero Castro y Ana Blanco Otero)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP038', 'Pedro Romero Castro', 'Ana Blanco Otero', '600380011', '600380022', 'pedro.romero@email.com', 'ana.blanco.o@email.com', 'Rúa Barcelona 33, 4º C, CP 15011, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Hogar de ingresos ajustados de clase baja-media)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP038', '2023-09-10', 18500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 4), -- Encuesta en Primaria
('RESP038', '2025-09-11', 19000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 4); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015038', '89012345G', 'Gabriel Romero Blanco', '2012-10-09', 'gabriel.romero@alumno.com', 'RESP038');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015038', '2023-06-15', 6, 'PRI-GEN', 'C004'), -- CEIP Alborada
('EXP2015038', '2024-07-04', 1, 'ESO-GEN', 'I003'); -- IES Agra do Orzán

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-GABR-PRI6', '2023-09-01', '2023/2024', 'EXP2015038', 'C004', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-GABR-ESO1', '2024-09-02', '2024/2025', 'EXP2015038', 'I003', 1, 'ESO-GEN'),
('MAT-GABR-ESO2', '2025-09-01', '2025/2026', 'EXP2015038', 'I003', 2, 'ESO-GEN'); -- Curso actual

-- 6. Adaptación Curricular / Apoyo por Convalecencia Médica (Activada tras hospitalización por fractura grave)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP038', '2025-10-15', 'Apoyo Educativo - Convalecencia Médica', 'Estudiante sufrió una fractura múltiple de fémur con hospitalización y posterior convalecencia en casa (más de 2 meses). Debido al retraso del alta del SAED (Servicio de Apoyo Educativo Domiciliario), se activa una adaptación metodológica de flexibilización y reprogramación de exámenes para evitar la pérdida del curso por absentismo justificado.', 'EXP2015038');

-- Vinculamos la adaptación con las asignaturas de 2º ESO afectadas por la convalecencia
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP038', 'ESO2-LCL'),
('ADAP038', 'ESO2-MAT'),
('ADAP038', 'ESO2-FQ');

-- 7. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024 - Rendimiento aceptable/medio)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-GABR-PRI6', false), ('PRI6-MAT', 'MAT-GABR-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-GABR-PRI6', 'Final Ordinaria', 6.50),
('PRI6-MAT', 'MAT-GABR-PRI6', 'Final Ordinaria', 6.00);

-- B. 1º ESO (2024/2025 - Transición aprobada con notas medias)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-GABR-ESO1', false), ('ESO1-MAT', 'MAT-GABR-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-GABR-ESO1', 'Final Ordinaria', 6.00),
('ESO1-MAT', 'MAT-GABR-ESO1', 'Final Ordinaria', 5.50);

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación - Bajada drástica por convalecencia prolongada)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-GABR-ESO2', false), ('ESO2-MAT', 'MAT-GABR-ESO2', false), ('ESO2-FQ', 'MAT-GABR-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-GABR-ESO2', '1ª Evaluación', 4.00), -- Suspenso por retraso en entregas
('ESO2-MAT', 'MAT-GABR-ESO2', '1ª Evaluación', 3.50), -- Suspenso severo por inasistencia justificada
('ESO2-FQ',  'MAT-GABR-ESO2', '1ª Evaluación', 4.00); -- Suspenso por falta de laboratorio práctico
