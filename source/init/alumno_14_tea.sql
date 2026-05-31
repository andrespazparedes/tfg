-- CASO DE ESTUDIO 14: BRUNO TEIJEIRO GÓMEZ (NEAE - TEA GRADO 1 Y APOYO METODOLÓGICO)
-- Archivo: alumno_14_tea.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Gabriel Teijeiro Gómez e Inés Gómez Castro)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP014', 'Gabriel Teijeiro Gómez', 'Inés Gómez Castro', '600140011', '600140022', 'gabriel.teijeiro@email.com', 'ines.gomez@email.com', 'Rúa Juana de Vega 14, 1º Der, CP 15004, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan clase media estable y alto nivel de estudios de los padres)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP014', '2019-09-10', 28000.00, true, 'Estudios Universitarios', 'Estudios Universitarios', 2, 3), -- Encuesta en 2º Primaria (Momento del diagnóstico)
('RESP014', '2025-09-12', 27500.00, true, 'Estudios Universitarios', 'Estudios Universitarios', 2, 3); -- Encuesta en 2º ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015014', '11223344K', 'Bruno Teijeiro Gómez', '2012-05-18', 'bruno.teijeiro@alumno.com', 'RESP014');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015014', '2015-06-12', 1, 'INF-GEN', 'C001'), -- Admitido en Infantil en CEIP Emilia Pardo Bazán
('EXP2015014', '2024-07-03', 1, 'ESO-GEN', 'I001'); -- Admitido en 1º ESO en IES Eusebio da Guarda

-- 5. Historial Longitudinal de Matrículas Anuales (Historial de alto rendimiento científico y fricción adaptativa en ESO)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Infantil (CEIP Emilia Pardo Bazán)
('MAT-BRUN-INF3', '2017-09-01', '2017/2018', 'EXP2015014', 'C001', 3, 'INF-GEN'), -- 3º Infantil
-- Educación Primaria (CEIP Emilia Pardo Bazán)
('MAT-BRUN-PRI6', '2023-09-01', '2023/2024', 'EXP2015014', 'C001', 6, 'PRI-GEN'), -- 6º Primaria
-- Educación Secundaria - ESO (IES Eusebio da Guarda)
('MAT-BRUN-ESO1', '2024-09-02', '2024/2025', 'EXP2015014', 'I001', 1, 'ESO-GEN'), -- 1º ESO (Fricción adaptativa de entrada)
('MAT-BRUN-ESO2', '2025-09-01', '2025/2026', 'EXP2015014', 'I001', 2, 'ESO-GEN'); -- 2º ESO (Curso actual, estabilizado)

-- 6. Adaptación Curricular / Apoyo TEA Metodológico (Asignado en 1º de ESO ante bloqueos por sobrecarga sensorial y rúbricas grupales)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP014', '2024-10-15', 'Apoyo Educativo - TEA Metodológico', 'Estudiante con diagnóstico de TEA Grado 1 (Asperger). Registra crisis por sobrecarga sensorial en ruidos de pasillo y bloqueos severos ante trabajos grupales cooperativos obligatorios. Se prescribe Adaptación Metodológica: flexibilización de tareas grupales por individuales, estructuración visual clara de tareas y acceso a aula silenciosa.', 'EXP2015014');

-- Relacionamos la adaptación con las asignaturas instrumentales troncales adaptadas en 1º de ESO
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP014', 'ESO1-LCL'),
('ADAP014', 'ESO1-MAT');

-- 7. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024 - Rendimiento excelente e individualizado)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-BRUN-PRI6', false), 
('PRI6-MAT', 'MAT-BRUN-PRI6', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-BRUN-PRI6', 'Final Ordinaria', 7.50),
('PRI6-MAT', 'MAT-BRUN-PRI6', 'Final Ordinaria', 8.50);

-- B. 1º ESO (2024/2025 - Rendimiento notable consolidado tras la implantación de las adaptaciones metodológicas)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-BRUN-ESO1', false), 
('ESO1-MAT', 'MAT-BRUN-ESO1', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-BRUN-ESO1', 'Final Ordinaria', 7.00), -- Notable
('ESO1-MAT', 'MAT-BRUN-ESO1', 'Final Ordinaria', 8.00); -- Notable alto

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - Rendimiento sobresaliente en áreas lógicas con adaptaciones metodológicas)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-BRUN-ESO2', false),
('ESO2-MAT', 'MAT-BRUN-ESO2', false),
('ESO2-FQ',  'MAT-BRUN-ESO2', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-BRUN-ESO2', '1ª Evaluación', 7.00), -- Notable individualizado
('ESO2-MAT', 'MAT-BRUN-ESO2', '1ª Evaluación', 8.50), -- Sobresaliente
('ESO2-FQ',  'MAT-BRUN-ESO2', '1ª Evaluación', 8.00); -- Notable alto
