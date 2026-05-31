-- CASO DE ESTUDIO 20: MARCOS BLANCO OTERO (CONFLICTIVIDAD ESCOLAR, MEDIDAS DISCIPLINARIAS Y CONVIVENCIA)
-- Archivo: alumno_20_convivencia.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (David Blanco Veiga e Irene Otero Díaz)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP020', 'David Blanco Veiga', 'Irene Otero Díaz', '600200011', '600200022', 'david.blanco@email.com', 'irene.otero@email.com', 'Rúa Juan Flórez 80, 2º B, CP 15004, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos estables de clase media-baja en A Coruña)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP020', '2023-09-10', 20000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3), -- Encuesta en Primaria
('RESP020', '2025-09-12', 19500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015020', '99887733S', 'Marcos Blanco Otero', '2012-05-24', 'marcos.blanco@alumno.com', 'RESP020');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015020', '2015-06-12', 1, 'INF-GEN', 'C005'), -- Admitido en Infantil en CEIP Ramón de la Sagra
('EXP2015020', '2024-07-04', 1, 'ESO-GEN', 'I002'); -- Admitido en 1º ESO en IES Fernando Wirtz Suárez

-- 5. Historial Longitudinal de Matrículas Anuales (Historial de conducta inestable y colapso disciplinario en Secundaria)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Infantil (CEIP Ramón de la Sagra)
('MAT-MARC-INF3', '2017-09-01', '2017/2018', 'EXP2015020', 'C005', 3, 'INF-GEN'), -- 3º Infantil
-- Educación Primaria (CEIP Ramón de la Sagra)
('MAT-MARC-PRI6', '2023-09-01', '2023/2024', 'EXP2015020', 'C005', 6, 'PRI-GEN'), -- 6º Primaria
-- Educación Secundaria - ESO (IES Fernando Wirtz Suárez)
('MAT-MARC-ESO1', '2024-09-02', '2024/2025', 'EXP2015020', 'I002',     1, 'ESO-GEN'), -- 1º ESO (14 amonestaciones escritas y 3 expulsiones)
('MAT-MARC-ESO2', '2025-09-01', '2025/2026', 'EXP2015020', 'I002',     2, 'ESO-GEN'); -- 2º ESO (Curso actual, mediación de convivencia)

-- 6. Adaptación Curricular / Contrato de Convivencia (Activada a finales de la 1ª Ev de 2º ESO por incidentes disciplinarios graves)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP020', '2025-11-18', 'Apoyo Educativo - Contrato Convivencia', 'Se activa Contrato de Convivencia y Compromiso de Mediación tras sanciones oficiales repetidas. Se sustituyen expulsiones domiciliarias por permanencia formativa tutelada en el Aula de Convivencia del centro para tareas académicas y apoyo psicopedagógico individual.', 'EXP2015020');

-- Vinculamos la adaptación con las asignaturas instrumentales troncales afectadas por el absentismo de sanción
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP020', 'ESO2-LCL'),
('ADAP020', 'ESO2-MAT');

-- 7. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024 - Rendimiento regular con llamadas de atención leves)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-MARC-PRI6', false), 
('PRI6-MAT', 'MAT-MARC-PRI6', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-MARC-PRI6', 'Final Ordinaria', 5.50),
('PRI6-MAT', 'MAT-MARC-PRI6', 'Final Ordinaria', 6.00);

-- B. 1º ESO (2024/2025 - Caída de notas a aprobados raspados en junio por absentismo forzado de sanción)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-MARC-ESO1', false), 
('ESO1-MAT', 'MAT-MARC-ESO1', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-MARC-ESO1', 'Final Ordinaria', 5.00), -- Aprobado raspado
('ESO1-MAT', 'MAT-MARC-ESO1', 'Final Ordinaria', 5.00); -- Aprobado raspado

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - Doble suspenso en 1ª Ev por expulsión temporal y no realización de exámenes)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-MARC-ESO2', false), -- Humanidades
('ESO2-MAT', 'MAT-MARC-ESO2', false), -- Ciencias instrumentales
('ESO2-TEC', 'MAT-MARC-ESO2', false); -- Tecnología

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-MARC-ESO2', '1ª Evaluación', 4.00), -- Suspenso por inasistencia al examen por expulsión temporal
('ESO2-MAT', 'MAT-MARC-ESO2', '1ª Evaluación', 4.00), -- Suspenso por inasistencia al examen por expulsión temporal
('ESO2-TEC', 'MAT-MARC-ESO2', '1ª Evaluación', 5.50); -- Aprobado regular en taller práctico
