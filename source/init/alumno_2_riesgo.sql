-- CASO DE ESTUDIO 2: SARA TEIJEIRO GÓMEZ (ALUMNA DE ALTO RIESGO)
-- Archivo: alumno_2_riesgo.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsable Legal (Elena Teijeiro Gómez - Madre Soltera)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP002', 'Elena Teijeiro Gómez', NULL, '611222333', NULL, 'elena.teijeiro@email.com', NULL, 'Rúa Pescadores 45, Bajo C, CP 15002, A Coruña', true);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos bajos y brecha digital extrema)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP002', '2022-09-11', 13000.00, false, 'Estudios Primarios', NULL, 1, 3), -- Encuesta en Primaria (Sin Internet)
('RESP002', '2025-09-11', 11500.00, false, 'Estudios Primarios', NULL, 1, 3); -- Encuesta en ESO (Sin Internet, caída de ingresos)

-- 3. Expediente de la Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2016002', '87654321B', 'Sara Teijeiro Gómez', '2013-11-23', 'sara.teijeiro@alumno.com', 'RESP002');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2016002', '2022-06-18', 5, 'PRI-GEN', 'C006'), -- Admitida en 5º de Primaria en CEIP Cidade Vella
('EXP2016002', '2025-07-10', 1, 'ESO-GEN', 'I003'); -- Admitida en 1º de ESO en IES Agra do Orzán

-- 5. Historial Longitudinal de Matrículas (Incluye la Repetición de 6º de Primaria)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria (CEIP Cidade Vella)
('MAT-SARA-PRI5',  '2022-09-01', '2022/2023', 'EXP2016002', 'C006', 5, 'PRI-GEN'), -- 5º Primaria (Aprobado raspado)
('MAT-SARA-PRI6',  '2023-09-03', '2023/2024', 'EXP2016002', 'C006', 6, 'PRI-GEN'), -- 6º Primaria (1er intento - Suspenso)
('MAT-SARA-PRI6R', '2024-09-02', '2024/2025', 'EXP2016002', 'C006', 6, 'PRI-GEN'), -- 6º Primaria (Repetición - Aprobado)
-- Educación Secundaria - ESO (IES Agra do Orzán)
('MAT-SARA-ESO1',  '2025-09-02', '2025/2026', 'EXP2016002', 'I003',      1, 'ESO-GEN'); -- 1º ESO (Curso actual)

-- 6. Adaptación Curricular (Registrada durante su repetición en Primaria)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP002', '2024-09-15', 'Apoyo Educativo', 'La alumna presenta un desfase acumulado en competencia matemática y lectora desde el segundo ciclo de primaria. Requiere adaptaciones metodológicas no significativas.', 'EXP2016002');

-- Asociar Adaptación a las Asignaturas instrumentales de Primaria y ESO
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP002', 'PRI6-MAT'),
('ADAP002', 'PRI6-LCL'),
('ADAP002', 'ESO1-MAT');

-- 7. Historial de Calificaciones
-- A. 5º PRIMARIA (2022/2023 - Rendimiento muy justo)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI5-LCL', 'MAT-SARA-PRI5', false), ('PRI5-MAT', 'MAT-SARA-PRI5', false), ('PRI5-ING', 'MAT-SARA-PRI5', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI5-LCL', 'MAT-SARA-PRI5', 'Final Ordinaria', 5.50),
('PRI5-MAT', 'MAT-SARA-PRI5', 'Final Ordinaria', 5.00),
('PRI5-ING', 'MAT-SARA-PRI5', 'Final Ordinaria', 5.00);

-- B. 6º PRIMARIA (2023/2024 - 1er Intento - Fracaso y decisión de repetir)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-SARA-PRI6', false), ('PRI6-MAT', 'MAT-SARA-PRI6', false), ('PRI6-ING', 'MAT-SARA-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-SARA-PRI6', 'Final Ordinaria', 4.50), -- Suspenso
('PRI6-MAT', 'MAT-SARA-PRI6', 'Final Ordinaria', 3.00), -- Suspenso severo
('PRI6-ING', 'MAT-SARA-PRI6', 'Final Ordinaria', 5.00); -- Aprobado raspado

-- C. 6º PRIMARIA (2024/2025 - Repetición - Consigue superar la etapa con adaptaciones)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-SARA-PRI6R', false), ('PRI6-MAT', 'MAT-SARA-PRI6R', false), ('PRI6-ING', 'MAT-SARA-PRI6R', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-SARA-PRI6R', 'Final Ordinaria', 6.00),
('PRI6-MAT', 'MAT-SARA-PRI6R', 'Final Ordinaria', 5.00), -- Consigue el aprobado
('PRI6-ING', 'MAT-SARA-PRI6R', 'Final Ordinaria', 5.50);

-- D. 1º ESO - CURSO ACTUAL (2025/2026 - Choque severo, hundiéndose en la 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-SARA-ESO1', false), ('ESO1-MAT', 'MAT-SARA-ESO1', false), ('ESO1-ING', 'MAT-SARA-ESO1', false), ('ESO1-GH', 'MAT-SARA-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-SARA-ESO1', '1ª Evaluación', 4.00), -- Suspenso en Lengua
('ESO1-MAT', 'MAT-SARA-ESO1', '1ª Evaluación', 2.00), -- Suspenso crítico en Matemáticas
('ESO1-ING', 'MAT-SARA-ESO1', '1ª Evaluación', 3.50), -- Suspenso en Inglés
('ESO1-GH',  'MAT-SARA-ESO1', '1ª Evaluación', 4.50); -- Suspenso en Geografía e Historia
