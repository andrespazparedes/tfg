-- CASO DE ESTUDIO 5: LUCÍA SEOANE MÉNDEZ (ALUMNA DE RIESGO - ABANDONO ESCOLAR TEMPRANO EN 1º BACHILLERATO)
-- Archivo: alumno_5_decision.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsable Legal (Carmen Méndez Souto y Alberto Seoane Fraga)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP005', 'Carmen Méndez Souto', 'Alberto Seoane Fraga', '644111222', '644222333', 'carmen.mendez@email.com', 'alberto.seoane@email.com', 'Rúa Juan Flórez 88, 2ºC, CP 15005, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos medios-bajos estables y 1 ordenador compartido)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP005', '2015-09-12', 20000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3), -- Encuesta en Infantil
('RESP005', '2020-09-15', 19000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3), -- Encuesta en Primaria
('RESP005', '2022-09-10', 18500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3); -- Encuesta en ESO

-- 3. Expediente de la Estudiante (Nacida en 2009 para estar en edad de Bachillerato)
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015005', '22334455E', 'Lucía Seoane Méndez', '2009-07-08', 'lucia.seoane@alumno.com', 'RESP005');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015005', '2015-06-14', 1, 'INF-GEN', 'C005'), -- CEIP Ramón de la Sagra
('EXP2015005', '2021-07-03', 1, 'ESO-GEN', 'I001'), -- IES Eusebio da Guarda (ESO)
('EXP2015005', '2025-06-25', 1, 'BAC-CIEN', 'I001'); -- IES Eusebio da Guarda (Bachillerato)

-- 5. Historial Longitudinal de Matrículas Anuales (Aprueba la ESO pero colapsa en Bachillerato)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Infantil (CEIP Ramón de la Sagra)
('MAT-LUC-INF3', '2014-09-01', '2014/2015', 'EXP2015005', 'C005', 3, 'INF-GEN'), -- 3º Infantil
-- Educación Primaria (CEIP Ramón de la Sagra)
('MAT-LUC-PRI1', '2015-09-03', '2015/2016', 'EXP2015005', 'C005', 1, 'PRI-GEN'), -- 1º Primaria
('MAT-LUC-PRI3', '2017-09-02', '2017/2018', 'EXP2015005', 'C005', 3, 'PRI-GEN'), -- 3º Primaria
('MAT-LUC-PRI6', '2020-09-01', '2020/2021', 'EXP2015005', 'C005', 6, 'PRI-GEN'), -- 6º Primaria
-- Educación Secundaria - ESO (IES Eusebio da Guarda)
('MAT-LUC-ESO1', '2021-09-02', '2021/2022', 'EXP2015005', 'I001', 1, 'ESO-GEN'), -- 1º ESO
('MAT-LUC-ESO2', '2022-09-01', '2022/2023', 'EXP2015005', 'I001', 2, 'ESO-GEN'), -- 2º ESO
('MAT-LUC-ESO3', '2023-09-01', '2023/2024', 'EXP2015005', 'I001', 3, 'ESO-GEN'), -- 3º ESO
('MAT-LUC-ESO4', '2024-09-01', '2024/2025', 'EXP2015005', 'I001', 4, 'ESO-GEN'), -- 4º ESO (Titula raspada en Extraordinaria, media 5.0)
-- Bachillerato (IES Eusebio da Guarda - Colapso y Deserción)
('MAT-LUC-BAC1', '2025-09-01', '2025/2026', 'EXP2015005', 'I001', 1, 'BAC-CIEN'); -- 1º Bachillerato (Curso actual / Abandona)

-- 6. Historial de Calificaciones
-- A. 4º ESO (2024/2025 - Titulación muy justa en convocatoria extraordinaria)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO4-LCL', 'MAT-LUC-ESO4', false), ('ESO4-MATE', 'MAT-LUC-ESO4', false), ('ESO4-ING', 'MAT-LUC-ESO4', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO4-LCL', 'MAT-LUC-ESO4', 'Final Ordinaria', 5.00),
('ESO4-MATE', 'MAT-LUC-ESO4', 'Final Ordinaria', 5.00),
('ESO4-ING',  'MAT-LUC-ESO4', 'Final Ordinaria', 5.00);

-- B. 1º BACHILLERATO - CURSO ACTUAL (2025/2026 - Fracaso total y baja por abandono el 15/11/2025)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('BAC1-LCL', 'MAT-LUC-BAC1', false), ('BAC1-MAT1', 'MAT-LUC-BAC1', false), ('BAC1-FQ', 'MAT-LUC-BAC1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('BAC1-LCL', 'MAT-LUC-BAC1', '1ª Evaluación', 3.00), -- Suspenso por inasistencia y colapso
('BAC1-MAT1', 'MAT-LUC-BAC1', '1ª Evaluación', 2.00), -- Suspenso
('BAC1-FQ',  'MAT-LUC-BAC1', '1ª Evaluación', 1.50); -- Suspenso
