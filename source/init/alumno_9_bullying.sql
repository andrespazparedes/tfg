-- CASO DE ESTUDIO 9: MARTÍN REY OTERO (ACOSO ESCOLAR / BULLYING Y FOBIA ESCOLAR)
-- Archivo: alumno_9_bullying.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Fernando Rey Iglesias y Beatriz Otero Castro)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP009', 'Fernando Rey Iglesias', 'Beatriz Otero Castro', '600090011', '600090022', 'fernando.rey@email.com', 'beatriz.otero@email.com', 'Rúa Juan Flórez 12, 4º B, CP 15004, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan estabilidad económica de clase media de A Coruña)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP009', '2018-09-10', 27000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3), -- Encuesta en Primaria
('RESP009', '2025-09-12', 26500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015009', '66778899I', 'Martín Rey Otero', '2012-11-12', 'martin.rey@alumno.com', 'RESP009');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015009', '2015-06-12', 1, 'INF-GEN', 'C005'), -- Admitido en Infantil en CEIP Ramón de la Sagra
('EXP2015009', '2024-07-04', 1, 'ESO-GEN', 'I002'); -- Admitido en 1º ESO en IES Fernando Wirtz Suárez

-- 5. Historial Longitudinal de Matrículas Anuales (Historial brillante y descalabro gradual en ESO)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Infantil (CEIP Ramón de la Sagra)
('MAT-MART-INF3', '2017-09-01', '2017/2018', 'EXP2015009', 'C005', 3, 'INF-GEN'), -- 3º Infantil
-- Educación Primaria (CEIP Ramón de la Sagra)
('MAT-MART-PRI1', '2018-09-03', '2018/2019', 'EXP2015009', 'C005', 1, 'PRI-GEN'), -- 1º Primaria
('MAT-MART-PRI6', '2023-09-01', '2023/2024', 'EXP2015009', 'C005', 6, 'PRI-GEN'), -- 6º Primaria
-- Educación Secundaria - ESO (IES Fernando Wirtz Suárez)
('MAT-MART-ESO1', '2024-09-02', '2024/2025', 'EXP2015009', 'I002',     1, 'ESO-GEN'), -- 1º ESO (Primeros indicios de bullying)
('MAT-MART-ESO2', '2025-09-01', '2025/2026', 'EXP2015009', 'I002',     2, 'ESO-GEN'); -- 2º ESO (Curso actual, colapso)

-- 6. Adaptación Curricular / Protocolo de Convivencia (Activado a mitad de 2º ESO por Bullying y Fobia Escolar)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP009', '2025-11-18', 'Apoyo Educativo / Protocolo Convivencia', 'Se activa el protocolo oficial contra el Acoso Escolar (Bullying) por aislamiento y acoso grupal. La alumna registra fobia escolar manifestada en absentismo selectivo (16%) y crisis de ansiedad matutinas. Se asocian medidas de flexibilización y apoyo terapéutico coordinado con salud mental.', 'EXP2015009');

-- Vinculamos la intervención con las materias troncales afectadas por el colapso cognitivo y falta de pruebas
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP009', 'ESO2-LCL'),
('ADAP009', 'ESO2-MAT'),
('ADAP009', 'ESO2-FQ');

-- 7. Historial de Calificaciones
-- A. 3º INFANTIL (2017/2018 - Excelente)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('INF3-CRE', 'MAT-MART-INF3', false), ('INF3-DES', 'MAT-MART-INF3', false), ('INF3-COM', 'MAT-MART-INF3', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('INF3-CRE', 'MAT-MART-INF3', 'Final Ordinaria', 8.50),
('INF3-DES', 'MAT-MART-INF3', 'Final Ordinaria', 9.00),
('INF3-COM', 'MAT-MART-INF3', 'Final Ordinaria', 8.50);

-- B. 1º PRIMARIA (2018/2019)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI1-LCL', 'MAT-MART-PRI1', false), ('PRI1-MAT', 'MAT-MART-PRI1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI1-LCL', 'MAT-MART-PRI1', 'Final Ordinaria', 7.50),
('PRI1-MAT', 'MAT-MART-PRI1', 'Final Ordinaria', 8.00);

-- C. 6º PRIMARIA (2023/2024 - Rendimiento notable-alto consolidado)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-MART-PRI6', false), ('PRI6-MAT', 'MAT-MART-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-MART-PRI6', 'Final Ordinaria', 7.50),
('PRI6-MAT', 'MAT-MART-PRI6', 'Final Ordinaria', 7.00);

-- D. 1º ESO (2024/2025 - Inicio del bullying: caída del notable a aprobados raspados en junio)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-MART-ESO1', false), ('ESO1-MAT', 'MAT-MART-ESO1', false), ('ESO1-GH', 'MAT-MART-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-MART-ESO1', 'Final Ordinaria', 5.00),
('ESO1-MAT', 'MAT-MART-ESO1', 'Final Ordinaria', 5.50),
('ESO1-GH',  'MAT-MART-ESO1', 'Final Ordinaria', 5.00);

-- E. 2º ESO - CURSO ACTUAL (2025/2026 - Colapso absoluto por fobia escolar y ansiedad en 1ª Ev)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-MART-ESO2', false),
('ESO2-MAT', 'MAT-MART-ESO2', false),
('ESO2-FQ',  'MAT-MART-ESO2', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-MART-ESO2', '1ª Evaluación', 3.00), -- Suspenso severo
('ESO2-MAT', 'MAT-MART-ESO2', '1ª Evaluación', 2.50), -- Suspenso severo por crisis de pánico en el examen
('ESO2-FQ',  'MAT-MART-ESO2', '1ª Evaluación', 3.00); -- Suspenso severo
