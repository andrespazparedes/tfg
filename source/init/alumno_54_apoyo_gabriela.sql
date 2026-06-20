-- CASO DE ESTUDIO 54: GABRIELA BLANCO CASTRO (ALUMNA CON ALTAS CAPACIDADES / BAJO RENDIMIENTO POR DESMOTIVACIÓN / NEAE)
-- Archivo: alumno_54_apoyo_gabriela.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Sergio Blanco Otero y María Castro Veiga)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP054', 'Sergio Blanco Otero', 'María Castro Veiga', '600540011', '600540022', 'sergio.blanco.o@email.com', 'maria.castro.v@email.com', 'Rúa Real 30, N/A, CP 15003, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos estables y nula brecha digital)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP054', '2023-09-10', 31500.00, true, 'Estudios Universitarios', 'Estudios Universitarios', 3, 3), -- Encuesta en Primaria
('RESP054', '2025-09-12', 32000.00, true, 'Estudios Universitarios', 'Estudios Universitarios', 3, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015054', '12345679A', 'Gabriela Blanco Castro', '2012-07-09', 'gabriela.blanco.c@alumno.com', 'RESP054');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015054', '2023-06-15', 6, 'PRI-GEN', 'C001'), -- CEIP Emilia Pardo Bazán
('EXP2015054', '2024-07-04', 1, 'ESO-GEN', 'I001'); -- IES Eusebio da Guarda

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-GAB2-PRI6', '2023-09-01', '2023/2024', 'EXP2015054', 'C001', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-GAB2-ESO1', '2024-09-02', '2024/2025', 'EXP2015054', 'I001', 1, 'ESO-GEN'),
('MAT-GAB2-ESO2', '2025-09-01', '2025/2026', 'EXP2015054', 'I001', 2, 'ESO-GEN'); -- Curso actual

-- 6. Adaptación Curricular / NEAE por Altas Capacidades (Activada en 2º de ESO por el departamento de orientación ante desenganche y subrendimiento escolar)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP054', '2025-10-15', 'Apoyo Educativo - Enriquecimiento AACC', 'Estudiante diagnosticada con Altas Capacidades Intelectuales (CI >130). Presenta aburrimiento sistemático en el aula, desmotivación hacia tareas rutinarias y un notable subrendimiento (calificaciones raspadas pese a su potencial). Se prescribe Plan de Enriquecimiento Curricular Horizontal y ampliación de retos en áreas científicas y tecnológicas.', 'EXP2015054');

-- Relacionamos la adaptación con Matemáticas y Física y Química
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP054', 'ESO2-MAT'),
('ADAP054', 'ESO2-FQ');

-- 7. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024 - Rendimiento brillante ordinario)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-GAB2-PRI6', false), ('PRI6-MAT', 'MAT-GAB2-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-GAB2-PRI6', 'Final Ordinaria', 8.50),
('PRI6-MAT', 'MAT-GAB2-PRI6', 'Final Ordinaria', 9.00);

-- B. 1º ESO (2024/2025 - Caída inicial de rendimiento por falta de hábito e interés)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-GAB2-ESO1', false), ('ESO1-MAT', 'MAT-GAB2-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-GAB2-ESO1', 'Final Ordinaria', 6.00), -- Subrendimiento
('ESO1-MAT', 'MAT-GAB2-ESO1', 'Final Ordinaria', 5.50); -- Subrendimiento severo

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación - Estabilizándose con enriquecimiento curricular activo)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-GAB2-ESO2', false), ('ESO2-MAT', 'MAT-GAB2-ESO2', false), ('ESO2-FQ', 'MAT-GAB2-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-GAB2-ESO2', '1ª Evaluación', 6.50), -- Bien
('ESO2-MAT', 'MAT-GAB2-ESO2', '1ª Evaluación', 7.50), -- Notable (¡Respuesta positiva al enriquecimiento!)
('ESO2-FQ',  'MAT-GAB2-ESO2', '1ª Evaluación', 7.00); -- Notable (¡Respuesta positiva!)
