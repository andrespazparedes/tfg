-- CASO DE ESTUDIO 1: ALEJANDRO IGLESIAS CASTRO (ALUMNO DE CONTROL)
-- Archivo: alumno_1_control.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsable Legal (Beatriz Castro Varela y Daniel Iglesias Otero)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP001', 'Beatriz Castro Varela', 'Daniel Iglesias Otero', '600111222', '600333444', 'beatriz.castro@email.com', 'daniel.iglesias@email.com', 'Rúa Cantón Grande 4, 4º Izq, CP 15003, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP001', '2015-09-10', 26000.00, true, 'Estudios Secundarios', 'Grado Universitario', 1, 4), -- En Infantil
('RESP001', '2020-09-15', 28000.00, true, 'Estudios Secundarios', 'Grado Universitario', 2, 4), -- En Primaria
('RESP001', '2025-09-10', 29500.00, true, 'Estudios Secundarios', 'Grado Universitario', 2, 4); -- En ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015001', '12345678A', 'Alejandro Iglesias Castro', '2012-04-15', 'alejandro.iglesias@alumno.com', 'RESP001');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015001', '2015-06-12', 1, 'INF-GEN', 'C001'), -- Admitido en Infantil en CEIP Emilia Pardo Bazán
('EXP2015001', '2024-07-05', 1, 'ESO-GEN', 'I001'); -- Admitido en ESO en IES Eusebio da Guarda

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Infantil (CEIP Emilia Pardo Bazán)
('MAT-ALE-INF3', '2017-09-01', '2017/2018', 'EXP2015001', 'C001', 3, 'INF-GEN'), -- 3º Infantil (5 años)
-- Educación Primaria (CEIP Emilia Pardo Bazán)
('MAT-ALE-PRI1', '2018-09-03', '2018/2019', 'EXP2015001', 'C001', 1, 'PRI-GEN'), -- 1º Primaria
('MAT-ALE-PRI3', '2020-09-02', '2020/2021', 'EXP2015001', 'C001', 3, 'PRI-GEN'), -- 3º Primaria
('MAT-ALE-PRI6', '2023-09-01', '2023/2024', 'EXP2015001', 'C001', 6, 'PRI-GEN'), -- 6º Primaria
-- Educación Secundaria - ESO (IES Eusebio da Guarda)
('MAT-ALE-ESO1', '2024-09-02', '2024/2025', 'EXP2015001', 'I001', 1, 'ESO-GEN'), -- 1º ESO
('MAT-ALE-ESO2', '2025-09-01', '2025/2026', 'EXP2015001', 'I001', 2, 'ESO-GEN'); -- 2º ESO (Curso actual)

-- 6. Historial de Calificaciones
-- A. 3º INFANTIL (2017/2018)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('INF3-CRE', 'MAT-ALE-INF3', false), ('INF3-DES', 'MAT-ALE-INF3', false), ('INF3-COM', 'MAT-ALE-INF3', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('INF3-CRE', 'MAT-ALE-INF3', 'Final Ordinaria', 9.00),
('INF3-DES', 'MAT-ALE-INF3', 'Final Ordinaria', 8.50),
('INF3-COM', 'MAT-ALE-INF3', 'Final Ordinaria', 9.00);

-- B. 1º PRIMARIA (2018/2019)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI1-LCL', 'MAT-ALE-PRI1', false), ('PRI1-MAT', 'MAT-ALE-PRI1', false), ('PRI1-ING', 'MAT-ALE-PRI1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI1-LCL', 'MAT-ALE-PRI1', 'Final Ordinaria', 8.50),
('PRI1-MAT', 'MAT-ALE-PRI1', 'Final Ordinaria', 8.00),
('PRI1-ING', 'MAT-ALE-PRI1', 'Final Ordinaria', 9.00);

-- C. 3º PRIMARIA (2020/2021)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI3-LCL', 'MAT-ALE-PRI3', false), ('PRI3-MAT', 'MAT-ALE-PRI3', false), ('PRI3-ING', 'MAT-ALE-PRI3', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI3-LCL', 'MAT-ALE-PRI3', 'Final Ordinaria', 8.00),
('PRI3-MAT', 'MAT-ALE-PRI3', 'Final Ordinaria', 8.50),
('PRI3-ING', 'MAT-ALE-PRI3', 'Final Ordinaria', 8.50);

-- D. 6º PRIMARIA (2023/2024)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-ALE-PRI6', false), ('PRI6-MAT', 'MAT-ALE-PRI6', false), ('PRI6-ING', 'MAT-ALE-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-ALE-PRI6', 'Final Ordinaria', 8.50),
('PRI6-MAT', 'MAT-ALE-PRI6', 'Final Ordinaria', 9.00),
('PRI6-ING', 'MAT-ALE-PRI6', 'Final Ordinaria', 9.00);

-- E. 1º ESO (2024/2025)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-ALE-ESO1', false), ('ESO1-MAT', 'MAT-ALE-ESO1', false), ('ESO1-ING', 'MAT-ALE-ESO1', false), ('ESO1-GH', 'MAT-ALE-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-ALE-ESO1', 'Final Ordinaria', 8.00),
('ESO1-MAT', 'MAT-ALE-ESO1', 'Final Ordinaria', 8.50),
('ESO1-ING', 'MAT-ALE-ESO1', 'Final Ordinaria', 9.00),
('ESO1-GH',  'MAT-ALE-ESO1', 'Final Ordinaria', 8.50);

-- F. 2º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-ALE-ESO2', false), ('ESO2-MAT', 'MAT-ALE-ESO2', false), ('ESO2-ING', 'MAT-ALE-ESO2', false), ('ESO2-FQ', 'MAT-ALE-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-ALE-ESO2', '1ª Evaluación', 8.50),
('ESO2-MAT', 'MAT-ALE-ESO2', '1ª Evaluación', 8.00),
('ESO2-ING', 'MAT-ALE-ESO2', '1ª Evaluación', 9.50),
('ESO2-FQ',  'MAT-ALE-ESO2', '1ª Evaluación', 8.00);
