-- CASO DE ESTUDIO 1: ALEJANDRO IGLESIAS CASTRO (ALUMNO DE CONTROL - BACHILLERATO ACTIVO)
-- Archivo: alumno_1_control.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsable Legal (Beatriz Castro Varela y Daniel Iglesias Otero)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP001', 'Beatriz Castro Varela', 'Daniel Iglesias Otero', '600111222', '600333444', 'beatriz.castro@email.com', 'daniel.iglesias@email.com', 'Rúa Cantón Grande 4, 4º Izq, CP 15003, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Nivel de riesgo bajo, alta conectividad y equipamiento)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP001', '2012-09-10', 26000.00, true, 'Estudios Secundarios', 'Grado Universitario', 1, 4), -- En Infantil
('RESP001', '2017-09-15', 28000.00, true, 'Estudios Secundarios', 'Grado Universitario', 2, 4), -- En Primaria
('RESP001', '2021-09-10', 29500.00, true, 'Estudios Secundarios', 'Grado Universitario', 2, 4); -- En ESO

-- 3. Expediente del Estudiante (Nacido en 2009 para estar en edad de Bachillerato)
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015001', '12345678A', 'Alejandro Iglesias Castro', '2009-04-15', 'alejandro.iglesias@alumno.com', 'RESP001');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015001', '2012-06-12', 1, 'INF-GEN', 'C001'), -- Admitido en Infantil en CEIP Emilia Pardo Bazán
('EXP2015001', '2021-07-05', 1, 'ESO-GEN', 'I001'), -- Admitido en ESO en IES Eusebio da Guarda
('EXP2015001', '2025-06-25', 1, 'BAC-CIEN', 'I001'); -- Admitido en Bachillerato en IES Eusebio da Guarda

-- 5. Historial Longitudinal de Matrículas Anuales (Trayectoria de Éxito)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Infantil (CEIP Emilia Pardo Bazán)
('MAT-ALE-INF3', '2014-09-01', '2014/2015', 'EXP2015001', 'C001', 3, 'INF-GEN'), -- 3º Infantil
-- Educación Primaria (CEIP Emilia Pardo Bazán)
('MAT-ALE-PRI1', '2015-09-03', '2015/2016', 'EXP2015001', 'C001', 1, 'PRI-GEN'), -- 1º Primaria
('MAT-ALE-PRI3', '2017-09-04', '2017/2018', 'EXP2015001', 'C001', 3, 'PRI-GEN'), -- 3º Primaria
('MAT-ALE-PRI6', '2020-09-01', '2020/2021', 'EXP2015001', 'C001', 6, 'PRI-GEN'), -- 6º Primaria
-- Educación Secundaria - ESO (IES Eusebio da Guarda)
('MAT-ALE-ESO1', '2021-09-01', '2021/2022', 'EXP2015001', 'I001', 1, 'ESO-GEN'), -- 1º ESO
('MAT-ALE-ESO2', '2022-09-01', '2022/2023', 'EXP2015001', 'I001', 2, 'ESO-GEN'), -- 2º ESO
('MAT-ALE-ESO3', '2023-09-01', '2023/2024', 'EXP2015001', 'I001', 3, 'ESO-GEN'), -- 3º ESO
('MAT-ALE-ESO4', '2024-09-02', '2024/2025', 'EXP2015001', 'I001', 4, 'ESO-GEN'), -- 4º ESO (Titulación con 16 años)
-- Bachillerato (IES Eusebio da Guarda)
('MAT-ALE-BAC1', '2025-09-01', '2025/2026', 'EXP2015001', 'I001', 1, 'BAC-CIEN'); -- 1º Bachillerato (Curso actual)

-- 6. Historial de Calificaciones (Rendimiento Sobresaliente)
-- A. 3º INFANTIL (2014/2015)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('INF3-CRE', 'MAT-ALE-INF3', false), ('INF3-DES', 'MAT-ALE-INF3', false), ('INF3-COM', 'MAT-ALE-INF3', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('INF3-CRE', 'MAT-ALE-INF3', 'Final Ordinaria', 9.00),
('INF3-DES', 'MAT-ALE-INF3', 'Final Ordinaria', 8.50),
('INF3-COM', 'MAT-ALE-INF3', 'Final Ordinaria', 9.00);

-- B. 1º PRIMARIA (2015/2016)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI1-LCL', 'MAT-ALE-PRI1', false), ('PRI1-MAT', 'MAT-ALE-PRI1', false), ('PRI1-ING', 'MAT-ALE-PRI1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI1-LCL', 'MAT-ALE-PRI1', 'Final Ordinaria', 8.50),
('PRI1-MAT', 'MAT-ALE-PRI1', 'Final Ordinaria', 8.00),
('PRI1-ING', 'MAT-ALE-PRI1', 'Final Ordinaria', 9.00);

-- C. 3º PRIMARIA (2017/2018)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI3-LCL', 'MAT-ALE-PRI3', false), ('PRI3-MAT', 'MAT-ALE-PRI3', false), ('PRI3-ING', 'MAT-ALE-PRI3', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI3-LCL', 'MAT-ALE-PRI3', 'Final Ordinaria', 8.00),
('PRI3-MAT', 'MAT-ALE-PRI3', 'Final Ordinaria', 8.50),
('PRI3-ING', 'MAT-ALE-PRI3', 'Final Ordinaria', 8.50);

-- D. 6º PRIMARIA (2020/2021)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-ALE-PRI6', false), ('PRI6-MAT', 'MAT-ALE-PRI6', false), ('PRI6-ING', 'MAT-ALE-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-ALE-PRI6', 'Final Ordinaria', 8.50),
('PRI6-MAT', 'MAT-ALE-PRI6', 'Final Ordinaria', 9.00),
('PRI6-ING', 'MAT-ALE-PRI6', 'Final Ordinaria', 9.00);

-- E. 4º ESO (2024/2025 - Graduación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO4-LCL', 'MAT-ALE-ESO4', false), ('ESO4-MATE', 'MAT-ALE-ESO4', false), ('ESO4-ING', 'MAT-ALE-ESO4', false), ('ESO4-GH', 'MAT-ALE-ESO4', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO4-LCL', 'MAT-ALE-ESO4', 'Final Ordinaria', 8.50),
('ESO4-MATE', 'MAT-ALE-ESO4', 'Final Ordinaria', 8.00),
('ESO4-ING', 'MAT-ALE-ESO4', 'Final Ordinaria', 9.00),
('ESO4-GH',  'MAT-ALE-ESO4', 'Final Ordinaria', 8.50);

-- F. 1º BACHILLERATO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('BAC1-LCL', 'MAT-ALE-BAC1', false), ('BAC1-MAT1', 'MAT-ALE-BAC1', false), ('BAC1-FQ', 'MAT-ALE-BAC1', false), ('BAC1-ING1', 'MAT-ALE-BAC1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('BAC1-LCL', 'MAT-ALE-BAC1', '1ª Evaluación', 8.50),
('BAC1-MAT1', 'MAT-ALE-BAC1', '1ª Evaluación', 9.00),
('BAC1-FQ',  'MAT-ALE-BAC1', '1ª Evaluación', 8.50),
('BAC1-ING1', 'MAT-ALE-BAC1', '1ª Evaluación', 9.00);
