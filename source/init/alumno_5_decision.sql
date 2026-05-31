-- CASO DE ESTUDIO 5: LUCÍA SEOANE MÉNDEZ (ALUMNA DE PERFIL MEDIO - MOMENTO DE DECISIÓN EN 2º ESO)
-- Archivo: alumno_5_decision.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsable Legal (Carmen Méndez Souto y Alberto Seoane Fraga)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP005', 'Carmen Méndez Souto', 'Alberto Seoane Fraga', '644111222', '644222333', 'carmen.mendez@email.com', 'alberto.seoane@email.com', 'Rúa Juan Flórez 88, 2ºC, CP 15005, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos medios-bajos estables)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP005', '2015-09-12', 20000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3), -- Encuesta en Infantil
('RESP005', '2020-09-15', 21000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3), -- Encuesta en Primaria
('RESP005', '2025-09-10', 21500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3); -- Encuesta en ESO

-- 3. Expediente de la Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015005', '22334455E', 'Lucía Seoane Méndez', '2012-07-08', 'lucia.seoane@alumno.com', 'RESP005');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015005', '2015-06-14', 1, 'INF-GEN', 'C005'), -- Admitida en Infantil en CEIP Ramón de la Sagra
('EXP2015005', '2024-07-03', 1, 'ESO-GEN', 'I001'); -- Admitida en ESO en IES Eusebio da Guarda

-- 5. Historial Longitudinal de Matrículas Anuales (Progreso limpio pero con dificultades recientes)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Infantil (CEIP Ramón de la Sagra)
('MAT-LUC-INF3', '2017-09-01', '2017/2018', 'EXP2015005', 'C005', 3, 'INF-GEN'), -- 3º Infantil
-- Educación Primaria (CEIP Ramón de la Sagra)
('MAT-LUC-PRI1', '2018-09-03', '2018/2019', 'EXP2015005', 'C005', 1, 'PRI-GEN'), -- 1º Primaria
('MAT-LUC-PRI3', '2020-09-02', '2020/2021', 'EXP2015005', 'C005', 3, 'PRI-GEN'), -- 3º Primaria
('MAT-LUC-PRI6', '2023-09-01', '2023/2024', 'EXP2015005', 'C005', 6, 'PRI-GEN'), -- 6º Primaria
-- Educación Secundaria - ESO (IES Eusebio da Guarda)
('MAT-LUC-ESO1', '2024-09-02', '2024/2025', 'EXP2015005', 'I001', 1, 'ESO-GEN'), -- 1º ESO
('MAT-LUC-ESO2', '2025-09-01', '2025/2026', 'EXP2015005', 'I001', 2, 'ESO-GEN'); -- 2º ESO (Curso actual)

-- 6. Historial de Calificaciones
-- A. 3º INFANTIL (2017/2018)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('INF3-CRE', 'MAT-LUC-INF3', false), ('INF3-DES', 'MAT-LUC-INF3', false), ('INF3-COM', 'MAT-LUC-INF3', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('INF3-CRE', 'MAT-LUC-INF3', 'Final Ordinaria', 7.50),
('INF3-DES', 'MAT-LUC-INF3', 'Final Ordinaria', 7.00),
('INF3-COM', 'MAT-LUC-INF3', 'Final Ordinaria', 8.00);

-- B. 1º PRIMARIA (2018/2019)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI1-LCL', 'MAT-LUC-PRI1', false), ('PRI1-MAT', 'MAT-LUC-PRI1', false), ('PRI1-ING', 'MAT-LUC-PRI1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI1-LCL', 'MAT-LUC-PRI1', 'Final Ordinaria', 7.00),
('PRI1-MAT', 'MAT-LUC-PRI1', 'Final Ordinaria', 6.50),
('PRI1-ING', 'MAT-LUC-PRI1', 'Final Ordinaria', 7.00);

-- C. 3º PRIMARIA (2020/2021)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI3-LCL', 'MAT-LUC-PRI3', false), ('PRI3-MAT', 'MAT-LUC-PRI3', false), ('PRI3-ING', 'MAT-LUC-PRI3', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI3-LCL', 'MAT-LUC-PRI3', 'Final Ordinaria', 7.00),
('PRI3-MAT', 'MAT-LUC-PRI3', 'Final Ordinaria', 6.00),
('PRI3-ING', 'MAT-LUC-PRI3', 'Final Ordinaria', 7.50);

-- D. 6º PRIMARIA (2023/2024 - Cierra la etapa con un rendimiento medio estable)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-LUC-PRI6', false), ('PRI6-MAT', 'MAT-LUC-PRI6', false), ('PRI6-ING', 'MAT-LUC-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-LUC-PRI6', 'Final Ordinaria', 7.00),
('PRI6-MAT', 'MAT-LUC-PRI6', 'Final Ordinaria', 6.50),
('PRI6-ING', 'MAT-LUC-PRI6', 'Final Ordinaria', 7.00);

-- E. 1º ESO (2024/2025 - Bajada típica en el cambio de etapa)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-LUC-ESO1', false), ('ESO1-MAT', 'MAT-LUC-ESO1', false), ('ESO1-ING', 'MAT-LUC-ESO1', false), ('ESO1-GH', 'MAT-LUC-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-LUC-ESO1', 'Final Ordinaria', 6.00),
('ESO1-MAT', 'MAT-LUC-ESO1', 'Final Ordinaria', 5.50),
('ESO1-ING', 'MAT-LUC-ESO1', 'Final Ordinaria', 6.50),
('ESO1-GH',  'MAT-LUC-ESO1', 'Final Ordinaria', 6.00);

-- F. 2º ESO - CURSO ACTUAL (2025/2026 - Aparecen dificultades y suspensos en la 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-LUC-ESO2', false), ('ESO2-MAT', 'MAT-LUC-ESO2', false), ('ESO2-ING', 'MAT-LUC-ESO2', false), ('ESO2-FQ', 'MAT-LUC-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-LUC-ESO2', '1ª Evaluación', 5.50), -- Aprobado justo
('ESO2-ING', 'MAT-LUC-ESO2', '1ª Evaluación', 6.00),
('ESO2-MAT', 'MAT-LUC-ESO2', '1ª Evaluación', 4.50), -- Suspenso leve
('ESO2-FQ',  'MAT-LUC-ESO2', '1ª Evaluación', 4.00); -- Suspenso
