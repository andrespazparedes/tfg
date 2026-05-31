-- CASO DE ESTUDIO 3: HUGO PINTOS VARELA (ALUMNO EN DIVERSIFICACIÓN - INTERVENCIÓN DE ÉXITO)
-- Archivo: alumno_3_intervencion.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsable Legal (Manuel Pintos Otero y Elena Varela Sanz)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP003', 'Manuel Pintos Otero', 'Elena Varela Sanz', '622333444', '633444555', 'manuel.pintos@email.com', 'elena.varela@email.com', 'Rúa Ancha 7, 2ºA, CP 15001, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos bajos-medios, acceso básico a internet)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP003', '2022-09-12', 16500.00, true, 'Estudios Primarios', 'Estudios Secundarios', 1, 4), -- Encuesta en Primaria
('RESP003', '2025-09-12', 17500.00, true, 'Estudios Primarios', 'Estudios Secundarios', 1, 4); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2014003', '56781234C', 'Hugo Pintos Varela', '2011-08-30', 'hugo.pintos@alumno.com', 'RESP003');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2014003', '2022-07-01', 6, 'PRI-GEN', 'C005'), -- Admitido en 6º de Primaria en CEIP Ramón de la Sagra
('EXP2014003', '2023-07-05', 1, 'ESO-GEN', 'I002'); -- Admitido en 1º de ESO en IES Fernando Wirtz Suárez

-- 5. Historial Longitudinal de Matrículas Anuales (Desgaste en ordinario, rescate en Diversificación)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria (CEIP Ramón de la Sagra)
('MAT-HUGO-PRI6',  '2022-09-01', '2022/2023', 'EXP2014003', 'C005',  6, 'PRI-GEN'), -- 6º Primaria (Paso muy justo)
-- Educación Secundaria - ESO Ordinario (IES Fernando Wirtz Suárez)
('MAT-HUGO-ESO1',  '2023-09-01', '2023/2024', 'EXP2014003', 'I002',  1, 'ESO-GEN'), -- 1º ESO (Paso muy justo)
('MAT-HUGO-ESO2',  '2024-09-01', '2024/2025', 'EXP2014003', 'I002',  2, 'ESO-GEN'), -- 2º ESO (Fracaso severo, al borde del abandono)
-- ESO - Programa de Diversificación Curricular (IES Fernando Wirtz Suárez)
('MAT-HUGO-ESOD3', '2025-09-01', '2025/2026', 'EXP2014003', 'I002',  3, 'ESO-DIV'); -- 3º ESO Diversificación (Curso actual)

-- 6. Historial de Calificaciones
-- A. 6º PRIMARIA (2022/2023 - Aprobado muy justo)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-HUGO-PRI6', false), ('PRI6-MAT', 'MAT-HUGO-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-HUGO-PRI6', 'Final Ordinaria', 6.00),
('PRI6-MAT', 'MAT-HUGO-PRI6', 'Final Ordinaria', 5.50);

-- B. 1º ESO (2023/2024 - Empieza el retroceso en secundaria)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-HUGO-ESO1', false), ('ESO1-MAT', 'MAT-HUGO-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-HUGO-ESO1', 'Final Ordinaria', 5.00),
('ESO1-MAT', 'MAT-HUGO-ESO1', 'Final Ordinaria', 5.00);

-- C. 2º ESO (2024/2025 - Hundimiento total, fracaso escolar ordinario)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-HUGO-ESO2', false), ('ESO2-MAT', 'MAT-HUGO-ESO2', false), ('ESO2-FQ', 'MAT-HUGO-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-HUGO-ESO2', 'Final Ordinaria', 4.00), -- Suspenso
('ESO2-MAT', 'MAT-HUGO-ESO2', 'Final Ordinaria', 3.00), -- Suspenso severo
('ESO2-FQ',  'MAT-HUGO-ESO2', 'Final Ordinaria', 3.00); -- Suspenso severo

-- D. 3º ESO DIVERSIFICACIÓN - CURSO ACTUAL (2025/2026 - Recuperación gracias a los Ámbitos adaptados)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESOD3-ACT', 'MAT-HUGO-ESOD3', false), ('ESOD3-ALS', 'MAT-HUGO-ESOD3', false), ('ESOD3-ING', 'MAT-HUGO-ESOD3', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESOD3-ACT', 'MAT-HUGO-ESOD3', '1ª Evaluación', 6.50), -- Aprobado holgado en Ámbito Científico-Tecnológico
('ESOD3-ALS', 'MAT-HUGO-ESOD3', '1ª Evaluación', 7.00), -- Notable bajo en Ámbito Lingüístico-Social
('ESOD3-ING', 'MAT-HUGO-ESOD3', '1ª Evaluación', 6.00); -- Aprobado holgado en Inglés
