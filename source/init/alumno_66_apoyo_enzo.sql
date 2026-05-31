-- CASO DE ESTUDIO 66: ENZO CASTRO OTERO (ALUMNO CON ABANDONO CONSUMADO A LOS 16 AÑOS POR INCORPORACIÓN A ECONOMÍA INFORMAL FAMILIAR)
-- Archivo: alumno_66_apoyo_enzo.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsable Legal (Juan Castro Blanco)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP066', 'Juan Castro Blanco', NULL, '600660011', NULL, 'juan.castro.b@email.com', NULL, 'Rúa Agra do Orzán 122, CP 15010, A Coruña', true);

-- 2. Encuestas Socioeconómicas Históricas (Hogar de extrema vulnerabilidad y brecha digital total)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP066', '2022-09-10', 11000.00, false, 'Estudios Primarios', NULL, 0, 4), -- Encuesta en Primaria
('RESP066', '2025-09-12', 10500.00, false, 'Estudios Primarios', NULL, 0, 4); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2010066', '78901255F', 'Enzo Castro Otero', '2010-03-15', 'enzo.castro.ot@alumno.com', 'RESP066');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2010066', '2021-06-15', 6, 'PRI-GEN', 'C002'), -- CEIP María Pita
('EXP2010066', '2022-07-04', 1, 'ESO-GEN', 'I003'); -- IES Agra do Orzán

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-ENZ3-PRI6', '2021-09-01', '2021/2022', 'EXP2010066', 'C002', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-ENZ3-ESO1', '2022-09-01', '2022/2023', 'EXP2010066', 'I003',     1, 'ESO-GEN'),
('MAT-ENZ3-ESO2', '2023-09-01', '2023/2024', 'EXP2010066', 'I003',     2, 'ESO-GEN'),
('MAT-ENZ3-ESO3', '2024-09-02', '2024/2025', 'EXP2010066', 'I003',     3, 'ESO-GEN'),
('MAT-ENZ3-ESO4', '2025-09-01', '2025/2026', 'EXP2010066', 'I003',     4, 'ESO-GEN'); -- Curso de abandono

-- 6. Adaptación Curricular / Intento de Retención por Absentismo Familiar (Activado en 4º de ESO antes del cese de asistencia)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP066', '2025-10-15', 'Apoyo Educativo - Prevención de Absentismo por Trabajo', 'Estudiante al cumplir los 16 años registra cese absoluto de asistencia a clase (absentismo >60% no justificado). La mediación escolar confirma la incorporación definitiva del menor al mercado laboral informal en el negocio ambulante familiar. Se activa protocolo oficial de absentismo crónico con derivación a inspección, consumando la situación de Abandono Escolar Temprano (AET).', 'EXP2010066');

-- Relacionamos la adaptación con materias de 4º ESO
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP066', 'ESO4-LCL'),
('ADAP066', 'ESO4-MATE');

-- 7. Historial de Calificaciones
-- A. 6º PRIMARIA (2021/2022)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-ENZ3-PRI6', false), ('PRI6-MAT', 'MAT-ENZ3-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-ENZ3-PRI6', 'Final Ordinaria', 5.00),
('PRI6-MAT', 'MAT-ENZ3-PRI6', 'Final Ordinaria', 5.00);

-- B. 1º ESO (2022/2023)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-ENZ3-ESO1', false), ('ESO1-MAT', 'MAT-ENZ3-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-ENZ3-ESO1', 'Final Ordinaria', 5.00),
('ESO1-MAT', 'MAT-ENZ3-ESO1', 'Final Ordinaria', 5.00);

-- C. 2º ESO (2023/2024)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-ENZ3-ESO2', false), ('ESO2-MAT', 'MAT-ENZ3-ESO2', false), ('ESO2-FQ', 'MAT-ENZ3-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-ENZ3-ESO2', 'Final Ordinaria', 5.00),
('ESO2-MAT', 'MAT-ENZ3-ESO2', 'Final Ordinaria', 5.00),
('ESO2-FQ',  'MAT-ENZ3-ESO2', 'Final Ordinaria', 5.00);

-- D. 3º ESO (2024/2025)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO3-LCL', 'MAT-ENZ3-ESO3', false), ('ESO3-MAT', 'MAT-ENZ3-ESO3', false), ('ESO3-FQ', 'MAT-ENZ3-ESO3', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO3-LCL', 'MAT-ENZ3-ESO3', 'Final Ordinaria', 5.00),
('ESO3-MAT', 'MAT-ENZ3-ESO3', 'Final Ordinaria', 5.00),
('ESO3-FQ',  'MAT-ENZ3-ESO3', 'Final Ordinaria', 5.00);

-- E. 4º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación - Calificaciones críticas por cese de asistencia/Abandono escolar)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO4-LCL', 'MAT-ENZ3-ESO4', false), ('ESO4-MATE', 'MAT-ENZ3-ESO4', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO4-LCL',  'MAT-ENZ3-ESO4', '1ª Evaluación', 2.00), -- Suspenso por cese
('ESO4-MATE', 'MAT-ENZ3-ESO4', '1ª Evaluación', 1.50); -- Suspenso por cese
