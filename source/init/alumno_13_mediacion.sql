-- CASO DE ESTUDIO 13: SONIA SALAZAR GIMÉNEZ (MEDIACIÓN INTERCULTURAL Y PREVENCIÓN DE ABANDONO)
-- Archivo: alumno_13_mediacion.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsable Legal (Samuel Salazar Giménez y Sara Giménez Montoya)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP013', 'Samuel Salazar Giménez', 'Sara Giménez Montoya', '600130011', '600130022', 'samuel.salazar@email.com', 'sara.gimenez@email.com', 'Rúa Barcelona 65, 3º Der, CP 15011, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan alta vulnerabilidad, hogar numeroso e ingresos inestables)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP013', '2023-09-10', 11500.00, true, 'Estudios Primarios', 'Estudios Primarios', 1, 6), -- Encuesta en 5º Primaria
('RESP013', '2025-09-12', 11000.00, true, 'Estudios Primarios', 'Estudios Primarios', 1, 6); -- Encuesta en 1º ESO (Al inicio del curso de transición)

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015013', '00112233M', 'Sonia Salazar Giménez', '2013-03-24', 'sonia.salazar@alumno.com', 'RESP013');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015013', '2023-06-15', 5, 'PRI-GEN', 'C004'), -- Admitida en 5º de Primaria en CEIP Alborada
('EXP2015013', '2025-07-03', 1, 'ESO-GEN', 'I003'); -- Admitida en 1º ESO en IES Agra do Orzán

-- 5. Historial Longitudinal de Matrículas Anuales (Transición a ESO con absentismo inicial controlado por mediación)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria (CEIP Alborada)
('MAT-SONI-PRI5', '2023-09-01', '2023/2024', 'EXP2015013', 'C004', 5, 'PRI-GEN'), -- 5º Primaria
('MAT-SONI-PRI6', '2024-09-02', '2024/2025', 'EXP2015013', 'C004', 6, 'PRI-GEN'), -- 6º Primaria
-- Educación Secundaria - ESO (IES Agra do Orzán - Curso Actual)
('MAT-SONI-ESO1', '2025-09-01', '2025/2026', 'EXP2015013', 'I003',     1, 'ESO-GEN'); -- 1º ESO (Intervención de mediación por absentismo de rol doméstico)

-- 6. Adaptación Curricular / Mediación Intercultural (Activada en 1º ESO por absentismo del 15% por roles domésticos tradicionales)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP013', '2025-10-10', 'Mediación Social - Interculturalidad', 'Se activa plan de mediación socioeducativa e intercultural con mediador de zona ante absentismo escolar no justificado del 15% (dedicación de la menor al cuidado y labores del hogar familiar). Se acuerdan pautas con los tutores para garantizar la asiduidad diaria y asistencia al programa de refuerzo escolar vespertino.', 'EXP2015013');

-- Vinculamos la mediación a las asignaturas básicas instrumentales adaptadas
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP013', 'ESO1-MAT'),
('ADAP013', 'ESO1-LCL');

-- 7. Historial de Calificaciones
-- A. 5º PRIMARIA (2023/2024 - Rendimiento medio regular estable)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI5-LCL', 'MAT-SONI-PRI5', false), 
('PRI5-MAT', 'MAT-SONI-PRI5', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI5-LCL', 'MAT-SONI-PRI5', 'Final Ordinaria', 5.50),
('PRI5-MAT', 'MAT-SONI-PRI5', 'Final Ordinaria', 6.00);

-- B. 6º PRIMARIA (2024/2025 - Cierre de la etapa primaria correcto)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-SONI-PRI6', false), 
('PRI6-MAT', 'MAT-SONI-PRI6', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-SONI-PRI6', 'Final Ordinaria', 5.50),
('PRI6-MAT', 'MAT-SONI-PRI6', 'Final Ordinaria', 5.50);

-- C. 1º ESO - CURSO ACTUAL (2025/2026 - Control total de asistencia tras intervención y aprobados holgados en 1ª Ev)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-SONI-ESO1', false), 
('ESO1-MAT', 'MAT-SONI-ESO1', false),
('ESO1-GH',  'MAT-SONI-ESO1', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-SONI-ESO1', '1ª Evaluación', 5.50), -- Aprobado estable
('ESO1-MAT', 'MAT-SONI-ESO1', '1ª Evaluación', 5.00), -- Aprobado raspado
('ESO1-GH',  'MAT-SONI-ESO1', '1ª Evaluación', 5.50); -- Aprobado estable
