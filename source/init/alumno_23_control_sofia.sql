-- CASO DE ESTUDIO 23: SOFÍA BLANCO CASTRO (ALUMNA DE CONTROL / RENDIMIENTO EXCELENTE)
-- Archivo: alumno_23_control_sofia.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Santiago Blanco Varela y Marta Castro Otero)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP023', 'Santiago Blanco Varela', 'Marta Castro Otero', '600230011', '600230022', 'santiago.blanco@email.com', 'marta.castro@email.com', 'Rúa Juana de Vega 12, 5º Der, CP 15004, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos estables de clase media-alta y nula brecha digital)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP023', '2023-09-10', 35000.00, true, 'Estudios Universitarios', 'Estudios Universitarios', 2, 3), -- Encuesta en Primaria
('RESP023', '2025-09-12', 34000.00, true, 'Estudios Universitarios', 'Estudios Universitarios', 2, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015023', '12341234C', 'Sofía Blanco Castro', '2012-07-15', 'sofia.blanco@alumno.com', 'RESP023');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015023', '2023-06-15', 6, 'PRI-GEN', 'C001'), -- CEIP Emilia Pardo Bazán
('EXP2015023', '2024-07-03', 1, 'ESO-GEN', 'I001'); -- IES Eusebio da Guarda

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-SOFI-PRI6', '2023-09-01', '2023/2024', 'EXP2015023', 'C001', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-SOFI-ESO1', '2024-09-02', '2024/2025', 'EXP2015023', 'I001', 1, 'ESO-GEN'),
('MAT-SOFI-ESO2', '2025-09-01', '2025/2026', 'EXP2015023', 'I001', 2, 'ESO-GEN'); -- Curso actual

-- 6. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-SOFI-PRI6', false), ('PRI6-MAT', 'MAT-SOFI-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-SOFI-PRI6', 'Final Ordinaria', 9.00),
('PRI6-MAT', 'MAT-SOFI-PRI6', 'Final Ordinaria', 9.50);

-- B. 1º ESO (2024/2025)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-SOFI-ESO1', false), ('ESO1-MAT', 'MAT-SOFI-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-SOFI-ESO1', 'Final Ordinaria', 9.00),
('ESO1-MAT', 'MAT-SOFI-ESO1', 'Final Ordinaria', 9.00);

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-SOFI-ESO2', false), ('ESO2-MAT', 'MAT-SOFI-ESO2', false), ('ESO2-FQ', 'MAT-SOFI-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-SOFI-ESO2', '1ª Evaluación', 9.00), -- Sobresaliente
('ESO2-MAT', 'MAT-SOFI-ESO2', '1ª Evaluación', 9.50), -- Sobresaliente
('ESO2-FQ',  'MAT-SOFI-ESO2', '1ª Evaluación', 9.00); -- Sobresaliente
